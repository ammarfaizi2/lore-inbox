Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTESUVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTESUVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:21:49 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:38921 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261916AbTESUVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:21:37 -0400
Date: Tue, 20 May 2003 05:35:09 +0900 (JST)
Message-Id: <20030520.053509.44867946.yoshfuji@wide.ad.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] eliminate "make dep" from Documentation
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"make dep" is obsolete.  Eliminate it from Documentation.
Patch is against 2.5.69.

Index: linux25-LINUS/Documentation/README.DAC960
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/README.DAC960,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 README.DAC960
--- linux25-LINUS/Documentation/README.DAC960	7 Oct 2002 10:22:41 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/README.DAC960	19 May 2003 20:20:08 -0000
@@ -212,7 +212,6 @@
   patch -p0 < DAC960.patch (if DAC960.patch is included)
   cd linux
   make config
-  make depend
   make bzImage (or zImage)
 
 Then install "arch/i386/boot/bzImage" or "arch/i386/boot/zImage" as your
Index: linux25-LINUS/Documentation/computone.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/computone.txt,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 computone.txt
--- linux25-LINUS/Documentation/computone.txt	13 Mar 2003 17:30:13 -0000	1.1.1.2
+++ linux25-LINUS/Documentation/computone.txt	19 May 2003 20:20:08 -0000
@@ -60,12 +60,11 @@
 	or
    edit /etc/modules.conf if needed (module).
 	or both to match this setting.
-d) Run "make dep"
-e) Run "make modules"
-f) Run "make modules_install"
-g) Run "/sbin/depmod -a"
-h) install driver using `modprobe ip2 <options>` (options listed below)
-i) run ip2mkdev (either the script below or the binary version)
+d) Run "make modules"
+e) Run "make modules_install"
+f) Run "/sbin/depmod -a"
+g) install driver using `modprobe ip2 <options>` (options listed below)
+h) run ip2mkdev (either the script below or the binary version)
 
 
 Kernel installation:
@@ -77,13 +76,12 @@
 c) Set address on ISA cards then:
 	   edit /usr/src/linux/drivers/char/ip2.c  
            (Optional - may be specified on kernel command line now)
-d) Run "make dep"
-e) Run "make zImage" or whatever target you prefer.
-f) mv /usr/src/linux/arch/i386/boot/zImage to /boot.
-g) Add new config for this kernel into /etc/lilo.conf, run "lilo"
+d) Run "make zImage" or whatever target you prefer.
+e) mv /usr/src/linux/arch/i386/boot/zImage to /boot.
+f) Add new config for this kernel into /etc/lilo.conf, run "lilo"
 	or copy to a floppy disk and boot from that floppy disk.
-h) Reboot using this kernel
-i) run ip2mkdev (either the script below or the binary version)
+g) Reboot using this kernel
+h) run ip2mkdev (either the script below or the binary version)
 
 Kernel command line options:
 
@@ -176,7 +174,6 @@
 
 If you select the driver as part of the kernel run :
 
-	make depend
 	make zlilo (or whatever you do to create a bootable kernel)
 
 If you selected a module run :
Index: linux25-LINUS/Documentation/moxa-smartio
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/moxa-smartio,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 moxa-smartio
--- linux25-LINUS/Documentation/moxa-smartio	7 Oct 2002 10:22:41 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/moxa-smartio	19 May 2003 20:20:08 -0000
@@ -254,19 +254,18 @@
 
 	   a. cd /usr/src/linux
 	   b. make clean			     /* take a few minutes */
-	   c. make dep				     /* take a few minutes */
-	   d. make bzImage		   /* take probably 10-20 minutes */
-	   e. Backup original boot kernel.		  /* optional step */
-	   f. cp /usr/src/linux/arch/i386/boot/bzImage /boot/vmlinuz
-	   g. Please make sure the boot kernel (vmlinuz) is in the
+	   c. make bzImage		   /* take probably 10-20 minutes */
+	   d. Backup original boot kernel.		  /* optional step */
+	   e. cp /usr/src/linux/arch/i386/boot/bzImage /boot/vmlinuz
+	   f. Please make sure the boot kernel (vmlinuz) is in the
 	      correct position. If you use 'lilo' utility, you should
 	      check /etc/lilo.conf 'image' item specified the path
 	      which is the 'vmlinuz' path, or you will load wrong
 	      (or old) boot kernel image (vmlinuz).
-	   h. chmod 400 /vmlinuz
-	   i. lilo
-	   j. rdev -R /vmlinuz 1
-	   k. sync
+	   g. chmod 400 /vmlinuz
+	   h. lilo
+	   i. rdev -R /vmlinuz 1
+	   j. sync
 
 	  Note that if the result of "make zImage" is ERROR, then you have to
 	  go back to Linux configuration Setup. Type "make config" in directory
Index: linux25-LINUS/Documentation/smp.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/smp.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.txt
--- linux25-LINUS/Documentation/smp.txt	7 Oct 2002 10:22:41 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/smp.txt	19 May 2003 20:20:08 -0000
@@ -15,7 +15,7 @@
 Of course you should time how long each build takes :-)
 Example:
    make config
-   time -v sh -c 'make dep ; make clean install modules modules_install'
+   time -v sh -c 'make clean install modules modules_install'
 
 If you are using some Compaq MP compliant machines you will need to set
 the operating system in the BIOS settings to "Unixware" - don't ask me
Index: linux25-LINUS/Documentation/DocBook/sis900.tmpl
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/DocBook/sis900.tmpl,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 sis900.tmpl
--- linux25-LINUS/Documentation/DocBook/sis900.tmpl	13 Mar 2003 17:30:13 -0000	1.1.1.2
+++ linux25-LINUS/Documentation/DocBook/sis900.tmpl	19 May 2003 20:20:08 -0000
@@ -471,8 +471,6 @@
 </Para>
 
 <Para><screen>
-make dep
-
 make clean
 
 make bzlilo
Index: linux25-LINUS/Documentation/arm/README
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/README,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 README
--- linux25-LINUS/Documentation/arm/README	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/README	19 May 2003 20:20:08 -0000
@@ -30,9 +30,9 @@
 	eg.
     CROSS_COMPILE=arm-linux-
 
-  Do a 'make config', followed by 'make dep', and finally 'make Image' to
-  build the kernel (arch/arm/boot/Image).  A compressed image can be built
-  by doing a 'make zImage' instead of 'make Image'.
+  Do a 'make config', followed by 'make Image' to build the kernel 
+  (arch/arm/boot/Image).  A compressed image can be built by doing a 
+  'make zImage' instead of 'make Image'.
 
 
 Bug reports etc
Index: linux25-LINUS/Documentation/arm/SA1100/Assabet
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/SA1100/Assabet,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Assabet
--- linux25-LINUS/Documentation/arm/SA1100/Assabet	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/SA1100/Assabet	19 May 2003 20:20:08 -0000
@@ -16,7 +16,6 @@
 
 	make assabet_config
 	make oldconfig
-	make dep
 	make zImage
 
 The resulting kernel image should be available in linux/arch/arm/boot/zImage.
Index: linux25-LINUS/Documentation/arm/SA1100/Brutus
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/SA1100/Brutus,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Brutus
--- linux25-LINUS/Documentation/arm/SA1100/Brutus	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/SA1100/Brutus	19 May 2003 20:20:08 -0000
@@ -8,7 +8,6 @@
 	make brutus_config
 	make config
 	[accept all the defaults]
-	make dep
 	make zImage
 
 The resulting kernel will end up in linux/arch/arm/boot/zImage.  This file
Index: linux25-LINUS/Documentation/arm/SA1100/CERF
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/SA1100/CERF,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 CERF
--- linux25-LINUS/Documentation/arm/SA1100/CERF	10 Feb 2003 19:40:32 -0000	1.1.1.2
+++ linux25-LINUS/Documentation/arm/SA1100/CERF	19 May 2003 20:20:08 -0000
@@ -26,7 +26,6 @@
 
    make cerf_config
    make xconfig
-   make dep
    make zImage
    cp arch/arm/boot/zImage <TFTP directory>
 
Index: linux25-LINUS/Documentation/arm/SA1100/HUW_WEBPANEL
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/SA1100/HUW_WEBPANEL,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 HUW_WEBPANEL
--- linux25-LINUS/Documentation/arm/SA1100/HUW_WEBPANEL	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/SA1100/HUW_WEBPANEL	19 May 2003 20:20:08 -0000
@@ -7,7 +7,6 @@
 	make huw_webpanel_config
 	make oldconfig
 	[accept all defaults]
-	make dep
 	make zImage
 
 Mostly of the work is done by:
Index: linux25-LINUS/Documentation/arm/SA1100/Itsy
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/SA1100/Itsy,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Itsy
--- linux25-LINUS/Documentation/arm/SA1100/Itsy	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/SA1100/Itsy	19 May 2003 20:20:08 -0000
@@ -13,7 +13,7 @@
 enabled.
 
 To build, do a "make menuconfig" (or xmenuconfig) and select Itsy support.
-Disable Flash and LCD support. and then do a make dep and a make zImage.
+Disable Flash and LCD support. and then do a make zImage.
 Finally, you will need to cd to arch/arm/boot/tools and execute a make there
 to build the params-itsy program used to boot the kernel.
 
Index: linux25-LINUS/Documentation/arm/SA1100/Pangolin
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/SA1100/Pangolin,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Pangolin
--- linux25-LINUS/Documentation/arm/SA1100/Pangolin	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/SA1100/Pangolin	19 May 2003 20:20:08 -0000
@@ -8,7 +8,6 @@
 
 	make pangolin_config
 	make oldconfig
-	make dep
 	make zImage
 
 Supported peripherals:
Index: linux25-LINUS/Documentation/arm/XScale/ADIFCC/80200EVB
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/XScale/ADIFCC/80200EVB,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 80200EVB
--- linux25-LINUS/Documentation/arm/XScale/ADIFCC/80200EVB	16 Oct 2002 04:25:16 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/XScale/ADIFCC/80200EVB	19 May 2003 20:20:08 -0000
@@ -35,7 +35,6 @@
 change Linux makefile
 make adi_evb_config
 make oldconfig
-make dep
 make zImage
 
 Loading Linux
Index: linux25-LINUS/Documentation/arm/XScale/IOP3XX/IQ80310
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/XScale/IOP3XX/IQ80310,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 IQ80310
--- linux25-LINUS/Documentation/arm/XScale/IOP3XX/IQ80310	5 Mar 2003 14:56:19 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/XScale/IOP3XX/IQ80310	19 May 2003 20:20:08 -0000
@@ -39,7 +39,6 @@
 -----------------------------
 make iq80310_config
 make oldconfig
-make dep
 make zImage
 
 This will build an image setup for BOOTP/NFS root support.  To change this,
Index: linux25-LINUS/Documentation/arm/XScale/IOP3XX/IQ80321
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/arm/XScale/IOP3XX/IQ80321,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 IQ80321
--- linux25-LINUS/Documentation/arm/XScale/IOP3XX/IQ80321	5 Mar 2003 14:56:19 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/arm/XScale/IOP3XX/IQ80321	19 May 2003 20:20:08 -0000
@@ -37,7 +37,6 @@
 -----------------------------
 make iq80321_config
 make oldconfig
-make dep
 make zImage
 
 This will build an image setup for BOOTP/NFS root support.  To change this,
Index: linux25-LINUS/Documentation/cdrom/cm206
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/cdrom/cm206,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cm206
--- linux25-LINUS/Documentation/cdrom/cm206	7 Oct 2002 10:22:43 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/cdrom/cm206	19 May 2003 20:20:08 -0000
@@ -56,7 +56,7 @@
 
 2) then do a 
 	
-	make dep; make clean; make zImage; make modules
+	make clean; make zImage; make modules
 
 3) do the usual things to install a new image (backup the old one, run
    `rdev -R zImage 1', copy the new image in place, run lilo).  Might
Index: linux25-LINUS/Documentation/cdrom/gscd
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/cdrom/gscd,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 gscd
--- linux25-LINUS/Documentation/cdrom/gscd	7 Oct 2002 10:22:43 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/cdrom/gscd	19 May 2003 20:20:08 -0000
@@ -37,7 +37,7 @@
 like a module, don't select 'GoldStar CDROM support'. By the way, you
 have to include the iso9660 filesystem.
 
-Now start compiling the kernel with 'make dep ; make zImage'.
+Now start compiling the kernel with 'make zImage'.
 If you want to use the driver as a module, you have to do 'make modules' 
 and 'make modules_install', additionally.
 Install your new kernel as usual - maybe you do it with 'make zlilo'.
Index: linux25-LINUS/Documentation/cdrom/sbpcd
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/cdrom/sbpcd,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sbpcd
--- linux25-LINUS/Documentation/cdrom/sbpcd	7 Oct 2002 10:22:43 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/cdrom/sbpcd	19 May 2003 20:20:08 -0000
@@ -229,7 +229,7 @@
    second, third, or fourth controller installed, do not say "y" to the 
    secondary Matsushita CD-ROM questions.
 
-3. Then do a "make dep", then make the kernel image ("make zlilo" or similar).
+3. Then make the kernel image ("make zlilo" or similar).
 
 4. Make the device file(s). This step usually already has been done by the
    MAKEDEV script.
Index: linux25-LINUS/Documentation/filesystems/devfs/README
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/filesystems/devfs/README,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 README
--- linux25-LINUS/Documentation/filesystems/devfs/README	13 Mar 2003 17:30:15 -0000	1.1.1.2
+++ linux25-LINUS/Documentation/filesystems/devfs/README	19 May 2003 20:20:09 -0000
@@ -710,9 +710,8 @@
 Finally, you need to make sure devfs is compiled into your kernel. Set
 CONFIG_EXPERIMENTAL=y, CONFIG_DEVFS_FS=y and CONFIG_DEVFS_MOUNT=y by
 using favourite configuration tool (i.e. make config or
-make xconfig) and then make dep; make clean and then
-recompile your kernel and modules. At boot, devfs will be mounted onto
-/dev.
+make xconfig) and then make clean and then recompile your kernel and 
+modules. At boot, devfs will be mounted onto /dev.
 
 If you encounter problems booting (for example if you forgot a
 configuration step), you can pass devfs=nomount at the kernel
Index: linux25-LINUS/Documentation/isdn/README.HiSax
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/isdn/README.HiSax,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 README.HiSax
--- linux25-LINUS/Documentation/isdn/README.HiSax	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/isdn/README.HiSax	19 May 2003 20:20:09 -0000
@@ -504,7 +504,7 @@
      cd /usr/src/linux
      make menuconfig
      <ISDN subsystem - ISDN support -- HiSax>
-     make clean; make dep; make zImage; make modules; make modules_install
+     make clean; make zImage; make modules; make modules_install
 2. Install the new kernel
      cp /usr/src/linux/arch/i386/boot/zImage /etc/kernel/linux.isdn
      vi /etc/lilo.conf
Index: linux25-LINUS/Documentation/kbuild/commands.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/kbuild/commands.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 commands.txt
--- linux25-LINUS/Documentation/kbuild/commands.txt	7 Oct 2002 10:22:44 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/kbuild/commands.txt	19 May 2003 20:20:09 -0000
@@ -17,7 +17,6 @@
 you need:
 
     make config
-    make dep
     make bzImage
 
 Instead of 'make config', you can run 'make menuconfig' for a full-screen
Index: linux25-LINUS/Documentation/networking/DLINK.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/networking/DLINK.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 DLINK.txt
--- linux25-LINUS/Documentation/networking/DLINK.txt	7 Oct 2002 10:22:45 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/networking/DLINK.txt	19 May 2003 20:20:09 -0000
@@ -93,7 +93,6 @@
 	  (else included in the kernel:)
 	  #  make config (answer yes on CONFIG _NET, _INET and _DE600 or _DE620)
 	  # make clean
-	  # make depend
 	  # make zImage (or whatever magic you usually do)
 
 	o I use lilo to boot multiple kernels, so that I at least
Index: linux25-LINUS/Documentation/networking/arcnet.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/networking/arcnet.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 arcnet.txt
--- linux25-LINUS/Documentation/networking/arcnet.txt	7 Oct 2002 10:22:45 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/networking/arcnet.txt	19 May 2003 20:20:09 -0000
@@ -108,7 +108,6 @@
 	make config
 		(be sure to choose ARCnet in the network devices 
 		and at least one chipset driver.)
-	make dep
 	make clean
 	make zImage
 	
Index: linux25-LINUS/Documentation/networking/cs89x0.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/networking/cs89x0.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cs89x0.txt
--- linux25-LINUS/Documentation/networking/cs89x0.txt	7 Oct 2002 10:22:45 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/networking/cs89x0.txt	19 May 2003 20:20:09 -0000
@@ -437,8 +437,8 @@
 into the /usr/src/linux/drivers/net directory.
 
 
-3.) Go to /usr/src/linux directory and run 'make config' followed by 'make dep' 
-and finally 'make' (or make bzImage) to rebuild the kernel. 
+3.) Go to /usr/src/linux directory and run 'make config' followed by 'make' 
+(or make bzImage) to rebuild the kernel. 
 
 4.) Use the DOS 'setup' utility to disable plug and play on the NIC.
 
Index: linux25-LINUS/Documentation/networking/ip-sysctl.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/networking/ip-sysctl.txt,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 ip-sysctl.txt
--- linux25-LINUS/Documentation/networking/ip-sysctl.txt	25 Feb 2003 05:33:19 -0000	1.1.1.5
+++ linux25-LINUS/Documentation/networking/ip-sysctl.txt	19 May 2003 20:20:09 -0000
@@ -613,12 +613,6 @@
 	routers are present.
 	Default: 3
 
-icmp/*:
-ratelimit - INTEGER
-	Limit the maximal rates for sending ICMPv6 packets.
-	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
-	Default: 100
-
 use_tempaddr - INTEGER
 	Preference for Privacy Extensions (RFC3041).
 	  <= 0 : disable Privacy Extensions
@@ -648,6 +642,12 @@
 	Number of attempts before give up attempting to generate
 	valid temporary addresses.
 	Default: 5
+
+icmp/*:
+ratelimit - INTEGER
+	Limit the maximal rates for sending ICMPv6 packets.
+	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
+	Default: 100
 
 
 IPv6 Update by:
Index: linux25-LINUS/Documentation/networking/sis900.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/networking/sis900.txt,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 sis900.txt
--- linux25-LINUS/Documentation/networking/sis900.txt	13 Mar 2003 17:30:14 -0000	1.1.1.2
+++ linux25-LINUS/Documentation/networking/sis900.txt	19 May 2003 20:20:09 -0000
@@ -215,8 +215,6 @@
    on "SiS 900/7016 PCI Fast Ethernet Adapter support" when configuring
    the kernel. Build the kernel image in the usual way
    
-make dep
-
 make clean
 
 make bzlilo
Index: linux25-LINUS/Documentation/s390/3270.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/s390/3270.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 3270.txt
--- linux25-LINUS/Documentation/s390/3270.txt	7 Oct 2002 10:22:42 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/s390/3270.txt	19 May 2003 20:20:09 -0000
@@ -79,7 +79,6 @@
 		(If you wish to disable 3215 console support, edit
 		.config; change CONFIG_TN3215's value to "n";
 		and rerun "make oldconfig".)
-		make dep
 		make image
 		make modules
 		make modules_install
Index: linux25-LINUS/Documentation/scsi/BusLogic.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/scsi/BusLogic.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 BusLogic.txt
--- linux25-LINUS/Documentation/scsi/BusLogic.txt	18 Nov 2002 14:59:02 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/scsi/BusLogic.txt	19 May 2003 20:20:09 -0000
@@ -597,7 +597,6 @@
   patch -p0 < BusLogic.patch (only for 2.0.33 and below)
   cd linux
   make config
-  make depend
   make zImage
 
 Then install "arch/i386/boot/zImage" as your standard kernel, run lilo if
Index: linux25-LINUS/Documentation/scsi/cpqfc.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/scsi/cpqfc.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpqfc.txt
--- linux25-LINUS/Documentation/scsi/cpqfc.txt	18 Nov 2002 14:59:02 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/scsi/cpqfc.txt	19 May 2003 20:20:09 -0000
@@ -102,7 +102,6 @@
 Installation:
 make menuconfig
   (select SCSI low-level, Compaq FC HBA)
-make dep
 make modules
 make modules_install
 
Index: linux25-LINUS/Documentation/sound/oss/Introduction
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/sound/oss/Introduction,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 Introduction
--- linux25-LINUS/Documentation/sound/oss/Introduction	2 Jan 2003 15:22:14 -0000	1.1.1.2
+++ linux25-LINUS/Documentation/sound/oss/Introduction	19 May 2003 20:20:10 -0000
@@ -114,8 +114,7 @@
     Blaster, etc., select M (module) for OSS sound modules.
     [thanks to Marvin Stodolsky <stodolsk@erols.com>]A
 
-5.  Make the kernel (e.g., make dep ; make bzImage), and install
-    the kernel.
+5.  Make the kernel (e.g., make bzImage), and install the kernel.
 
 6.  Make the modules and install them (make modules; make modules_install).
 
Index: linux25-LINUS/Documentation/sound/oss/README.OSS
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/sound/oss/README.OSS,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 README.OSS
--- linux25-LINUS/Documentation/sound/oss/README.OSS	7 Oct 2002 10:22:43 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/sound/oss/README.OSS	19 May 2003 20:20:10 -0000
@@ -722,8 +722,8 @@
 (after the questions about mouse, CD-ROM, ftape, etc. support).  Questions
 about options for sound will then be asked.
 
-After configuring the kernel and sound driver, run "make dep" and compile
-the kernel following instructions in the kernel README.
+After configuring the kernel and sound driver and compile the kernel 
+following instructions in the kernel README.
 
 The sound driver configuration dialog
 -------------------------------------
Index: linux25-LINUS/Documentation/sound/oss/Wavefront
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/sound/oss/Wavefront,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 Wavefront
--- linux25-LINUS/Documentation/sound/oss/Wavefront	5 Mar 2003 14:56:19 -0000	1.1.1.2
+++ linux25-LINUS/Documentation/sound/oss/Wavefront	19 May 2003 20:20:10 -0000
@@ -139,7 +139,6 @@
 	      soundcards you want support for)
 
 
-   make dep
    make boot
    .
    .
Index: linux25-LINUS/Documentation/telephony/ixj.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/telephony/ixj.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ixj.txt
--- linux25-LINUS/Documentation/telephony/ixj.txt	7 Oct 2002 10:22:45 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/telephony/ixj.txt	19 May 2003 20:20:10 -0000
@@ -363,7 +363,7 @@
     1.  cp .config /tmp
     2.  make mrproper
     3.  cp /tmp/.config .
-    4.	make dep;make clean;make bzImage;make modules;make modules_install
+    4.	make clean;make bzImage;make modules;make modules_install
 
 This rebuilds both the kernel and all the modules and makes sure they all 
 have the same linkages.  This generally solves the problem once the new 
Index: linux25-LINUS/Documentation/video4linux/CQcam.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/video4linux/CQcam.txt,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 CQcam.txt
--- linux25-LINUS/Documentation/video4linux/CQcam.txt	7 Oct 2002 10:22:46 -0000	1.1.1.1
+++ linux25-LINUS/Documentation/video4linux/CQcam.txt	19 May 2003 20:20:10 -0000
@@ -50,8 +50,7 @@
   With these flags, the kernel should compile and install the modules.
 To record and monitor the compilation, I use:
 
- (make dep; \
-  make zlilo ; \
+ (make zlilo ; \
   make modules; \
   make modules_install ; 
   depmod -a ) &>log &

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
