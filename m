Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135823AbRDYHAG>; Wed, 25 Apr 2001 03:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135824AbRDYG7z>; Wed, 25 Apr 2001 02:59:55 -0400
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:30472 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S135823AbRDYG7r>;
	Wed, 25 Apr 2001 02:59:47 -0400
Date: Wed, 25 Apr 2001 08:59:44 +0200 (CEST)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Weird problem with 2.4.4-pre6
Message-ID: <Pine.LNX.4.30.0104250842420.13663-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday, I was running tcpdump, paging the output with less.  All of a
sudden, less started to dump core (SIGSEGV).  I could not even start less
by itself:

    > less

without it getting a SIGSEGV, and in fact no user could run less without
getting a SIGSEGV, but it did work perfectly a few minutes earlier.  This
morning, I tried to run less again, and now it was working!  No core
dumps!

How can this happen?  Something overwriting the page/buffer cache?
Unfortunately, I don't know how to reproduce it.  I'm writing this because
it was so strange that I felt I had to share it.  There are no messages in
the (dmesg) log.

/Tobias, a little bit worried


Semi-random info:

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
00:0b.0 VGA compatible controller: ATI Technologies Inc 210888GX [Mach64 GX] (rev 01)
00:0f.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
00:11.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)

hda is running with DMA enabled in mdma2 mode.

