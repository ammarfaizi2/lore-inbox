Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTL0NOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 08:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTL0NOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 08:14:41 -0500
Received: from bender.bawue.de ([193.197.13.1]:27073 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S264398AbTL0NOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 08:14:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Fixing 2.6.0's broken documentation references
From: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Date: Sat, 27 Dec 2003 14:12:52 +0100
Message-ID: <864qvmjtez.fsf@n-dimensional.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

I've noted that 2.6.0 contains broken references to documentation.

I got sufficiently annoyed chasing doc files in the wrong place
that I wrote a script to check the references to documentation
files.

Some documentation files have moved (e.g. Documentation/modules.txt
to Documentation/kbuild/modules.txt). I adapted the references with a
script. Patch attached.

I couldn't find a maintainer for the documentation, the -doc lists are
dead, so I ask here whether such patches stand a chance to be included
into the main kernel tree.

If yes, I'd like to do some more work as described below.

1. How to consistently reference to doc files?

   a) "linux/Documentation/"
      Still used in some places, but seems to be obsolete, as the top
      directory is now called "linux-${VERSION}".

   b) "../../Documentation/foo/bar.txt"
      There are also places where relative pathes are used. This takes
      extra space and "Documentation/" should be well-known anyway.

   c) "Documentation/"
      Most commonly used. Probably the way to go.

2. Some files have been removed (examples: Configure.help, smp.tex).
   Fixing this requires manual rewrite of
   a) code comments
   b) kbuild help
   c) Documentation files

3. Now that I have written a script to scan the source tree, I could
   also start checking for broken references to http:// and ftp://
   URLs if desirable.

Regards,

Uli


--=-=-=
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=patch-2.6.0-moved-docs.patch
Content-Transfer-Encoding: quoted-printable
Content-Description: automatically adapted references to moved files in Documentation/

Fix references to files in Documentation/ which have been moved.
Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>

diff -ru linux-2.6.0-vanilla/Documentation/block/biodoc.txt linux-2.6.0-mov=
ed-docs/Documentation/block/biodoc.txt
--- linux-2.6.0-vanilla/Documentation/block/biodoc.txt	2003-12-18 03:59:16.=
000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/block/biodoc.txt	2003-12-26 14:54:=
42.000000000 +0100
@@ -323,7 +323,7 @@
 request->buffer, request->sector and request->nr_sectors or
 request->current_nr_sectors fields itself rather than using the block layer
 end_request or end_that_request_first completion interfaces.
-(See 2.3 or Documentation/bio/request.txt for a brief explanation of
+(See 2.3 or Documentation/block/request.txt for a brief explanation of
 the request structure fields)
=20
 [TBD: end_that_request_last should be usable even in this case;
@@ -517,7 +517,7 @@
 Only some relevant fields (mainly those which changed or may be referred
 to in some of the discussion here) are listed below, not necessarily in
 the order in which they occur in the structure (see include/linux/blkdev.h)
-Refer to Documentation/bio/request.txt for details about all the request
+Refer to Documentation/block/request.txt for details about all the request
 structure fields and a quick reference about the layers which are
 supposed to use or modify those fields.
=20
diff -ru linux-2.6.0-vanilla/Documentation/fb/aty128fb.txt linux-2.6.0-move=
d-docs/Documentation/fb/aty128fb.txt
--- linux-2.6.0-vanilla/Documentation/fb/aty128fb.txt	2003-12-18 03:58:04.0=
00000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/fb/aty128fb.txt	2003-12-26 14:54:4=
3.000000000 +0100
@@ -32,7 +32,7 @@
 You should compile in both vgacon (to boot if you remove your Rage128 from
 box) and aty128fb (for graphics mode). You should not compile-in vesafb
 unless you have primary display on non-Rage128 VBE2.0 device (see=20
-Documentation/vesafb.txt for details).
+Documentation/fb/vesafb.txt for details).
=20
=20
 X11
diff -ru linux-2.6.0-vanilla/Documentation/fb/matroxfb.txt linux-2.6.0-move=
d-docs/Documentation/fb/matroxfb.txt
--- linux-2.6.0-vanilla/Documentation/fb/matroxfb.txt	2003-12-18 03:59:19.0=
00000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/fb/matroxfb.txt	2003-12-26 14:54:4=
3.000000000 +0100
@@ -31,7 +31,7 @@
 You should compile in both vgacon (to boot if you remove you Matrox from
 box) and matroxfb (for graphics mode). You should not compile-in vesafb
 unless you have primary display on non-Matrox VBE2.0 device (see=20
-Documentation/vesafb.txt for details).
+Documentation/fb/vesafb.txt for details).
=20
 Currently supported video modes are (through vesa:... interface, PowerMac
 has [as addon] compatibility code):
diff -ru linux-2.6.0-vanilla/Documentation/input/input.txt linux-2.6.0-move=
d-docs/Documentation/input/input.txt
--- linux-2.6.0-vanilla/Documentation/input/input.txt	2003-12-18 03:58:28.0=
00000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/input/input.txt	2003-12-26 14:54:4=
2.000000000 +0100
@@ -255,7 +255,7 @@
 is also emulated, characters should appear if you move it.
=20
   You can test the joystick emulation with the 'jstest' utility,
-available in the joystick package (see Documentation/joystick.txt).
+available in the joystick package (see Documentation/input/joystick.txt).
=20
   You can test the event devices with the 'evtest' utility available
 in the LinuxConsole project CVS archive (see the URL below).
diff -ru linux-2.6.0-vanilla/Documentation/kbuild/modules.txt linux-2.6.0-m=
oved-docs/Documentation/kbuild/modules.txt
--- linux-2.6.0-vanilla/Documentation/kbuild/modules.txt	2003-12-18 03:59:2=
0.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/kbuild/modules.txt	2003-12-26 14:5=
4:42.000000000 +0100
@@ -1,4 +1,4 @@
-For now this is a raw copy from the old Documentation/modules.txt,
+For now this is a raw copy from the old Documentation/kbuild/modules.txt,
 which was removed in 2.6.0-test5.
 The information herein is correct but not complete.
=20
diff -ru linux-2.6.0-vanilla/Documentation/kernel-parameters.txt linux-2.6.=
0-moved-docs/Documentation/kernel-parameters.txt
--- linux-2.6.0-vanilla/Documentation/kernel-parameters.txt	2003-12-18 04:0=
0:02.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/kernel-parameters.txt	2003-12-26 1=
4:54:39.000000000 +0100
@@ -1144,7 +1144,7 @@
 			See header of drivers/scsi/wd7000.c.
=20
 	wdt=3D		[WDT] Watchdog
-			See Documentation/watchdog.txt.
+			See Documentation/watchdog/watchdog.txt.
=20
 	xd=3D		[HW,XT] Original XT pre-IDE (RLL encoded) disks.
 	xd_geo=3D		See header of drivers/block/xd.c.
diff -ru linux-2.6.0-vanilla/Documentation/sound/alsa/DocBook/writing-an-al=
sa-driver.tmpl linux-2.6.0-moved-docs/Documentation/sound/alsa/DocBook/writ=
ing-an-alsa-driver.tmpl
--- linux-2.6.0-vanilla/Documentation/sound/alsa/DocBook/writing-an-alsa-dr=
iver.tmpl	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/sound/alsa/DocBook/writing-an-alsa=
-driver.tmpl	2003-12-26 14:54:44.000000000 +0100
@@ -3623,7 +3623,7 @@
=20
         <para>
           More precise information can be found in
-        <filename>alsa-kernel/Documentation/ControlNames.txt</filename>.
+        <filename>alsa-kernel/Documentation/sound/alsa/ControlNames.txt</f=
ilename>.
         </para>
       </section>
     </section>
diff -ru linux-2.6.0-vanilla/Documentation/sound/oss/CMI8330 linux-2.6.0-mo=
ved-docs/Documentation/sound/oss/CMI8330
--- linux-2.6.0-vanilla/Documentation/sound/oss/CMI8330	2003-12-18 03:58:08=
.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/sound/oss/CMI8330	2003-12-26 14:54=
:44.000000000 +0100
@@ -2,7 +2,7 @@
 -------------------------------------
 Alessandro Zummo <azummo@ita.flashnet.it>
=20
-( Be sure to read Documentation/sound/SoundPro too )
+( Be sure to read Documentation/sound/oss/SoundPro too )
=20
=20
 This adapter is now directly supported by the sb driver.
diff -ru linux-2.6.0-vanilla/Documentation/sound/oss/INSTALL.awe linux-2.6.=
0-moved-docs/Documentation/sound/oss/INSTALL.awe
--- linux-2.6.0-vanilla/Documentation/sound/oss/INSTALL.awe	2003-12-18 03:5=
9:15.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/sound/oss/INSTALL.awe	2003-12-26 1=
4:54:44.000000000 +0100
@@ -114,7 +114,7 @@
 		# insmod awe_wave
 		(Be sure to load awe_wave after sb!)
=20
-		See /usr/src/linux/Documentation/sound/AWE32 for
+		See /usr/src/linux/Documentation/sound/oss/AWE32 for
 		more details.
=20
   9. (only for obsolete systems) If you don't have /dev/sequencer
diff -ru linux-2.6.0-vanilla/Documentation/sound/oss/Introduction linux-2.6=
.0-moved-docs/Documentation/sound/oss/Introduction
--- linux-2.6.0-vanilla/Documentation/sound/oss/Introduction	2003-12-18 04:=
00:01.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/sound/oss/Introduction	2003-12-26 =
14:54:44.000000000 +0100
@@ -24,7 +24,7 @@
 =3D=3D=3D=3D=3D=3D=3D=3D
 0.1.0  11/20/1998  First version, draft
 1.0.0  11/1998     Alan Cox changes, incorporation in 2.2.0
-                   as /usr/src/linux/Documentation/sound/Introduction
+                   as /usr/src/linux/Documentation/sound/oss/Introduction
 1.1.0  6/30/1999   Second version, added notes on making the drivers,
                    added info on multiple sound cards of similar types,]
                    added more diagnostics info, added info about esd.
diff -ru linux-2.6.0-vanilla/Documentation/sound/oss/PAS16 linux-2.6.0-move=
d-docs/Documentation/sound/oss/PAS16
--- linux-2.6.0-vanilla/Documentation/sound/oss/PAS16	2003-12-18 03:59:44.0=
00000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/sound/oss/PAS16	2003-12-26 14:54:4=
4.000000000 +0100
@@ -9,7 +9,7 @@
 This documentation is relevant for the PAS16 driver (pas2_card.c and
 friends) under kernel version 2.3.99 and later.  If you are
 unfamiliar with configuring sound under Linux, please read the
-Sound-HOWTO, linux/Documentation/sound/Introduction and other=20
+Sound-HOWTO, linux/Documentation/sound/oss/Introduction and other=20
 relevant docs first.
=20
 The following information is relevant information from README.OSS
@@ -73,8 +73,8 @@
   You want to read the Sound-HOWTO, available from
   http://www.tldp.org/docs.html#howto . General information
   about the modular sound system is contained in the files
-  Documentation/sound/Introduction. The file
-  Documentation/sound/README.OSS contains some slightly outdated but
+  Documentation/sound/oss/Introduction. The file
+  Documentation/sound/oss/README.OSS contains some slightly outdated but
   still useful information as well.
=20
 OSS sound modules
@@ -119,7 +119,7 @@
   cards may have software (TSR) FM emulation. Enabling FM support with
   these cards may cause trouble (I don't currently know of any such
   cards, however).
-  Please read the file Documentation/sound/OPL3 if your card has an
+  Please read the file Documentation/sound/oss/OPL3 if your card has an
   OPL3 chip.
   If you compile the driver into the kernel, you have to add
   "opl3=3D<io>" to the kernel command line.
diff -ru linux-2.6.0-vanilla/Documentation/sound/oss/SoundPro linux-2.6.0-m=
oved-docs/Documentation/sound/oss/SoundPro
--- linux-2.6.0-vanilla/Documentation/sound/oss/SoundPro	2003-12-18 03:59:5=
9.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/sound/oss/SoundPro	2003-12-26 14:5=
4:44.000000000 +0100
@@ -1,7 +1,7 @@
 Documentation for the SoundPro CMI8330 extensions in the WSS driver (ad184=
8.o)
 --------------------------------------------------------------------------=
----
=20
-( Be sure to read Documentation/sound/CMI8330 too )
+( Be sure to read Documentation/sound/oss/CMI8330 too )
=20
 Ion Badulescu, ionut@cs.columbia.edu
 February 24, 1999
diff -ru linux-2.6.0-vanilla/Documentation/sound/oss/Wavefront linux-2.6.0-=
moved-docs/Documentation/sound/oss/Wavefront
--- linux-2.6.0-vanilla/Documentation/sound/oss/Wavefront	2003-12-18 03:58:=
08.000000000 +0100
+++ linux-2.6.0-moved-docs/Documentation/sound/oss/Wavefront	2003-12-26 14:=
54:44.000000000 +0100
@@ -105,7 +105,7 @@
    drivers/sound/wf_midi.c              -- the "uart401" driver=20
    				              to support virtual MIDI mode.
    include/wavefront.h                  -- the header file
-   Documentation/sound/Tropez+          -- short docs on configuration
+   Documentation/sound/oss/Tropez+          -- short docs on configuration
=20
 **********************************************************************
 4) How do I compile/install/use it ?
diff -ru linux-2.6.0-vanilla/arch/arm/mach-sa1100/Kconfig linux-2.6.0-moved=
-docs/arch/arm/mach-sa1100/Kconfig
--- linux-2.6.0-vanilla/arch/arm/mach-sa1100/Kconfig	2003-12-18 04:00:01.00=
0000000 +0100
+++ linux-2.6.0-moved-docs/arch/arm/mach-sa1100/Kconfig	2003-12-26 14:57:59=
.000000000 +0100
@@ -304,7 +304,7 @@
 	depends on ARCH_SA1100
 	help
 	  Say Y here to support the Yopy PDA.  Product information at
-	  <http://www.yopy.com/>.  See Documentation/arm/SA110/Yopy
+	  <http://www.yopy.com/>.  See Documentation/arm/SA1100/Yopy
 	  for more.
=20
 config SA1100_STORK
diff -ru linux-2.6.0-vanilla/arch/m68k/Kconfig linux-2.6.0-moved-docs/arch/=
m68k/Kconfig
--- linux-2.6.0-vanilla/arch/m68k/Kconfig	2003-12-18 03:58:57.000000000 +01=
00
+++ linux-2.6.0-moved-docs/arch/m68k/Kconfig	2003-12-26 14:58:24.000000000 =
+0100
@@ -1025,7 +1025,7 @@
 	  implementation entirely in software (which can sometimes fail to
 	  reboot the machine) and a driver for hardware watchdog boards, which
 	  are more robust and can also keep track of the temperature inside
-	  your computer. For details, read <file:Documentation/watchdog.txt>
+	  your computer. For details, read <file:Documentation/watchdog/watchdog.=
txt>
 	  in the kernel source.
=20
 	  The watchdog is usually used together with the watchdog daemon
diff -ru linux-2.6.0-vanilla/arch/mips/Kconfig linux-2.6.0-moved-docs/arch/=
mips/Kconfig
--- linux-2.6.0-vanilla/arch/mips/Kconfig	2003-12-18 03:58:49.000000000 +01=
00
+++ linux-2.6.0-moved-docs/arch/mips/Kconfig	2003-12-26 14:58:28.000000000 =
+0100
@@ -1261,8 +1261,8 @@
 	  You want to read the Sound-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>. General information about
 	  the modular sound system is contained in the files
-	  <file:Documentation/sound/Introduction>.  The file
-	  <file:Documentation/sound/README.OSS> contains some slightly
+	  <file:Documentation/sound/oss/Introduction>.  The file
+	  <file:Documentation/sound/oss/README.OSS> contains some slightly
 	  outdated but still useful information as well.
=20
 	  If you have a PnP sound card and you want to configure it at boot
@@ -1270,7 +1270,7 @@
 	  <http://www.roestock.demon.co.uk/isapnptools/>), then you need to
 	  compile the sound card support as a module and load that module
 	  after the PnP configuration is finished. To do this, choose M here
-	  and read <file:Documentation/sound/README.modules>; the module
+	  and read <file:Documentation/sound/oss/README.modules>; the module
 	  will be called soundcore.
=20
 	  I'm told that even without a sound card, you can make your computer
diff -ru linux-2.6.0-vanilla/arch/sh/Kconfig linux-2.6.0-moved-docs/arch/sh=
/Kconfig
--- linux-2.6.0-vanilla/arch/sh/Kconfig	2003-12-18 03:59:55.000000000 +0100
+++ linux-2.6.0-moved-docs/arch/sh/Kconfig	2003-12-26 14:58:03.000000000 +0=
100
@@ -1053,7 +1053,7 @@
 	  implementation entirely in software (which can sometimes fail to
 	  reboot the machine) and a driver for hardware watchdog boards, which
 	  are more robust and can also keep track of the temperature inside
-	  your computer. For details, read <file:Documentation/watchdog.txt>
+	  your computer. For details, read <file:Documentation/watchdog/watchdog.=
txt>
 	  in the kernel source.
=20
 	  The watchdog is usually used together with the watchdog daemon
diff -ru linux-2.6.0-vanilla/arch/x86_64/Kconfig linux-2.6.0-moved-docs/arc=
h/x86_64/Kconfig
--- linux-2.6.0-vanilla/arch/x86_64/Kconfig	2003-12-18 03:59:18.000000000 +=
0100
+++ linux-2.6.0-moved-docs/arch/x86_64/Kconfig	2003-12-26 14:58:02.00000000=
0 +0100
@@ -314,7 +314,7 @@
 	  This option is close to getting stable. However there is still some
 	  absence of features.
=20
-	  For more information take a look at Documentation/swsusp.txt.
+	  For more information take a look at Documentation/power/swsusp.txt.
=20
 source "drivers/acpi/Kconfig"
=20
diff -ru linux-2.6.0-vanilla/drivers/char/watchdog/Kconfig linux-2.6.0-move=
d-docs/drivers/char/watchdog/Kconfig
--- linux-2.6.0-vanilla/drivers/char/watchdog/Kconfig	2003-12-18 03:59:05.0=
00000000 +0100
+++ linux-2.6.0-moved-docs/drivers/char/watchdog/Kconfig	2003-12-26 14:59:1=
5.000000000 +0100
@@ -17,7 +17,7 @@
 	  implementation entirely in software (which can sometimes fail to
 	  reboot the machine) and a driver for hardware watchdog boards, which
 	  are more robust and can also keep track of the temperature inside
-	  your computer. For details, read <file:Documentation/watchdog.txt>
+	  your computer. For details, read <file:Documentation/watchdog/watchdog.=
txt>
 	  in the kernel source.
=20
 	  The watchdog is usually used together with the watchdog daemon
@@ -114,7 +114,7 @@
 	  This card simply watches your kernel to make sure it doesn't freeze,
 	  and if it does, it reboots your computer after a certain amount of
 	  time. This driver is like the WDT501 driver but for different
-	  hardware. Please read <file:Documentation/pcwd-watchdog.txt>. The PC
+	  hardware. Please read <file:Documentation/watchdog/pcwd-watchdog.txt>. =
The PC
 	  watchdog cards can be ordered from <http://www.berkprod.com/>.
=20
 	  To compile this driver as a module, choose M here: the
diff -ru linux-2.6.0-vanilla/drivers/net/cs89x0.c linux-2.6.0-moved-docs/dr=
ivers/net/cs89x0.c
--- linux-2.6.0-vanilla/drivers/net/cs89x0.c	2003-12-18 03:59:19.000000000 =
+0100
+++ linux-2.6.0-moved-docs/drivers/net/cs89x0.c	2003-12-26 14:58:45.0000000=
00 +0100
@@ -47,7 +47,7 @@
                     : <klee@crystal.cirrus.com>)
                     : Don't call netif_wake_queue() in net_send_packet()
                     : Fixed an out-of-mem bug in dma_rx()
-                    : Updated Documentation/cs89x0.txt
+                    : Updated Documentation/networking/cs89x0.txt
=20
   Andrew Morton     : andrewm@uow.edu.au / Kernel 2.3.99-pre1
                     : Use skb_reserve to longword align IP header (two pla=
ces)
diff -ru linux-2.6.0-vanilla/drivers/net/wan/Kconfig linux-2.6.0-moved-docs=
/drivers/net/wan/Kconfig
--- linux-2.6.0-vanilla/drivers/net/wan/Kconfig	2003-12-18 03:58:28.0000000=
00 +0100
+++ linux-2.6.0-moved-docs/drivers/net/wan/Kconfig	2003-12-26 14:59:04.0000=
00000 +0100
@@ -334,7 +334,7 @@
=20
 	  If you want to compile the driver as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
+	  say M here and read <file:Documentation/kbuild/modules.txt>.  The module
 	  will be called wanxl.
=20
 	  If unsure, say N here.
@@ -467,7 +467,7 @@
 	  Say Y here if you need a driver for the Sangoma S502A, S502E, and
 	  S508 Frame Relay Access Devices. These are multi-protocol cards, but
 	  only frame relay is supported by the driver at this time. Please
-	  read <file:Documentation/framerelay.txt>.
+	  read <file:Documentation/networking/framerelay.txt>.
=20
 	  To compile this driver as a module, choose M here: the module will be
 	  called sdla.
diff -ru linux-2.6.0-vanilla/drivers/usb/image/scanner.c linux-2.6.0-moved-=
docs/drivers/usb/image/scanner.c
--- linux-2.6.0-vanilla/drivers/usb/image/scanner.c	2003-12-18 03:58:31.000=
000000 +0100
+++ linux-2.6.0-moved-docs/drivers/usb/image/scanner.c	2003-12-26 14:59:47.=
000000000 +0100
@@ -282,7 +282,7 @@
  *      for common error messages rather than the maintainer.
  *
  * 0.4.7  11/28/2001
- *    - Fixed typo in Documentation/scanner.txt.  Thanks to
+ *    - Fixed typo in Documentation/usb/scanner.txt.  Thanks to
  *      Karel <karel.vervaeke@pandora.be> for pointing it out.
  *    - Added ID's for a Memorex 6136u. Thanks to =C1lvaro Gaspar de
  *      Valenzuela" <agaspard@utsi.edu>.
diff -ru linux-2.6.0-vanilla/include/asm-s390/ccwdev.h linux-2.6.0-moved-do=
cs/include/asm-s390/ccwdev.h
--- linux-2.6.0-vanilla/include/asm-s390/ccwdev.h	2003-12-18 03:59:29.00000=
0000 +0100
+++ linux-2.6.0-moved-docs/include/asm-s390/ccwdev.h	2003-12-26 14:54:18.00=
0000000 +0100
@@ -69,7 +69,7 @@
 /* The struct ccw device is our replacement for the globally accessible
  * ioinfo array. ioinfo will mutate into a subchannel device later.
  *
- * Reference: Documentation/driver-model.txt */
+ * Reference: Documentation/s390/driver-model.txt */
 struct ccw_device {
 	spinlock_t *ccwlock;
 	struct ccw_device_private *private;	/* cio private information */
diff -ru linux-2.6.0-vanilla/kernel/power/Kconfig linux-2.6.0-moved-docs/ke=
rnel/power/Kconfig
--- linux-2.6.0-vanilla/kernel/power/Kconfig	2003-12-18 03:59:27.000000000 =
+0100
+++ linux-2.6.0-moved-docs/kernel/power/Kconfig	2003-12-26 14:54:39.0000000=
00 +0100
@@ -40,7 +40,7 @@
 	  involved in suspending. Also in this case there is a risk that buffers
 	  on disk won't match with saved ones.
=20
-	  For more information take a look at Documentation/swsusp.txt.
+	  For more information take a look at Documentation/power/swsusp.txt.
=20
 config PM_DISK
 	bool "Suspend-to-Disk Support"
diff -ru linux-2.6.0-vanilla/kernel/power/swsusp.c linux-2.6.0-moved-docs/k=
ernel/power/swsusp.c
--- linux-2.6.0-vanilla/kernel/power/swsusp.c	2003-12-18 03:58:28.000000000=
 +0100
+++ linux-2.6.0-moved-docs/kernel/power/swsusp.c	2003-12-26 14:54:39.000000=
000 +0100
@@ -33,7 +33,7 @@
  *
  * More state savers are welcome. Especially for the scsi layer...
  *
- * For TODOs,FIXMEs also look in Documentation/swsusp.txt
+ * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
  */
=20
 #include <linux/module.h>
diff -ru linux-2.6.0-vanilla/net/bridge/netfilter/Kconfig linux-2.6.0-moved=
-docs/net/bridge/netfilter/Kconfig
--- linux-2.6.0-vanilla/net/bridge/netfilter/Kconfig	2003-12-18 03:58:29.00=
0000000 +0100
+++ linux-2.6.0-moved-docs/net/bridge/netfilter/Kconfig	2003-12-26 14:53:59=
.000000000 +0100
@@ -92,7 +92,7 @@
 	  equivalent of the iptables limit match.
=20
 	  If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  If unsure, say `N'.
+	  <file:Documentation/kbuild/modules.txt>.  If unsure, say `N'.
=20
 config BRIDGE_EBT_MARK
 	tristate "ebt: mark filter support"
diff -ru linux-2.6.0-vanilla/sound/oss/Kconfig linux-2.6.0-moved-docs/sound=
/oss/Kconfig
--- linux-2.6.0-vanilla/sound/oss/Kconfig	2003-12-18 03:59:25.000000000 +01=
00
+++ linux-2.6.0-moved-docs/sound/oss/Kconfig	2003-12-26 15:00:12.000000000 =
+0100
@@ -195,7 +195,7 @@
 	  Ensoniq was bought by Creative Labs, Sound Blaster 64/PCI
 	  models are either ES1370 or ES1371 based. This driver differs
 	  slightly from OSS/Free, so PLEASE READ
-	  <file:Documentation/sound/es1371>.
+	  <file:Documentation/sound/oss/es1371>.
=20
 config SOUND_ESSSOLO1
 	tristate "ESS Technology Solo1"
diff -ru linux-2.6.0-vanilla/sound/oss/dmasound/Kconfig linux-2.6.0-moved-d=
ocs/sound/oss/dmasound/Kconfig
--- linux-2.6.0-vanilla/sound/oss/dmasound/Kconfig	2003-12-18 03:58:49.0000=
00000 +0100
+++ linux-2.6.0-moved-docs/sound/oss/dmasound/Kconfig	2003-12-26 15:00:16.0=
00000000 +0100
@@ -10,7 +10,7 @@
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you
 	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  <file:Documentation/kbuild/modules.txt>.
=20
 config DMASOUND_PMAC
 	tristate "PowerMac DMA sound support"
@@ -24,7 +24,7 @@
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you
 	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  <file:Documentation/kbuild/modules.txt>.
=20
 config DMASOUND_PAULA
 	tristate "Amiga DMA sound support"
@@ -38,7 +38,7 @@
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you
 	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  <file:Documentation/kbuild/modules.txt>.
=20
 config DMASOUND_Q40
 	tristate "Q40 sound support"
@@ -52,7 +52,7 @@
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you
 	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  <file:Documentation/kbuild/modules.txt>.
=20
 config DMASOUND
 	tristate
diff -ru linux-2.6.0-vanilla/sound/oss/vwsnd.c linux-2.6.0-moved-docs/sound=
/oss/vwsnd.c
--- linux-2.6.0-vanilla/sound/oss/vwsnd.c	2003-12-18 03:58:57.000000000 +01=
00
+++ linux-2.6.0-moved-docs/sound/oss/vwsnd.c	2003-12-26 15:00:12.000000000 =
+0100
@@ -1,6 +1,6 @@
 /*
  * Sound driver for Silicon Graphics 320 and 540 Visual Workstations'
- * onboard audio.  See notes in ../../Documentation/sound/vwsnd .
+ * onboard audio.  See notes in ../../Documentation/sound/oss/vwsnd .
  *
  * Copyright 1999 Silicon Graphics, Inc.  All rights reserved.
  *

--=-=-=--
