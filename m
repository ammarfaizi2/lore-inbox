Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281360AbRKLIqI>; Mon, 12 Nov 2001 03:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281362AbRKLIp7>; Mon, 12 Nov 2001 03:45:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29963 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281360AbRKLIpx>; Mon, 12 Nov 2001 03:45:53 -0500
Subject: Re: HFS Filesystem
To: sibaz@sibaz.com (Simon Bazley)
Date: Mon, 12 Nov 2001 08:53:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BEF18BA.41D7F503@sibaz.com> from "Simon Bazley" at Nov 12, 2001 12:32:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163CqK-00057r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What information or documentation is there on HFS and writing linux 
> applications what use resource forks and other mac quirkiness.
> In particular how do I write an application that uses all the data 
> availiable on macs (and hence HFS) but not commonly used.  Whats more if 
> there is a method to access that data, what happens if I try using it on a
> non HFS file system.

netatalk uses its own resource fork magic using .AppleDouble directories
or a few other configurable formats. HFS on 2.2 also supports the same
format so magically you can get real fork access

For 2.4 the HFS code still needs some serious cleanup, and for 2.5 I suspect
either someone fixes the locking on or it gets deleted
