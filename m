Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271918AbRHVE47>; Wed, 22 Aug 2001 00:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271928AbRHVE4t>; Wed, 22 Aug 2001 00:56:49 -0400
Received: from phosphor.cipic.ucdavis.edu ([169.237.153.5]:2822 "EHLO
	phosphor.cipic.ucdavis.edu") by vger.kernel.org with ESMTP
	id <S271918AbRHVE4i>; Wed, 22 Aug 2001 00:56:38 -0400
Message-Id: <4.3.2.7.2.20010821214923.00b5ad30@phosphor.cipic.ucdavis.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 21 Aug 2001 21:58:03 -0700
To: linux-kernel@vger.kernel.org
From: Dennis Thompson <yknot@cipic.ucdavis.edu>
Subject: 2.4.9 kernel i810 module Initialization problem  
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I was using the i810 module for APG video (2.4.7 kernel) with no problems.  After installation of the 2.4.9 kernel the module failed to initialize. 

agpgart.o loads fine

This is a pain because the display fails after X starts (not even char display).  Disabling the i810 module fixes the problem of the display locking.

Errors Messages from the XFree86.0.log

	Symbol VBEInit from module /usr/X11R6/lib/modules/drivers/i810_drv.o is unresolved!
	Symbol vbeDoEDID from module /usr/X11R6/lib/modules/drivers/i810_drv.o is unresolved!
	I810 Dma Initialization Failed

kernel messages include

	[drm:i810_ioremapfree:mappings] *ERROR* Excess frees: 256 frees, 2 allocs
	[drm:i810_dma_initialize] *ERROR* can not find mmio map!
	agpgart: Detected an Intel i810 E Chipset.m


Output from ver_linux

	Gnu C                  2.96
	Gnu make               3.79.1
	binutils               2.10.91.0.2
	util-linux             2.10s
	mount                  2.11b
	modutils               2.4.2
	e2fsprogs              1.19
	Linux C Library        2.2.2
	Dynamic linker (ldd)   2.2.2
	Procps                 2.0.7
	Net-tools              1.57
	Console-tools          0.3.3
	Sh-utils               2.0
	Modules Loaded         agpgart autofs4 nfsd lockd sunrpc 3c59x unix

more /proc/iomem
	00000000-0009ffff : System RAM
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000c8000-000cffff : Extension ROM
	000f0000-000fffff : System ROM
	00100000-17eadfff : System RAM
	  00100000-001b59b3 : Kernel code
	  001b59b4-001f13df : Kernel data
	17eae000-17ffffff : reserved
	f8000000-fbffffff : Intel Corporation 82810E CGC [Chipset Graphics Controller]
	fd000000-feffffff : PCI Bus #01
	  fdfffc00-fdfffc7f : 3Com Corporation 3c905C-TX [Fast Etherlink]
	ff000000-ff07ffff : Intel Corporation 82810E CGC [Chipset Graphics Controller]
	ffb00000-ffffffff : reserved

The machine is a Dell GX110 - Pentium II 800 MHz 526 MB Ram running Redhat 7.1 

If I can provide any more information the you may find useful please feel free to contact me.

 Dennis Thompson

*******************************************************************
 Center for Image Processing and Integrated Computing (CIPIC) 
 Interface Laboratory
 University of California, Davis CA 95616
 Phone	: (530) 754-9861
 Fax		: (530) 752-8894
 e-mail	: mailto:yknot@ece.ucdavis.edu
 URL		: http://interface.cipic.ucdavis.edu/
*******************************************************************

