Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314179AbSDXGy2>; Wed, 24 Apr 2002 02:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314232AbSDXGy1>; Wed, 24 Apr 2002 02:54:27 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:47502 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S314179AbSDXGyZ>; Wed, 24 Apr 2002 02:54:25 -0400
Subject: [PATCH] spelling changes backported from 2.5.9 to 2.4.19-pre7
From: Daniel Dickman <ddickman@nyc.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 24 Apr 2002 02:49:31 -0400
Message-Id: <1019631011.2710.13.camel@24-90-114-48>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some random Documentation changes that could be backported to the 2.4.x series. These apply cleanly to 2.4.19-pre7. The following files are modified:

- Documentation/DMA-mapping.txt
- Documentation/IRQ-affinity.txt
- Documentation/SubmittingDrivers


diff -Nur linux-2.4.19-pre7/Documentation/DMA-mapping.txt linux-2.5.9/Documentation/DMA-mapping.txt
--- linux-2.4.19-pre7/Documentation/DMA-mapping.txt	Mon Feb 25 14:37:51 2002
+++ linux-2.5.9/Documentation/DMA-mapping.txt	Mon Apr 22 18:29:23 2002
@@ -8,7 +8,7 @@
 Most of the 64bit platforms have special hardware that translates bus
 addresses (DMA addresses) into physical addresses.  This is similar to
 how page tables and/or a TLB translates virtual addresses to physical
-addresses on a cpu.  This is needed so that e.g. PCI devices can
+addresses on a CPU.  This is needed so that e.g. PCI devices can
 access with a Single Address Cycle (32bit DMA address) any page in the
 64bit physical address space.  Previously in Linux those 64bit
 platforms had to set artificial limits on the maximum RAM size in the
@@ -37,7 +37,7 @@
 			 What memory is DMA'able?
 
 The first piece of information you must know is what kernel memory can
-be used with the DMA mapping facilitites.  There has been an unwritten
+be used with the DMA mapping facilities.  There has been an unwritten
 set of rules regarding this, and this text is an attempt to finally
 write them down.
 
@@ -106,7 +106,7 @@
 3) Ignore this device and do not initialize it.
 
 It is recommended that your driver print a kernel KERN_WARNING message
-when you end up performing either #2 or #2.  In this manner, if a user
+when you end up performing either #2 or #3.  In this manner, if a user
 of your driver reports that performance is bad or that the device is not
 even detected, you can ask them for the kernel messages to find out
 exactly why.
@@ -146,7 +146,7 @@
 If your 64-bit device is going to be an enormous consumer of DMA
 mappings, this can be problematic since the DMA mappings are a
 finite resource on many platforms.  Please see the "DAC Addressing
-for Address Space Hungry Devices" setion near the end of this
+for Address Space Hungry Devices" section near the end of this
 document for how to handle this case.
 
 Finally, if your device can only drive the low 24-bits of
@@ -205,7 +205,7 @@
 
 - Consistent DMA mappings which are usually mapped at driver
   initialization, unmapped at the end and for which the hardware should
-  guarantee that the device and the cpu can access the data
+  guarantee that the device and the CPU can access the data
   in parallel and will see updates made by each other without any
   explicit software flushing.
 
@@ -222,12 +222,12 @@
 	- Device firmware microcode executed out of
 	  main memory.
 
-  The invariant these examples all require is that any cpu store
+  The invariant these examples all require is that any CPU store
   to memory is immediately visible to the device, and vice
   versa.  Consistent mappings guarantee this.
 
   IMPORTANT: Consistent DMA memory does not preclude the usage of
-             proper memory barriers.  The cpu may reorder stores to
+             proper memory barriers.  The CPU may reorder stores to
 	     consistent memory just as it may normal memory.  Example:
 	     if it is important for the device to see the first word
 	     of a descriptor updated before the second, you must do
@@ -284,7 +284,7 @@
 the pci_pool interface, described below.
 
 The consistent DMA mapping interfaces, for non-NULL dev, will always
-return a DMA address which is SAC (Single Address Cycle) addressible.
+return a DMA address which is SAC (Single Address Cycle) addressable.
 Even if the device indicates (via PCI dma mask) that it may address
 the upper 32-bits and thus perform DAC cycles, consistent allocation
 will still only return 32-bit PCI addresses for DMA.  This is true
@@ -622,7 +622,7 @@
 Note that for streaming type mappings you must either use these
 interfaces, or the dynamic mapping interfaces above.  You may not mix
 usage of both for the same device.  Such an act is illegal and is
-guarenteed to put a banana in your tailpipe.
+guaranteed to put a banana in your tailpipe.
 
 However, consistent mappings may in fact be used in conjunction with
 these interfaces.  Remember that, as defined, consistent mappings are
@@ -637,7 +637,7 @@
 use the following interfaces if this routine fails.
 
 Next, DMA addresses using this API are kept track of using the
-dma64_addr_t type.  It is guarenteed to be big enough to hold any
+dma64_addr_t type.  It is guaranteed to be big enough to hold any
 DAC address the platform layer will give to you from the following
 routines.  If you have consistent mappings as well, you still
 use plain dma_addr_t to keep track of those.
@@ -745,7 +745,7 @@
 			 PCI_DMA_FROMDEVICE);
 
 It really should be self-explanatory.  We treat the ADDR and LEN
-seperately, because it is possible for an implementation to only
+separately, because it is possible for an implementation to only
 need the address in order to perform the unmap operation.
 
 			Platform Issues
diff -Nur linux-2.4.19-pre7/Documentation/IRQ-affinity.txt linux-2.5.9/Documentation/IRQ-affinity.txt
--- linux-2.4.19-pre7/Documentation/IRQ-affinity.txt	Fri Feb 25 01:41:16 2000
+++ linux-2.5.9/Documentation/IRQ-affinity.txt	Mon Apr 22 18:27:39 2002
@@ -8,7 +8,7 @@
 affinity then the value will not change from the default 0xffffffff.
 
 Here is an example of restricting IRQ44 (eth1) to CPU0-3 then restricting
-the IRQ to CPU4-8 (this is an 8-CPU SMP box):
+the IRQ to CPU4-7 (this is an 8-CPU SMP box):
 
 [root@moon 44]# cat smp_affinity
 ffffffff
diff -Nur linux-2.4.19-pre7/Documentation/SubmittingDrivers linux-2.5.9/Documentation/SubmittingDrivers
--- linux-2.4.19-pre7/Documentation/SubmittingDrivers	Mon Aug 27 11:59:16 2001
+++ linux-2.5.9/Documentation/SubmittingDrivers	Mon Apr 22 18:29:34 2002
@@ -3,7 +3,7 @@
 
 This document is intended to explain how to submit device drivers to the
 Linux 2.2 and 2.4 kernel trees. Note that if you are interested in video
-card drivers you should probably talk to XFree86 (http://wwww.xfree86.org) 
+card drivers you should probably talk to XFree86 (http://www.xfree86.org) 
 instead.
 
 Also read the Documentation/SubmittingPatches document.

