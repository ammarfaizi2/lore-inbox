Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbRGJUUg>; Tue, 10 Jul 2001 16:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbRGJUUQ>; Tue, 10 Jul 2001 16:20:16 -0400
Received: from zeus.kernel.org ([209.10.41.242]:23738 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267133AbRGJUUL>;
	Tue, 10 Jul 2001 16:20:11 -0400
Date: Tue, 10 Jul 2001 11:48:50 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] SCI Scalable Coherent Interface Drivers 1.7-1 Released
Message-ID: <20010710114850.A2865@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Version 1.7-1 of the Dolphin PCI-SCI (Scalable Coherent Interface) 
drivers for Linux kernels 2.2 and 2.4 are have been released and
are available for download at ftp.timpanogas.org and www.timpanogas.org.
Numerous enhancements have been added to this release, including 
enhanced support for X-Y dual fabric SCI rings. 

Bug fixes and modifications contained in this release:

  
IRM 1.10.6 ( March 4th 2001 )

*Genif: Added implementation of SPEEP_OK for sci_create_segment()
*Solaris X86: Fixed build_IRM and added dummy function for hostbridge
 manipulation. Thanks to Joachim Worringen.
*2d Torus topology support enhanced ( only for D33x family ) Requres
 recompilation of the IRM driver with the ENABLE_MESH_TOPOLOGY_SUPPORT
 flag seg. More info in IRM/drv/src/prolog.h.
*VxWorks: Fixed Interrupt registration problem that could cause loss of
 interrupts

IRM 1.10.7 ( April 26th 2001 )

*Added initial entry for Intel i960 support ( not completed ).
*Solaris X86: Completed hostbridge manipulation functionality. Tested
 and verified on Solaris 7 / ServerWorks. Thanks to Joachim Worringen.
*Added support for 2D torus topology in scidiag.
*Solaris SPARC: Added support for hostbridge detecting D330 as "name=pci11c8,40"

IRM 1.10.8 ( 22th May 2001 )

*Added support for adapter D230 (PSB66 - LC3). A PCI reset will reset the LC3.
 This functionality is a request from Siemens.
*Added autodetection of topology. ENABLE_MESH_TOPOLOGY_SUPPORT no
 longer needed.
*PSB64 not properly supported. Full support from next release again.

IRM 1.10.9 ( 25th May 2001 )

*Code to support PSB64 again added
*VxWorks: Updated to support psb66 ( D33x family ) on PowerPC
*updated sciconfig to set and get link-frequency, prefetch and
 no-prefetch space size for more than one adapter.
*Fixed problem for Solaris 2.5.1 in build_IRM, and added exit 1 status
 for compilation faults.
*Solaris:Added option for skipping all_build variants in package create
 script.


IRM 1.10.10 ( 5th June 2001 )
*Added support for 2D torus up to 15x15 nodes
*Added support for ServerWorks HE idenitying with device id 0x00081166 


IRM 1.10.11 ( 19th June 2001 )
*Disabled speculative hold as default for psb66
*Added extra check to make sure that a new DMA transfer (DMA kick) is not 
 done before the previous DMA transfer has completed.
*Bug fix for 2d-mesh topology using nodeId 200.
*Linux:Added property to reduce mapping of prefetchspace to less than
 PCI MEMSIZE
*Linux: Bigphysarea patch requirement disabled as default for linux 2.4

SISCI 1.10.7 ( 26th April 2001 )
*Added initial entry for Intel i960 support ( not completed ).
*Linux:Enabled MMX intructions support in sciMemCopy()
*Cleaned up and simplified common IOCTL and MMAP code.
*VxWorks: Added support for cache line manipulation for in sciMemcopy,
 and added new map flag SCI_FLAG_WRITE_BACK_CACHE_MAP.
*sci ping pong benchmark updated. (SISCI/cmd/test/scipp) Tested on VxWorks/Linux.

SISCI 1.10.8 ( 22th May 2001 )
*Solaris: Optimalization in sciMemCopy().
*Linux: Added flag SLEEP_OK to call to sci_create_segment. Memory
 allocaiton thread may now sleep while Linux is allocating memory.
*Linux: Removed erronous DIS/src/SISCI/src/LINUX/os/mmapcode.h
*Linux: Fixed bug in SISCI callback functionality and enabled by default.
*Added implementation of new SCIFlush() SISCI function. Please note that this
 function and signature is subject to change.


SISCI 1.10.9 ( 25th May 2001 )
*VxWorks: Added support for PSB66 adatpters

SISCI 1.10.10 ( 5th June 2001 )
*Added support for ServerWorks HE idenifying with device id 0x00081166 

SISCI 1.10.11 ( 19th June 2001 )
*New IOCTL interface for NT and Windows 2000
*LINUX: Fixed problem with SMP variable not being exported on some systems

Please direct and problems, bug reports, or suggestions regarding this 
release to jmerkey@timpanogas.org or hugo@dolphinics.no.

Jeff Merkey
TRG


