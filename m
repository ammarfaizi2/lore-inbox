Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSBMPma>; Wed, 13 Feb 2002 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSBMPmQ>; Wed, 13 Feb 2002 10:42:16 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:7827 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S287111AbSBMPl4>; Wed, 13 Feb 2002 10:41:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
Message-Id: <200202131638.39651@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Documentation/scsi/
Date: Wed, 13 Feb 2002 16:42:02 +0100
X-Mailer: KMail [version 1.3.7]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This script creates Documentation/scsi/ and moves some files into:

---
#!/bin/sh

mkdir Documentation/scsi
mv drivers/scsi/README.* Documentation/scsi/
mv drivers/scsi/ChangeLog* Documentation/scsi/
mv drivers/scsi/LICENSE.FlashPoint Documentation/scsi/
mv drivers/scsi/aic7xxx_old/README.aic7xxx Documentation/scsi/README.aic7xxx_old
mv drivers/scsi/sym53c8xx_2/ChangeLog.txt Documentation/scsi/ChangeLog.sym53c8xx_2
mv drivers/scsi/sym53c8xx_2/Documentation.txt Documentation/scsi/README.sym53c8xx_2
mv Documentation/scsi.txt Documentation/scsi/
mv Documentation/scsi-generic.txt Documentation/scsi/
---

This patch changes the references to this files. It's against 2.5.4.

Comments? Have I missed something? Marcello, do you want it for 2.4 also?

Eike

diff -Naur linux/drivers/scsi/Config.help linux-2.5.4-scsi/drivers/scsi/Config.help
--- linux/drivers/scsi/Config.help	Mon Feb 11 02:50:07 2002
+++ linux-2.5.4-scsi/drivers/scsi/Config.help	Wed Feb 13 16:25:31 2002
@@ -29,7 +29,7 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called sd_mod.o.  If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.  Do not compile this driver as a
+  <file:Documentation/scsi/scsi.txt>.  Do not compile this driver as a
   module if your root file system (the one containing the directory /)
   is located on a SCSI disk. In this case, do not compile the driver
   for your SCSI host adapter (below) as a module either.
@@ -51,14 +51,14 @@
   If you want to use a SCSI tape drive under Linux, say Y and read the
   SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, and
-  <file:drivers/scsi/README.st> in the kernel source.  This is NOT for
-  SCSI CD-ROMs.
+  <file:Documentation/scsi/README.st> in the kernel source.  This is
+  NOT for SCSI CD-ROMs.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called st.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.
+  <file:Documentation/scsi/scsi.txt>.
 
 CONFIG_CHR_DEV_OSST
   The OnStream SC-x0 SCSI tape drives can not be driven by the
@@ -70,7 +70,7 @@
   tapes (QIC-157) and can be driven by the standard driver st.
   For more information, you may have a look at the SCSI-HOWTO
   <http://www.linuxdoc.org/docs.html#howto>  and
-  <file:drivers/scsi/README.osst>  in the kernel source.
+  <file:Documentation/scsi/README.osst>  in the kernel source.
   More info on the OnStream driver may be found on
   <http://linux1.onstream.nl/test/>
   Please also have a look at the standard st docu, as most of it
@@ -80,7 +80,7 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called osst.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.
+  <file:Documentation/scsi/scsi.txt>.
 
 CONFIG_BLK_DEV_SR
   If you want to use a SCSI CD-ROM under Linux, say Y and read the
@@ -92,7 +92,7 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called sr_mod.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>.
+  <file:Documentation/scsi/scsi.txt>.
 
 CONFIG_SR_EXTRA_DEVS
   This controls the amount of additional space allocated in tables for
@@ -133,8 +133,8 @@
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>. The module will be called sg.o. If unsure,
-  say N.
+  <file:Documentation/scsi/scsi.txt>. The module will be called sg.o.
+  If unsure, say N.
 
 CONFIG_SCSI_MULTI_LUN
   If you have a SCSI device that supports more than one LUN (Logical
@@ -194,7 +194,7 @@
 
   It is explained in section 3.3 of the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>. You might also want to
-  read the file <file:drivers/scsi/README.aha152x>.
+  read the file <file:Documentation/scsi/README.aha152x>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -229,7 +229,7 @@
 CONFIG_SCSI_DPT_I2O
   This driver supports all of Adaptec's I2O based RAID controllers as 
   well as the DPT SmartRaid V cards.  This is an Adaptec maintained
-  driver by Deanna Bonds.  See <file:drivers/scsi/README.dpti>.
+  driver by Deanna Bonds.  See <file:Documentation/scsi/README.dpti>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -266,7 +266,7 @@
   Information on the configuration options for this controller can be
   found by checking the help file for each of the available
   configuration options. You should read
-  <file:drivers/scsi/aic7xxx_old/README.aic7xxx> at a minimum before
+  <file:Documentation/scsi/README.aic7xxx_old> at a minimum before
   contacting the maintainer with any questions.  The SCSI-HOWTO,
   available from <http://www.linuxdoc.org/docs.html#howto>, can also
   be of great help.
@@ -289,19 +289,19 @@
 
   If you say Y here, you can still turn off TCQ on troublesome devices
   with the use of the tag_info boot parameter.  See the file
-  <file:drivers/scsi/README.aic7xxx> for more information on that and
-  other aic7xxx setup commands.  If this option is turned off, you may
-  still enable TCQ on known good devices by use of the tag_info boot
-  parameter.
+  <file:Documentation/scsi/README.aic7xxx_old> for more information on
+  tha and other aic7xxx setup commands.  If this option is turned off,
+  you may still enable TCQ on known good devices by use of the tag_info
+  boot parameter.
 
   If you are unsure about your devices then it is safest to say N
   here.
 
   However, TCQ can increase performance on some hard drives by as much
   as 50% or more, so it is recommended that if you say N here, you
-  should at least read the <file:drivers/scsi/README.aic7xxx> file so
-  you will know how to enable this option manually should your drives
-  prove to be safe in regards to TCQ.
+  should at least read the <file:Documentation/scsi/README.aic7xxx_old>
+  file so you will know how to enable this option manually should your
+  drives prove to be safe in regards to TCQ.
 
   Conversely, certain drives are known to lock up or cause bus resets
   when TCQ is enabled on them.  If you have a Western Digital
@@ -358,10 +358,10 @@
   This is support for BusLogic MultiMaster and FlashPoint SCSI Host
   Adapters. Consult the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, and the files
-  <file:drivers/scsi/README.BusLogic> and
-  <file:drivers/scsi/README.FlashPoint> for more information. If this
-  driver does not work correctly without modification, please contact
-  the author, Leonard N. Zubkoff, by email to lnz@dandelion.com.
+  <file:Documentation/scsi/README.BusLogic> and
+  <file:Documentation/scsi/README.FlashPoint> for more information. If
+  this driver does not work correctly without modification, please
+  contact the author, Leonard N. Zubkoff, by email to lnz@dandelion.com.
 
   You can also build this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -391,7 +391,7 @@
   This is support for DTC 3180/3280 SCSI Host Adapters.  Please read
   the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, and the file
-  <file:drivers/scsi/README.dtc3x80>.
+  <file:Documentation/scsi/README.dtc3x80>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -507,7 +507,7 @@
   for the Trantor T130B in its default configuration; you might have
   to pass a command line option to the kernel at boot time if it does
   not detect your card.  See the file
-  <file:drivers/scsi/README.g_NCR5380> for details.
+  <file:Documentation/scsi/README.g_NCR5380> for details.
 
 CONFIG_SCSI_G_NCR5380_PORT
   The NCR5380 and NCR53c400 SCSI controllers come in two varieties:
@@ -536,8 +536,8 @@
   <http://www.linuxdoc.org/docs.html#howto>.  If it doesn't work out
   of the box, you may have to change some settings in
   <file:drivers/scsi/53c7,8xx.h>.  Please read
-  <file:drivers/scsi/README.ncr53c7xx> for the available boot time
-  command line options.
+  <file:Documentation/scsi/README.ncr53c7xx> for the available boot
+  time command line options.
 
   Note: there is another driver for the 53c8xx family of controllers
   ("NCR53C8XX SCSI support" below).  If you want to use them both, you
@@ -581,7 +581,7 @@
   If your system has problems using this new major version of the
   SYM53C8XX driver, you may switch back to driver version 1.
 
-  Please read <file:drivers/scsi/sym53c8xx_2/Documentation.txt> for more
+  Please read <file:Documentation/scsi/README.sym53c8xx_2> for more
   information.
 
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
@@ -638,7 +638,7 @@
   only one may be active at a time.  If you have a 53c8xx board, you
   probably do not want to use the "NCR53c7,8xx SCSI support".
 
-  Please read <file:drivers/scsi/README.ncr53c8xx> for more
+  Please read <file:Documentation/scsi/README.ncr53c8xx> for more
   information.
 
 CONFIG_SCSI_SYM53C8XX
@@ -662,7 +662,7 @@
   SYM53C8XX driver, thus allowing the NCR53C8XX driver to attach them.
   The 'excl' option is also supported by the NCR53C8XX driver.
 
-  Please read <file:drivers/scsi/README.ncr53c8xx> for more
+  Please read <file:Documentation/scsi/README.ncr53c8xx> for more
   information.
 
 CONFIG_SCSI_NCR53C8XX_SYNC
@@ -856,8 +856,8 @@
 
 CONFIG_SCSI_IN2000
   This is support for an ISA bus SCSI host adapter.  You'll find more
-  information in <file:drivers/scsi/README.in2000>. If it doesn't work
-  out of the box, you may have to change the jumpers for IRQ or
+  information in <file:Documentation/scsi/README.in2000>. If it doesn't
+  work out of the box, you may have to change the jumpers for IRQ or
   address selection.
 
   If you want to compile this as a module ( = code which can be
@@ -937,7 +937,7 @@
   SCSI support"), below.
 
   Information about this driver is contained in
-  <file:drivers/scsi/README.qlogicfas>.  You should also read the
+  <file:Documentation/scsi/README.qlogicfas>.  You should also read the
   SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>.
 
@@ -954,7 +954,7 @@
   If you say Y here, make sure to choose "BIOS" at the question "PCI
   access mode".
 
-  Please read the file <file:drivers/scsi/README.qlogicisp>.  You
+  Please read the file <file:Documentation/scsi/README.qlogicisp>.  You
   should also read the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>.
 
@@ -1133,7 +1133,7 @@
   chip, e.g. Tekram DC390(T), DawiControl 2974 and some onboard
   PCscsi/PCnet (Am53/79C974) solutions.
 
-  Documentation can be found in <file:drivers/scsi/README.tmscsim>.
+  Documentation can be found in <file:Documentation/scsi/README.tmscsim>.
 
   Note that this driver does NOT support Tekram DC390W/U/F, which are
   based on NCR/Symbios chips. Use "NCR53C8XX SCSI support" for those.
@@ -1150,7 +1150,7 @@
   EEPROM to get initial values for its settings, such as speed,
   termination, etc.  If it can't find this EEPROM, it will use
   defaults or the user supplied boot/module parameters.  For details
-  on driver configuration see <file:drivers/scsi/README.tmscsim>.
+  on driver configuration see <file:Documentation/scsi/README.tmscsim>.
 
   If you say Y here and if no EEPROM is found, the driver gives up and
   thus only supports Tekram DC390(T) adapters.  This can be useful if
@@ -1161,7 +1161,7 @@
 
 CONFIG_SCSI_AM53C974
   This is support for the AM53/79C974 SCSI host adapters.  Please read
-  <file:drivers/scsi/README.AM53C974> for details.  Also, the
+  <file:Documentation/scsi/README.AM53C974> for details.  Also, the
   SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, is for you.
 
@@ -1210,8 +1210,8 @@
   newer drives)", below.
 
   For more information about this driver and how to use it you should
-  read the file <file:drivers/scsi/README.ppa>.  You should also read
-  the SCSI-HOWTO, which is available from
+  read the file <file:Documentation/scsi/README.ppa>.  You should also
+  read the SCSI-HOWTO, which is available from
   <http://www.linuxdoc.org/docs.html#howto>.  If you use this driver,
   you will still be able to use the parallel port for other tasks,
   such as a printer; it is safe to compile both drivers into the
@@ -1236,8 +1236,8 @@
   here and Y to "IOMEGA Parallel Port (ppa - older drives)", above.
 
   For more information about this driver and how to use it you should
-  read the file <file:drivers/scsi/README.ppa>.  You should also read
-  the SCSI-HOWTO, which is available from
+  read the file <file:Documentation/scsi/README.ppa>.  You should also
+  read the SCSI-HOWTO, which is available from
   <http://www.linuxdoc.org/docs.html#howto>.  If you use this driver,
   you will still be able to use the parallel port for other tasks,
   such as a printer; it is safe to compile both drivers into the
diff -Naur linux/drivers/scsi/FlashPoint.c linux-2.5.4-scsi/drivers/scsi/FlashPoint.c
--- linux/drivers/scsi/FlashPoint.c	Mon Feb 11 02:50:12 2002
+++ linux-2.5.4-scsi/drivers/scsi/FlashPoint.c	Wed Feb 13 16:00:58 2002
@@ -11,7 +11,8 @@
   Copyright 1995-1996 by Mylex Corporation.  All Rights Reserved
 
   This file is available under both the GNU General Public License
-  and a BSD-style copyright; see LICENSE.FlashPoint for details.
+  and a BSD-style copyright; see Documentation/scsi/LICENSE.FlashPoint for
+  details.
 
 */
 
diff -Naur linux/drivers/scsi/aha152x.c linux-2.5.4-scsi/drivers/scsi/aha152x.c
--- linux/drivers/scsi/aha152x.c	Mon Feb 11 02:50:08 2002
+++ linux-2.5.4-scsi/drivers/scsi/aha152x.c	Wed Feb 13 15:52:38 2002
@@ -211,7 +211,7 @@
  *
  **************************************************************************
  
- see README.aha152x for configuration details
+ see Documentation/scsi/README.aha152x for configuration details
 
  **************************************************************************/
 
@@ -1834,7 +1834,7 @@
 				       "aha152x: unable to verify geometry for disk with >1GB.\n"
 				       "         Using default translation. Please verify yourself.\n"
 				       "         Perhaps you need to enable extended translation in the driver.\n"
-				       "         See /usr/src/linux/drivers/scsi/README.aha152x for details.\n");
+				       "         See /usr/src/linux/Documentation/scsi/README.aha152x for details.\n");
 			}
 		} else {
 			info_array[0] = info[0];
diff -Naur linux/drivers/scsi/aic7xxx/aic7xxx_linux.c linux-2.5.4-scsi/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- linux/drivers/scsi/aic7xxx/aic7xxx_linux.c	Mon Feb 11 02:50:15 2002
+++ linux-2.5.4-scsi/drivers/scsi/aic7xxx/aic7xxx_linux.c	Wed Feb 13 15:58:40 2002
@@ -1076,7 +1076,7 @@
 		aic7xxx_setup(aic7xxx);
 	if (dummy_buffer[0] != 'P')
 		printk(KERN_WARNING
-"aic7xxx: Please read the file /usr/src/linux/drivers/scsi/README.aic7xxx\n"
+"aic7xxx: Please read the file /usr/src/linux/Documentation/scsi/README.aic7xxx\n"
 "aic7xxx: to see the proper way to specify options to the aic7xxx module\n"
 "aic7xxx: Specifically, don't use any commas when passing arguments to\n"
 "aic7xxx: insmod or else it might trash certain memory areas.\n");
diff -Naur linux/drivers/scsi/aic7xxx_old.c linux-2.5.4-scsi/drivers/scsi/aic7xxx_old.c
--- linux/drivers/scsi/aic7xxx_old.c	Mon Feb 11 02:50:15 2002
+++ linux-2.5.4-scsi/drivers/scsi/aic7xxx_old.c	Wed Feb 13 15:55:44 2002
@@ -9487,8 +9487,8 @@
   if(aic7xxx)
     aic7xxx_setup(aic7xxx);
   if(dummy_buffer[0] != 'P')
-    printk(KERN_WARNING "aic7xxx: Please read the file /usr/src/linux/drivers"
-      "/scsi/README.aic7xxx\n"
+    printk(KERN_WARNING "aic7xxx: Please read the file /usr/src/linux"
+      "Documentation/scsi/README.aic7xxx_old\n"
       "aic7xxx: to see the proper way to specify options to the aic7xxx "
       "module\n"
       "aic7xxx: Specifically, don't use any commas when passing arguments to\n"
diff -Naur linux/drivers/scsi/dpt/dpti_ioctl.h linux-2.5.4-scsi/drivers/scsi/dpt/dpti_ioctl.h
--- linux/drivers/scsi/dpt/dpti_ioctl.h	Mon Feb 11 02:50:16 2002
+++ linux-2.5.4-scsi/drivers/scsi/dpt/dpti_ioctl.h	Wed Feb 13 15:58:10 2002
@@ -5,7 +5,8 @@
     copyright            : (C) 2001 by Adaptec
     email                : deanna_bonds@adaptec.com
 
-    See README.dpti for history, notes, license info, and credits
+    See Documentation/scsi/README.dpti for history, notes, license info
+    and credits
  ***************************************************************************/
 
 /***************************************************************************
diff -Naur linux/drivers/scsi/dpt_i2o.c linux-2.5.4-scsi/drivers/scsi/dpt_i2o.c
--- linux/drivers/scsi/dpt_i2o.c	Mon Feb 11 02:50:13 2002
+++ linux-2.5.4-scsi/drivers/scsi/dpt_i2o.c	Wed Feb 13 15:54:36 2002
@@ -8,7 +8,8 @@
     			   July 30, 2001 First version being submitted
 			   for inclusion in the kernel.  V2.4
 
-    See README.dpti for history, notes, license info, and credits
+    See Documentation/scsi/README.dpti for history, notes, license info
+    and credits
  ***************************************************************************/
 
 /***************************************************************************
diff -Naur linux/drivers/scsi/dpti.h linux-2.5.4-scsi/drivers/scsi/dpti.h
--- linux/drivers/scsi/dpti.h	Mon Feb 11 02:50:07 2002
+++ linux-2.5.4-scsi/drivers/scsi/dpti.h	Wed Feb 13 15:46:03 2002
@@ -5,7 +5,8 @@
     copyright            : (C) 2001 by Adaptec
     email                : deanna_bonds@adaptec.com
 
-    See README.dpti for history, notes, license info, and credits
+    See Documentation/scsi/README.dpti for history, notes, license info
+    and credits
  ***************************************************************************/
 
 /***************************************************************************
diff -Naur linux/drivers/scsi/ibmmca.c linux-2.5.4-scsi/drivers/scsi/ibmmca.c
--- linux/drivers/scsi/ibmmca.c	Mon Feb 11 02:50:09 2002
+++ linux-2.5.4-scsi/drivers/scsi/ibmmca.c	Wed Feb 13 15:53:44 2002
@@ -4,10 +4,10 @@
  Copyright (c) 1995 Strom Systems, Inc. under the terms of the GNU
  General Public License. Written by Martin Kolinek, December 1995.
  Further development by: Chris Beauregard, Klaus Kudielka, Michael Lang
- See the file README.ibmmca for a detailed description of this driver,
- the commandline arguments and the history of its development.
- See the WWW-page: http://www.uni-mainz.de/~langm000/linux.html for latest
- updates, info and ADF-files for adapters supported by this driver.
+ See the file Documentation/scsi/README.ibmmca for a detailed description
+ of this driver, the commandline arguments and the history of its
+ development. See the WWW-page: http://www.uni-mainz.de/~langm000/linux.html
+ for latest updates, info and ADF-files for adapters supported by this driver.
 */
 
 #ifndef LINUX_VERSION_CODE
diff -Naur linux/drivers/scsi/ibmmca.h linux-2.5.4-scsi/drivers/scsi/ibmmca.h
--- linux/drivers/scsi/ibmmca.h	Mon Feb 11 02:50:10 2002
+++ linux-2.5.4-scsi/drivers/scsi/ibmmca.h	Wed Feb 13 15:54:22 2002
@@ -1,8 +1,9 @@
 /* 
  * Low Level Driver for the IBM Microchannel SCSI Subsystem
- * (Headerfile, see README.ibmmca for description of the IBM MCA SCSI-driver
- * For use under the GNU General Public License within the Linux-kernel project.
- * This include file works only correctly with kernel 2.4.0 or higher!!! */
+ * (Headerfile, see Documentation/scsi/README.ibmmca for description of the
+ * IBM MCA SCSI-driver For use under the GNU General Public License within
+ * the Linux-kernel project. This include file works only correctly with
+ * kernel 2.4.0 or higher!!! */
 
 #ifndef _IBMMCA_H
 #define _IBMMCA_H
diff -Naur linux/drivers/scsi/ncr53c8xx.c linux-2.5.4-scsi/drivers/scsi/ncr53c8xx.c
--- linux/drivers/scsi/ncr53c8xx.c	Mon Feb 11 02:50:13 2002
+++ linux-2.5.4-scsi/drivers/scsi/ncr53c8xx.c	Wed Feb 13 15:54:58 2002
@@ -1625,7 +1625,7 @@
 	**	Possible data corruption during Memory Write and Invalidate.
 	**	This work-around resets the addressing logic prior to the 
 	**	start of the first MOVE of a DATA IN phase.
-	**	(See README.ncr53c8xx for more information)
+	**	(See Documentation/scsi/README.ncr53c8xx for more information)
 	*/
 	SCR_JUMPR ^ IFFALSE (IF (SCR_DATA_IN)),
 		20,
diff -Naur linux/drivers/scsi/osst.c linux-2.5.4-scsi/drivers/scsi/osst.c
--- linux/drivers/scsi/osst.c	Mon Feb 11 02:50:17 2002
+++ linux-2.5.4-scsi/drivers/scsi/osst.c	Wed Feb 13 15:55:54 2002
@@ -1,6 +1,6 @@
 /*
   SCSI Tape Driver for Linux version 1.1 and newer. See the accompanying
-  file README.st for more information.
+  file Documentation/scsi/README.st for more information.
 
   History:
 
diff -Naur linux/drivers/scsi/qla1280.c linux-2.5.4-scsi/drivers/scsi/qla1280.c
--- linux/drivers/scsi/qla1280.c	Mon Feb 11 02:50:18 2002
+++ linux-2.5.4-scsi/drivers/scsi/qla1280.c	Wed Feb 13 15:57:52 2002
@@ -776,8 +776,8 @@
     if(options)
         qla1280_setup(options, NULL);
     if(dummy_buffer[0] != 'P')
-        printk(KERN_WARNING "qla1280: Please read the file /usr/src/linux/drivers"
-                "/scsi/README.qla1280\n"
+        printk(KERN_WARNING "qla1280: Please read the file /usr/src/linux"
+                "/Documentation/scsi/README.qla1280\n"
                 "qla1280: to see the proper way to specify options to the qla1280 "
                 "module\n"
                 "qla1280: Specifically, don't use any commas when passing arguments to\n"
diff -Naur linux/drivers/scsi/st.c linux-2.5.4-scsi/drivers/scsi/st.c
--- linux/drivers/scsi/st.c	Mon Feb 11 02:50:09 2002
+++ linux-2.5.4-scsi/drivers/scsi/st.c	Wed Feb 13 15:53:12 2002
@@ -1,6 +1,6 @@
 /*
    SCSI Tape Driver for Linux version 1.1 and newer. See the accompanying
-   file README.st for more information.
+   file Documentation/scsi/README.st for more information.
 
    History:
    Rewritten from Dwayne Forsyth's SCSI tape driver by Kai Makisara.
@@ -3638,7 +3638,7 @@
 }
 
 #ifndef MODULE
-/* Set the boot options. Syntax is defined in README.st.
+/* Set the boot options. Syntax is defined in Documentation/scsi/README.st.
  */
 static int __init st_setup(char *str)
 {
diff -Naur linux/drivers/scsi/tmscsim.c linux-2.5.4-scsi/drivers/scsi/tmscsim.c
--- linux/drivers/scsi/tmscsim.c	Mon Feb 11 02:50:18 2002
+++ linux-2.5.4-scsi/drivers/scsi/tmscsim.c	Wed Feb 13 15:57:38 2002
@@ -5,7 +5,8 @@
  *		     Bus Master Host Adapter			       *
  * (C)Copyright 1995-1996 Tekram Technology Co., Ltd.		       *
  ***********************************************************************/
-/* (C) Copyright: put under GNU GPL in 10/96  (see README.tmscsim)	*
+/* (C) Copyright: put under GNU GPL in 10/96				*
+ *			(see Documentation/scsi/README.tmscsim)		*
 *************************************************************************/
 /* $Id: tmscsim.c,v 2.60.2.30 2000/12/20 01:07:12 garloff Exp $		*/
 /*	Enhancements and bugfixes by					*
@@ -1523,7 +1524,7 @@
     DC390_write32 (DMA_ScsiBusCtrl, EN_INT_ON_PCI_ABORT);
     PDEVSET1; PCI_READ_CONFIG_WORD(PDEV, PCI_STATUS, &pstat);
     printk ("DC390: Register dump: PCI Status: %04x\n", pstat);
-    printk ("DC390: In case of driver trouble read linux/drivers/scsi/README.tmscsim\n");
+    printk ("DC390: In case of driver trouble read linux/Documentation/scsi/README.tmscsim\n");
 };
 
 
