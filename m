Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbTGOMIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbTGOMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:07:16 -0400
Received: from mail.convergence.de ([212.84.236.4]:32672 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267341AbTGOMGF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:05 -0400
Subject: [PATCH 2/17] Various small fixes in dvb-core
In-Reply-To: <1058271653486@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:53 +0200
Message-Id: <10582716533707@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - indentation fixes in dvb_demux.c
[DVB] - include cleanup in various files
[DVB] - simplify dvb/ttpci/Makefile
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_demux.c
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_demux.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_demux.c	2003-06-18 13:59:33.000000000 +0200
@@ -1110,8 +1130,8 @@
 	return 0;
 }
 
-int 
-dvb_dmx_init(struct dvb_demux *dvbdemux)
+
+int dvb_dmx_init(struct dvb_demux *dvbdemux)
 {
 	int i, err;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
@@ -1181,8 +1207,8 @@
 	return 0;
 }
 
-int 
-dvb_dmx_release(struct dvb_demux *dvbdemux)
+
+int dvb_dmx_release(struct dvb_demux *dvbdemux)
 {
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_functions.c linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_functions.c
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_functions.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_functions.c	2003-06-18 13:51:03.000000000 +0200
@@ -1,10 +1,10 @@
 #include <linux/version.h>
-#include <linux/string.h>
-#include <linux/smp_lock.h>
-#include <linux/fs.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/string.h>
 #include <linux/module.h>
 #include <linux/ioctl.h>
 #include <linux/slab.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_functions.h linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_functions.h
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_functions.h	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_functions.h	2003-06-23 12:40:49.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __DVB_FUNCTIONS_H__
 #define __DVB_FUNCTIONS_H__
 
+#include <linux/version.h>
+
 /**
  *  a sleeping delay function, waits i ms
  *

diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvbdev.c linux-2.5.73.work/drivers/media/dvb/dvb-core/dvbdev.c
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvbdev.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvbdev.c	2003-06-18 13:51:03.000000000 +0200
@@ -29,8 +29,6 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/version.h>
-#include <asm/semaphore.h>
 
 #include "dvbdev.h"
 #include "dvb_functions.h"
 int dvb_generic_open(struct inode *inode, struct file *file)
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvbdev.h linux-2.5.73.work/drivers/media/dvb/dvb-core/dvbdev.h
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvbdev.h	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvbdev.h	2003-06-18 13:51:03.000000000 +0200
@@ -27,8 +27,9 @@
 #include <linux/types.h>
 #include <linux/poll.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/list.h>
+#include <linux/version.h>
+#include <linux/devfs_fs_kernel.h>
 
 #define DVB_MAJOR 250
 
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/ttpci/Makefile linux-2.5.73.work/drivers/media/dvb/ttpci/Makefile
--- linux-2.5.73.bk/drivers/media/dvb/ttpci/Makefile	2003-06-25 09:41:45.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/Makefile	2003-06-23 12:40:49.000000000 +0200
@@ -3,16 +3,12 @@
 # and the AV7110 DVB device driver
 #
 
-dvb-ttpci-budget-objs := budget.o
-dvb-ttpci-budget-av-objs := budget-av.o
-dvb-ttpci-budget-ci-objs := budget-ci.o
-dvb-ttpci-budget-patch-objs := budget-patch.o
 dvb-ttpci-objs := av7110.o av7110_ipack.o av7110_ir.o
 
-obj-$(CONFIG_DVB_BUDGET) += budget-core.o dvb-ttpci-budget.o
-obj-$(CONFIG_DVB_BUDGET_CI) += budget-core.o dvb-ttpci-budget-ci.o
-obj-$(CONFIG_DVB_BUDGET_AV) += budget-core.o dvb-ttpci-budget-av.o
-obj-$(CONFIG_DVB_BUDGET_PATCH) += budget-core.o dvb-ttpci-budget-patch.o
-obj-$(CONFIG_DVB_AV7110) += dvb-ttpci.o
+obj-$(CONFIG_DVB_BUDGET) += budget-core.o budget.o ttpci-eeprom.o
+obj-$(CONFIG_DVB_BUDGET_AV) += budget-core.o budget-av.o ttpci-eeprom.o
+obj-$(CONFIG_DVB_BUDGET_CI) += budget-core.o budget-ci.o ttpci-eeprom.o
+obj-$(CONFIG_DVB_BUDGET_PATCH) += budget-core.o budget-patch.o ttpci-eeprom.o
+obj-$(CONFIG_DVB_AV7110) += dvb-ttpci.o ttpci-eeprom.o
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/

