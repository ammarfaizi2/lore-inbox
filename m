Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271970AbRIDNbL>; Tue, 4 Sep 2001 09:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271972AbRIDNax>; Tue, 4 Sep 2001 09:30:53 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:7134 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S271970AbRIDNad>;
	Tue, 4 Sep 2001 09:30:33 -0400
Message-Id: <5.1.0.14.2.20010904141808.0274fbd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 04 Sep 2001 14:30:36 +0100
To: Rastislav Stanik <rastos@woctni.sk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Should I use Linux to develop driver for specialized ISA
  card?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.010904145710.rastos@woctni.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:57 04/09/01, Rastislav Stanik wrote:
>I'm developing specialized plotter.
>The moving parts of the plotter are controlled by ISA card that generates
>(and responds to) interrupts on each movement or printing event.
>The interrupts can be generated quite fast; up to frequency of 4kHz.
>
>I need to write a driver for that.
>The 1st prototype is developed in MS-DOS,but I hit problem with memory.
>The driver needs to use (and transfer) quite big chunks of memory.
>1MB is not enough.
>
>In NT you don't develop drivers so easily. It is actually a pain.
>Therefore I'm considering Linux. The machine would be probably
>dedicated and, may be later, embeded in the plotter.
>Problems:
>- It is unlikely that my driver would ever make it to main-stream kernel 
>source.

Why should this is be a problem? - Considering you are talking embedded 
devices here you just need to take a stable kernel, write your driver for 
it and never change kernel. No need. Also you might want to consider one of 
the embedded/realtime Linux offerings out there.

>- I'm just a C/C++ programmer, I have just rough idea what does it mean to
>'develop a driver in Linux'. I'm pretty familiar with Linux as sys-admin 
>though.
>
>All I need is: to have piece of code executed on some interrupt,
>read/write IO ports of the card and be able to transfer big pieces
>of memory to the card.

Read A. Rubbini's Linux Device Drivers 2nd ed from O'Reilly. Have a look at 
http://www.oreilly.com/catalog/linuxdrive2/ where you can also find the 
online edition of the book.

>What do you think? Is Linux the ideal platform for me?

Of course! But then again I am biased. (-; To what other OS do you have all 
the source code with the rights modify it at will? And for what other OS 
can you get help while developing drivers in such an efficient manner as is 
possible with LKML and the other Linux mailinglists/newsgroups/irc? I have 
no idea about ISA handling and Linux so can't comment on technicallities of 
this but in view of embedding it, Linux is probably a good choice for you.

HTH,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

