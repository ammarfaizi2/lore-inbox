Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTAJJ7J>; Fri, 10 Jan 2003 04:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTAJJ7J>; Fri, 10 Jan 2003 04:59:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9717 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264788AbTAJJ7I>; Fri, 10 Jan 2003 04:59:08 -0500
Date: Fri, 10 Jan 2003 11:07:48 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: ralf@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove LINUX_VERSION_CODE from arch/mips/au1000/common/serial.c
Message-ID: <20030110100748.GD6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

the patch below removes two no longer needed LINUX_VERSION_CODE from 
arch/mips/au1000/common/serial.c (not needed since CONFIG_DEVFS_FS is 
never defined on 2.2 kernels). It applies against 2.5.55 and current 
MIPS cvs.

cu
Adrian

--- linux-2.5.55/arch/mips/au1000/common/serial.c.old	2003-01-10 10:56:15.000000000 +0100
+++ linux-2.5.55/arch/mips/au1000/common/serial.c	2003-01-10 10:57:08.000000000 +0100
@@ -2588,7 +2588,7 @@
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
 	serial_driver.driver_name = "serial";
-#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
+#if defined(CONFIG_DEVFS_FS)
 	serial_driver.name = "tts/%d";
 #else
 	serial_driver.name = "ttyS";
@@ -2632,7 +2632,7 @@
 	 * major number and the subtype code.
 	 */
 	callout_driver = serial_driver;
-#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
+#if defined(CONFIG_DEVFS_FS)
 	callout_driver.name = "cua/%d";
 #else
 	callout_driver.name = "cua";

