Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSHOMjq>; Thu, 15 Aug 2002 08:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSHOMjq>; Thu, 15 Aug 2002 08:39:46 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:6666 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S316883AbSHOMjp>;
	Thu, 15 Aug 2002 08:39:45 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: serial console (was Re: [patch] printk from userspace)
Date: Thu, 15 Aug 2002 12:43:23 +0000 (UTC)
Organization: Cistron
Message-ID: <ajg7lb$rtr$2@ncc1701.cistron.net>
References: <ajd2k5$h8l$1@ncc1701.cistron.net> <87eld1s9l7.fsf_-_@arm.t19.ds.pwr.wroc.pl>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1029415403 28603 62.216.29.67 (15 Aug 2002 12:43:23 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <87eld1s9l7.fsf_-_@arm.t19.ds.pwr.wroc.pl>,
Arkadiusz Miskiewicz  <misiek@pld.ORG.PL> wrote:
>btw. is there any reason to not display initscripts messages
>on all consoles in such setup:
>append="console=tty0 console=ttyS0,57600n8"
>serial=0,57600n8
>?

Yes. It is not implemented in the kernel and it would not
be trivial to do so (or even wanted)

>kernel messages are available on both - tty0 and ttyS0 while
>userspace messages (from initscripts) only on last specified
>- in such case ttyS0. 

That's because printk() in the kernel uses a very different codepath than
the userland write(console, "hello")

Mike.

