Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936925AbWLDOxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936925AbWLDOxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936937AbWLDOxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:53:43 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:29207 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S936936AbWLDOx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:53:29 -0500
Date: Mon, 4 Dec 2006 15:53:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, nikai@nikai.net
Subject: [S390] Some documentation typos.
Message-ID: <20061204145324.GO32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Kaiser <nikai@nikai.net>

[S390] Some documentation typos.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/CommonIO              |    4 +--
 Documentation/s390/Debugging390.txt      |   38 +++++++++++++++----------------
 Documentation/s390/cds.txt               |   11 ++++----
 Documentation/s390/crypto/crypto-API.txt |    6 ++--
 Documentation/s390/s390dbf.txt           |    8 +++---
 5 files changed, 34 insertions(+), 33 deletions(-)

diff -urpN linux-2.6/Documentation/s390/cds.txt linux-2.6-patched/Documentation/s390/cds.txt
--- linux-2.6/Documentation/s390/cds.txt	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/cds.txt	2006-12-04 14:50:46.000000000 +0100
@@ -98,7 +98,7 @@ The following chapters describe the I/O 
 Linux/390 common device support (CDS) provides to allow for device specific
 driver implementations on the IBM ESA/390 hardware platform. Those interfaces
 intend to provide the functionality required by every device driver
-implementaion to allow to drive a specific hardware device on the ESA/390
+implementation to allow to drive a specific hardware device on the ESA/390
 platform. Some of the interface routines are specific to Linux/390 and some
 of them can be found on other Linux platforms implementations too.
 Miscellaneous function prototypes, data declarations, and macro definitions
@@ -114,7 +114,7 @@ the ESA/390 architecture has implemented
 provides a unified view of the devices physically attached to the systems.
 Though the ESA/390 hardware platform knows about a huge variety of different
 peripheral attachments like disk devices (aka. DASDs), tapes, communication
-controllers, etc. they can all by accessed by a well defined access method and
+controllers, etc. they can all be accessed by a well defined access method and
 they are presenting I/O completion a unified way : I/O interruptions. Every
 single device is uniquely identified to the system by a so called subchannel,
 where the ESA/390 architecture allows for 64k devices be attached.
@@ -338,7 +338,7 @@ DOIO_REPORT_ALL          - report all in
 The ccw_device_start() function returns :
 
       0 - successful completion or request successfully initiated
--EBUSY  - The device is currently processing a previous I/O request, or ther is
+-EBUSY	- The device is currently processing a previous I/O request, or there is
           a status pending at the device.
 -ENODEV - cdev is invalid, the device is not operational or the ccw_device is
           not online.
@@ -361,7 +361,7 @@ first:
 -EIO:       the common I/O layer terminated the request due to an error state
 
 If the concurrent sense flag in the extended status word in the irb is set, the
-field irb->scsw.count describes the numer of device specific sense bytes
+field irb->scsw.count describes the number of device specific sense bytes
 available in the extended control word irb->scsw.ecw[0]. No device sensing by
 the device driver itself is required.
 
@@ -410,7 +410,7 @@ ccw_device_start() must be called disabl
 
 The device driver is allowed to issue the next ccw_device_start() call from
 within its interrupt handler already. It is not required to schedule a
-bottom-half, unless an non deterministically long running error recovery procedure
+bottom-half, unless a non deterministically long running error recovery procedure
 or similar needs to be scheduled. During I/O processing the Linux/390 generic
 I/O device driver support has already obtained the IRQ lock, i.e. the handler
 must not try to obtain it again when calling ccw_device_start() or we end in a
@@ -431,7 +431,7 @@ information prior to device-end the devi
 case all I/O interruptions are presented to the device driver until final
 status is recognized.
 
-If a device is able to recover from asynchronosly presented I/O errors, it can
+If a device is able to recover from asynchronously presented I/O errors, it can
 perform overlapping I/O using the DOIO_EARLY_NOTIFICATION flag. While some
 devices always report channel-end and device-end together, with a single
 interrupt, others present primary status (channel-end) when the channel is
diff -urpN linux-2.6/Documentation/s390/CommonIO linux-2.6-patched/Documentation/s390/CommonIO
--- linux-2.6/Documentation/s390/CommonIO	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/CommonIO	2006-12-04 14:50:46.000000000 +0100
@@ -74,7 +74,7 @@ Command line parameters
 
   Note: While already known devices can be added to the list of devices to be
         ignored, there will be no effect on then. However, if such a device
-        disappears and then reappeares, it will then be ignored.
+	disappears and then reappears, it will then be ignored.
 
   For example,
 	"echo add 0.0.a000-0.0.accc, 0.0.af00-0.0.afff > /proc/cio_ignore"
@@ -82,7 +82,7 @@ Command line parameters
   devices.
 
   The devices can be specified either by bus id (0.0.abcd) or, for 2.4 backward
-  compatibilty, by the device number in hexadecimal (0xabcd or abcd).
+  compatibility, by the device number in hexadecimal (0xabcd or abcd).
 
 
 * /proc/s390dbf/cio_*/ (S/390 debug feature)
diff -urpN linux-2.6/Documentation/s390/crypto/crypto-API.txt linux-2.6-patched/Documentation/s390/crypto/crypto-API.txt
--- linux-2.6/Documentation/s390/crypto/crypto-API.txt	2006-12-04 14:50:17.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/crypto/crypto-API.txt	2006-12-04 14:50:46.000000000 +0100
@@ -17,8 +17,8 @@ arch/s390/crypto directory.
 2. Probing for availability of MSA
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 It should be possible to use Kernels with the z990 crypto implementations both
-on machines with MSA available an on those without MSA (pre z990 or z990
-without MSA). Therefore a simple probing mechanisms has been implemented:
+on machines with MSA available and on those without MSA (pre z990 or z990
+without MSA). Therefore a simple probing mechanism has been implemented:
 In the init function of each crypto module the availability of MSA and of the
 respective crypto algorithm in particular will be tested. If the algorithm is
 available the module will load and register its algorithm with the crypto API.
@@ -26,7 +26,7 @@ available the module will load and regis
 If the respective crypto algorithm is not available, the init function will
 return -ENOSYS. In that case a fallback to the standard software implementation
 of the crypto algorithm must be taken ( -> the standard crypto modules are
-also build when compiling the kernel).
+also built when compiling the kernel).
 
 
 3. Ensuring z990 crypto module preference
diff -urpN linux-2.6/Documentation/s390/Debugging390.txt linux-2.6-patched/Documentation/s390/Debugging390.txt
--- linux-2.6/Documentation/s390/Debugging390.txt	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/Debugging390.txt	2006-12-04 14:50:46.000000000 +0100
@@ -7,7 +7,7 @@
 
 Overview of Document:
 =====================
-This document is intended to give an good overview of how to debug 
+This document is intended to give a good overview of how to debug
 Linux for s/390 & z/Architecture. It isn't intended as a complete reference & not a
 tutorial on the fundamentals of C & assembly. It doesn't go into
 390 IO in any detail. It is intended to complement the documents in the
@@ -300,7 +300,7 @@ On z/Architecture our page indexes are n
 but only mess with 2 segment indices each time we mess with
 a PMD.
 
-3) As z/Architecture supports upto a massive 5-level page table lookup we 
+3) As z/Architecture supports up to a massive 5-level page table lookup we
 can only use 3 currently on Linux ( as this is all the generic kernel
 currently supports ) however this may change in future
 this allows us to access ( according to my sums )
@@ -502,7 +502,7 @@ Notes:
 ------
 1) The only requirement is that registers which are used
 by the callee are saved, e.g. the compiler is perfectly
-capible of using r11 for purposes other than a frame a
+capable of using r11 for purposes other than a frame a
 frame pointer if a frame pointer is not needed.
 2) In functions with variable arguments e.g. printf the calling procedure 
 is identical to one without variable arguments & the same number of 
@@ -846,7 +846,7 @@ of time searching for debugging info. Th
 instead if the code isn't compiled -g, as it is much faster:
 objdump --disassemble-all --syms vmlinux > vmlinux.lst  
 
-As hard drive space is valuble most of us use the following approach.
+As hard drive space is valuable most of us use the following approach.
 1) Look at the emitted psw on the console to find the crash address in the kernel.
 2) Look at the file System.map ( in the linux directory ) produced when building 
 the kernel to find the closest address less than the current PSW to find the
@@ -902,7 +902,7 @@ A. It is a tool for intercepting calls t
 to a file & on the screen.
 
 Q. What use is it ?
-A. You can used it to find out what files a particular program opens.
+A. You can use it to find out what files a particular program opens.
 
 
 
@@ -911,7 +911,7 @@ Example 1
 If you wanted to know does ping work but didn't have the source 
 strace ping -c 1 127.0.0.1  
 & then look at the man pages for each of the syscalls below,
-( In fact this is sometimes easier than looking at some spagetti
+( In fact this is sometimes easier than looking at some spaghetti
 source which conditionally compiles for several architectures ).
 Not everything that it throws out needs to make sense immediately.
 
@@ -1037,7 +1037,7 @@ e.g. man strace, man alarm, man socket.
 
 Performance Debugging
 =====================
-gcc is capible of compiling in profiling code just add the -p option
+gcc is capable of compiling in profiling code just add the -p option
 to the CFLAGS, this obviously affects program size & performance.
 This can be used by the gprof gnu profiling tool or the
 gcov the gnu code coverage tool ( code coverage is a means of testing
@@ -1419,7 +1419,7 @@ On a SMP guest issue a command to all CP
 To issue a command to a particular cpu try cpu <cpu number> e.g.
 CPU 01 TR I R 2000.3000
 If you are running on a guest with several cpus & you have a IO related problem
-& cannot follow the flow of code but you know it isnt smp related.
+& cannot follow the flow of code but you know it isn't smp related.
 from the bash prompt issue
 shutdown -h now or halt.
 do a Q CPUS to find out how many cpus you have
@@ -1602,7 +1602,7 @@ V000FFFD0  00010400 80010802 8001085A 00
 our 3rd return address is 8001085A
 
 as the 04B52002 looks suspiciously like rubbish it is fair to assume that the kernel entry routines
-for the sake of optimisation dont set up a backchain.
+for the sake of optimisation don't set up a backchain.
 
 now look at System.map to see if the addresses make any sense.
 
@@ -1638,11 +1638,11 @@ more useful information.
 
 Unlike other bus architectures modern 390 systems do their IO using mostly
 fibre optics & devices such as tapes & disks can be shared between several mainframes,
-also S390 can support upto 65536 devices while a high end PC based system might be choking 
+also S390 can support up to 65536 devices while a high end PC based system might be choking
 with around 64. Here is some of the common IO terminology
 
 Subchannel:
-This is the logical number most IO commands use to talk to an IO device there can be upto
+This is the logical number most IO commands use to talk to an IO device there can be up to
 0x10000 (65536) of these in a configuration typically there is a few hundred. Under VM
 for simplicity they are allocated contiguously, however on the native hardware they are not
 they typically stay consistent between boots provided no new hardware is inserted or removed.
@@ -1651,7 +1651,7 @@ HALT SUBCHANNEL,MODIFY SUBCHANNEL,RESUME
 TEST SUBCHANNEL ) we use this as the ID of the device we wish to talk to, the most
 important of these instructions are START SUBCHANNEL ( to start IO ), TEST SUBCHANNEL ( to check
 whether the IO completed successfully ), & HALT SUBCHANNEL ( to kill IO ), a subchannel
-can have up to 8 channel paths to a device this offers redunancy if one is not available.
+can have up to 8 channel paths to a device this offers redundancy if one is not available.
 
 
 Device Number:
@@ -1659,7 +1659,7 @@ This number remains static & Is closely 
 also they are made up of a CHPID ( Channel Path ID, the most significant 8 bits ) 
 & another lsb 8 bits. These remain static even if more devices are inserted or removed
 from the hardware, there is a 1 to 1 mapping between Subchannels & Device Numbers provided
-devices arent inserted or removed.
+devices aren't inserted or removed.
 
 Channel Control Words:
 CCWS are linked lists of instructions initially pointed to by an operation request block (ORB),
@@ -1674,7 +1674,7 @@ concurrently, you check how the IO went 
 from which you receive an Interruption response block (IRB). If you get channel & device end 
 status in the IRB without channel checks etc. your IO probably went okay. If you didn't you
 probably need a doctor to examine the IRB & extended status word etc.
-If an error occurs, more sophistocated control units have a facitity known as
+If an error occurs, more sophisticated control units have a facility known as
 concurrent sense this means that if an error occurs Extended sense information will
 be presented in the Extended status word in the IRB if not you have to issue a
 subsequent SENSE CCW command after the test subchannel. 
@@ -1749,7 +1749,7 @@ Interface (OEMI).
 This byte wide Parallel channel path/bus has parity & data on the "Bus" cable 
 & control lines on the "Tag" cable. These can operate in byte multiplex mode for
 sharing between several slow devices or burst mode & monopolize the channel for the
-whole burst. Upto 256 devices can be addressed  on one of these cables. These cables are
+whole burst. Up to 256 devices can be addressed  on one of these cables. These cables are
 about one inch in diameter. The maximum unextended length supported by these cables is
 125 Meters but this can be extended up to 2km with a fibre optic channel extended 
 such as a 3044. The maximum burst speed supported is 4.5 megabytes per second however
@@ -1759,7 +1759,7 @@ One of these paths can be daisy chained 
 
 ESCON if fibre optic it is also called FICON 
 Was introduced by IBM in 1990. Has 2 fibre optic cables & uses either leds or lasers
-for communication at a signaling rate of upto 200 megabits/sec. As 10bits are transferred
+for communication at a signaling rate of up to 200 megabits/sec. As 10bits are transferred
 for every 8 bits info this drops to 160 megabits/sec & to 18.6 Megabytes/sec once
 control info & CRC are added. ESCON only operates in burst mode.
  
@@ -1767,7 +1767,7 @@ ESCONs typical max cable length is 3km f
 known as XDF ( extended distance facility ). This can be further extended by using an
 ESCON director which triples the above mentioned ranges. Unlike Bus & Tag as ESCON is
 serial it uses a packet switching architecture the standard Bus & Tag control protocol
-is however present within the packets. Upto 256 devices can be attached to each control 
+is however present within the packets. Up to 256 devices can be attached to each control
 unit that uses one of these interfaces.
 
 Common 390 Devices include:
@@ -2050,7 +2050,7 @@ list test.c:1,10
 
 directory:
 Adds directories to be searched for source if gdb cannot find the source.
-(note it is a bit sensititive about slashes) 
+(note it is a bit sensitive about slashes)
 e.g. To add the root of the filesystem to the searchpath do
 directory //
 
@@ -2152,7 +2152,7 @@ program as if it just crashed on your sy
 current working directory.
 This is very useful in that a customer can mail a core dump to a technical support department
 & the technical support department can reconstruct what happened.
-Provided the have an identical copy of this program with debugging symbols compiled in & 
+Provided they have an identical copy of this program with debugging symbols compiled in &
 the source base of this build is available.
 In short it is far more useful than something like a crash log could ever hope to be.
 
diff -urpN linux-2.6/Documentation/s390/s390dbf.txt linux-2.6-patched/Documentation/s390/s390dbf.txt
--- linux-2.6/Documentation/s390/s390dbf.txt	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/s390dbf.txt	2006-12-04 14:50:46.000000000 +0100
@@ -36,7 +36,7 @@ switches to the next debug area. This is
 that the records which describe the origin of the exception are not
 overwritten when a wrap around for the current area occurs.
 
-The debug areas itselve are also ordered in form of a ring buffer. 
+The debug areas themselves are also ordered in form of a ring buffer.
 When an exception is thrown in the last debug area, the following debug 
 entries are then written again in the very first area.
 
@@ -55,7 +55,7 @@ The debug logs can be inspected in a liv
 the debugfs-filesystem. Under the toplevel directory "s390dbf" there is
 a directory for each registered component, which is named like the
 corresponding component. The debugfs normally should be mounted to
-/sys/kernel/debug therefore the debug feature can be accessed unter
+/sys/kernel/debug therefore the debug feature can be accessed under
 /sys/kernel/debug/s390dbf.
 
 The content of the directories are files which represent different views
@@ -87,11 +87,11 @@ There are currently 2 possible triggers,
 globally. The first possibility is to use the "debug_active" sysctl. If
 set to 1 the debug feature is running. If "debug_active" is set to 0 the
 debug feature is turned off.
-The second trigger which stops the debug feature is an kernel oops.
+The second trigger which stops the debug feature is a kernel oops.
 That prevents the debug feature from overwriting debug information that
 happened before the oops. After an oops you can reactivate the debug feature
 by piping 1 to /proc/sys/s390dbf/debug_active. Nevertheless, its not
-suggested to use an oopsed kernel in an production environment.
+suggested to use an oopsed kernel in a production environment.
 If you want to disallow the deactivation of the debug feature, you can use
 the "debug_stoppable" sysctl. If you set "debug_stoppable" to 0 the debug
 feature cannot be stopped. If the debug feature is already stopped, it
