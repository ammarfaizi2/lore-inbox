Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTASKHC>; Sun, 19 Jan 2003 05:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTASKHC>; Sun, 19 Jan 2003 05:07:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8159 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267431AbTASKHB>; Sun, 19 Jan 2003 05:07:01 -0500
Date: Sun, 19 Jan 2003 11:15:57 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] ACPI: remove #include <linux/compatmac.h>'s
Message-ID: <20030119101557.GZ10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.59 eight ACPI files #include <linux/compatmac.h> but none of them 
uses anything from this header file.

The patch below removes these #include <linux/compatmac.h>'s.

I've tested the compilation with 2.5.59.

Please apply
Adrian


--- linux-2.5.59-full/drivers/acpi/button.c.old	2003-01-19 11:08:47.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/button.c	2003-01-19 11:08:56.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include "acpi_bus.h"
--- linux-2.5.59-full/drivers/acpi/fan.c.old	2003-01-19 11:08:57.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/fan.c	2003-01-19 11:09:05.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include "acpi_bus.h"
 #include "acpi_drivers.h"
--- linux-2.5.59-full/drivers/acpi/ac.c.old	2003-01-19 11:09:05.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/ac.c	2003-01-19 11:09:13.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include "acpi_bus.h"
--- linux-2.5.59-full/drivers/acpi/power.c.old	2003-01-19 11:09:14.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/power.c	2003-01-19 11:09:21.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include "acpi_bus.h"
--- linux-2.5.59-full/drivers/acpi/ec.c.old	2003-01-19 11:09:22.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/ec.c	2003-01-19 11:09:29.000000000 +0100
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/delay.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <asm/io.h>
 #include "acpi_bus.h"
--- linux-2.5.59-full/drivers/acpi/processor.c.old	2003-01-19 11:09:30.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/processor.c	2003-01-19 11:09:38.000000000 +0100
@@ -38,7 +38,6 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/delay.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include "acpi_bus.h"
--- linux-2.5.59-full/drivers/acpi/battery.c.old	2003-01-19 11:09:38.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/battery.c	2003-01-19 11:09:46.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include "acpi_bus.h"
 #include "acpi_drivers.h"
--- linux-2.5.59-full/drivers/acpi/thermal.c.old	2003-01-19 11:09:46.000000000 +0100
+++ linux-2.5.59-full/drivers/acpi/thermal.c	2003-01-19 11:09:54.000000000 +0100
@@ -35,7 +35,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/sched.h>
 #include <linux/kmod.h>
