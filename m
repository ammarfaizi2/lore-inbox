Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbRGJR50>; Tue, 10 Jul 2001 13:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbRGJR5G>; Tue, 10 Jul 2001 13:57:06 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:56564 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267014AbRGJR4y>; Tue, 10 Jul 2001 13:56:54 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107101756.f6AHumn0022156@webber.adilger.int>
Subject: Re: 2.4.6-preX, 2.4.6...
In-Reply-To: <3B4B1AFB.1090506@srci.iwpsd.org> "from Joshua M. Schmidlkofer at
 Jul 10, 2001 09:10:51 am"
To: "Joshua M. Schmidlkofer" <menion@srci.iwpsd.org>
Date: Tue, 10 Jul 2001 11:56:46 -0600 (MDT)
CC: Linux kernel Development Mailing List 
	<linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua writes:
> I have not located exactly [in which patch] the problem began, but if 
> try to boot w/2.4.6-preX - 2.4.6,  the video goes away. And then it 
> seems to lock up the computer.   At first I had APGART + DRI + MatroxFB. 
>   So I removed the FB drivers, and tried again.   Same problems.   So I 
> modularized Agpart, and DRI, [I need them for my X config].  No Change. 
>   Almost immediatly after 'Uncompressing Linux.....'   I see a rush of 
> the text across the screen, and then the screen flashes, and blinks, and 
> then nothing.   I do not even have a  chance to see anything at all.  

It _sounds_ like an X server problem (screen flashing, going blank).  Do
you have another machine available to see if the computer is still alive
(via ping, telnet, ssh, etc), or a serial console?

You could try setting your runlevel to 3 in /etc/inittab, or booting with
"single" on the kernel command line to avoid starting X right away at boot.
If the system boots to single user mode, then it is X that is the problem
(or at least a bad interaction between X and your kernel).

> I can't tell what's locking up, I tried a SysRQ, but got nothing.   No 
> screen. *sigh*   I am not equiped to do this over a serial or parallel 
> port.   I was hoping that someone would have a clue.  

When you say SysRQ, does this include SysRQ-B for rebooting?  If so, that
may indicate a total lockup.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
