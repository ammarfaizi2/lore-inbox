Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSHOLa5>; Thu, 15 Aug 2002 07:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSHOLa5>; Thu, 15 Aug 2002 07:30:57 -0400
Received: from perfo.perfopol.pl ([213.25.186.10]:34572 "EHLO mail.perfopol.pl")
	by vger.kernel.org with ESMTP id <S316792AbSHOLa4> convert rfc822-to-8bit;
	Thu, 15 Aug 2002 07:30:56 -0400
To: linux-kernel@vger.kernel.org
Subject: serial console (was Re: [patch] printk from userspace)
X-Attribution: arekm
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
Organization: PLD Linux Distribution Team
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Date: 14 Aug 2002 18:12:36 +0200
In-Reply-To: <ajd2k5$h8l$1@ncc1701.cistron.net>
Message-ID: <87eld1s9l7.fsf_-_@arm.t19.ds.pwr.wroc.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.90
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miquel van Smoorenburg" <miquels@cistron.nl> writes:

> I have a bootlogd that does a TIOCCONS on /dev/console, so
> that it can capture all messages written to /dev/console.
> 
> It buffers the messages in-memory, until it is able to open
> a logfile in /var/log/ at which point it writes the buffered
> data to the logfile, and starts logging to that file.
> 
> The only problem is that TIOCCONS is a redirect, so there's no
> output to the console anymore. 
btw. is there any reason to not display initscripts messages
on all consoles in such setup:
append="console=tty0 console=ttyS0,57600n8"
serial=0,57600n8
?

kernel messages are available on both - tty0 and ttyS0 while
userspace messages (from initscripts) only on last specified
- in such case ttyS0. 

> Mike.

-- 
Arkadiusz Mi¶kiewicz   IPv6 ready PLD Linux at http://www.pld.org.pl
misiek(at)pld.org.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PWr
