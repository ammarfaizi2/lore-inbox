Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSEVS1h>; Wed, 22 May 2002 14:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSEVS0T>; Wed, 22 May 2002 14:26:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58885 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316644AbSEVSZT>; Wed, 22 May 2002 14:25:19 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 22 May 2002 18:46:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CEBC496.9030900@evision-ventures.com> from "Martin Dalecki" at May 22, 2002 06:17:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AaCR-0002NK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW> Under java it's rather hard to get around
> CAP_RAWIO if you ask me without going down to JNI.

People run them as root. Thats not rocket science

> > I've seen it used in tools written in java, python, perl, even tcl
> > 
> > Other examples include libieee1284, the pic 16x84 programmer, hwclock,
> > older kbdrate, /sbin/clock on machines that don't have /dev/rtc.
> 
> All the examples above are samples of bad coding practice - I have
> uncovered already here in C what can be expected inside there!

Portable code is good practice.

> > Not everything in the world is an x86, and not every app wants to be Linux/x86
> > specific or use weird syscalls
> 
> Yes and in esp. everything in the world is a __m68000__!

When you look at the kernel codebase its abundantly obvious that its much
more "if its not 32bit with hardware managed caches, little endian, with
no more than one root pci bridge, has a 32/64bit machine word, is byte 
addressed, has sane store ordering rules, conventional not reverse mapped
mmu, machine word sized cache coherency, and no more than 3 level page
tables" and so forth its going to be hard to get it to work well.
 
A lot of that /dev/port using code is portable to everything from Minix through
most BSD's. It works on pretty much anything with PC style devices.

Alan
