Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbSBCFiO>; Sun, 3 Feb 2002 00:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSBCFiE>; Sun, 3 Feb 2002 00:38:04 -0500
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:32923 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S285666AbSBCFhy>; Sun, 3 Feb 2002 00:37:54 -0500
Date: Sat, 2 Feb 2002 21:38:43 -0800
From: "Luis A. Montes" <Luis.A.Montes.1@worldnet.att.net>
Message-Id: <200202030538.g135chu00602@penguin.montes2.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 filesystem corruption
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have been experiencing filesystem corruption very frequently with
2.4.17. I've probably reinstalled my system more than 10 times in as
many days. So far it seems to be related to the kernel version and
perhaps to the UDMA settings. I haven't been able to crash the system
running 2.4.5 or 2.2.19, but it has crashed with 2.4.17 every time,
regardless of cpu optimization (Athlon, K6 or i386), AGP (built-in, as
a module or not built), filesystem (ext2 or xfs). Last kernel I tried
was a 2.4.17 with a ext2 fs and a patch I found by Lionel Bouton in
this list to handle my SiS 735 chipset. It did seem more stable for a
while, until I decided to try and enable ultra dma 66 on my primary
drive. The two partitions that I had mounted got completely corrupted
(on boot the kernel tried to mount it as a UMSDOS fs) and e2fsck
wasn't able to fix it. It did seem to work with udma 33, I compiled
the kernel without a problem as a test of disk IO, but I can't really
tell for sure that there wasn't a subtle disk corruption just waiting
to crop up.

My system is as follows:

ECS K7S5A Motherboard with the SiS 735 chipset, 128MB of PC133 SDRAM
and Athlon XP 1700+ processor at 1.4 something MHz. Memory is good,
tested with memtest86 overnight several full passes.

hda: Western Digital Caviar WDC AC313000R (it is *not* in the udma
black list, should it be?)

hdb: Western Digital Caviar WDC AC23200L (this one is in the black
list, but is not being mounted, so it shouldn't matter, right?)


Software: Straight Slackware 8 install, with XFree86 from cvs. But
lately I havent even tried glx, dri et al at all ...

Questions: 

- There is a patch by the IDE maintainer (Andre Hedrick?), but I don't
  know if that is supposed to make the system behave better or is a
  new major architectural change (if it is the latest I probably don't
  want to compound my problem, do I?) although at this point I'm
  willing to try almost anything, even windows ;-)

- Has anybody gotten a system similar to mine to work on these
  kernels. This same kernel (2.4.17-xfs with the rml patch) was rock
  solid in my old motherboard, a VIA Apollo K6-III motherboard with
  the same HD's.

- Was there some change between 2.4.5 and 2.4.17 that could have
  introduced problems in the IDE layer? I really tried to test 2.4.5
  to the limits compiling two versions of the kernel and XFree86
  simultaneously, and the filesystem survived. But unfortunately a
  negative result is not proof of stability
