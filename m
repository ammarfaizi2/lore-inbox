Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbTDAJOi>; Tue, 1 Apr 2003 04:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbTDAJOi>; Tue, 1 Apr 2003 04:14:38 -0500
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:62644
	"EHLO cygne") by vger.kernel.org with ESMTP id <S262212AbTDAJOg>;
	Tue, 1 Apr 2003 04:14:36 -0500
Message-ID: <55994.62.253.198.200.1049187659.squirrel@www.masroudeau.com>
Date: Tue, 1 Apr 2003 10:00:59 +0100 (BST)
Subject: Announce: Gujin bootloader 0.7
From: etienne.lorrain@masroudeau.com
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.4.0 RC1)
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I would be glad to hear comments on this new release, available at
http://sourceforge.net/projects/gujin
http://freshmeat.net/projects/gujin

 Gujin is a GPL bootloader rewritten from scratch, it can now be
 installed on a hard disk (in a small FAT 12/16 partition) or on
 a floppy.
 It is still not perfect, but can still:
 - boot any kernel of any uncompressed size in an E2FS, E3FS
 or FAT12/16/32 partition using BIOS, EBIOS _or_ IDE CHS/LBA/LBA48.
 Libraries for E*FS reading and gzip decompression are rewritten
 from scratch for size optimisation - no known bug after extensive
 testing.
 - boot Linux in whatever graphic mode supported by VESA (I use
 usually 1280x1024 24 bpp) staying in real mode. Use of mouse or
 joystick to select the kernel to boot.
 - boot from BIOS startup _or_ starting from DOS.
 - recognise most of QWERTY AZERTY and QWERTZ keyboards to change
 the command line and provide more input -:).
 - boot strange setups like this-other-operating-system in
 extended partitions and automagic management of partition hiding.

 There is a lot of stuff to code and test still, for instance the
 default function to get Linux i386 real-mode parameter can be
 overloaded by code present at end of the compressed kernel
 (linux_param_realfct_size in vmlinuz.* shall use a function
 like the one in linuxparam.c which would be concatenated at the
 end of linux.kgz) and processor restrictions in the comment field
 of the GZIPed kernel has also to be tested (get the Gujin loader
 to complain if the kernel cannot be run on the current processor,
 using all the CPUID flags).
 Also, the late relocation address of the kernel can be modified
 (because the kernel can now be of any size, it takes DMA-able memory
 below 16 Mb, precious for the sound buffers, so the default loading
 address shall be moved to 16 Mbytes and over for up to date systems)

 If interrested, you should begin by downloading the install.tgz
 package because the compiler used is GCC-2.95.3/4 or GCC-3.0.4
 due to compiler bugs. Read the doc first !

  I am currently writing the ANSI font download (to not use the
 PC fonts) and will next support more keyboards.
 My days just have 24 hours and have a limited time to play
 with Gujin, so I would appreciate some help.

  Etienne.
