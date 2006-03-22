Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWCVSt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWCVSt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWCVSt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:49:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932328AbWCVSt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:49:56 -0500
Date: Wed, 22 Mar 2006 10:49:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [GIT PATCH] pending SCSI updates for post 2.6.16
In-Reply-To: <20060322083647.cc0ccdd4.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0603221048210.26286@g5.osdl.org>
References: <1142956795.4377.19.camel@mulgrave.il.steeleye.com>
 <20060322083647.cc0ccdd4.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Mar 2006, Randy.Dunlap wrote:
> 
> Can we get a SCSI_DEBUG link order change (or force it to not
> built-in)?

Just something like this? Or did you have something else in mind?

(Pls test and ack).

		Linus

----
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 15dc2e0..4f907da 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -117,7 +117,6 @@ obj-$(CONFIG_SCSI_PPA)		+= ppa.o
 obj-$(CONFIG_SCSI_IMM)		+= imm.o
 obj-$(CONFIG_JAZZ_ESP)		+= NCR53C9x.o	jazz_esp.o
 obj-$(CONFIG_SUN3X_ESP)		+= NCR53C9x.o	sun3x_esp.o
-obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 obj-$(CONFIG_SCSI_FCAL)		+= fcal.o
 obj-$(CONFIG_SCSI_LASI700)	+= 53c700.o lasi700.o
 obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
@@ -148,6 +147,8 @@ obj-$(CONFIG_BLK_DEV_SR)	+= sr_mod.o
 obj-$(CONFIG_CHR_DEV_SG)	+= sg.o
 obj-$(CONFIG_CHR_DEV_SCH)	+= ch.o
 
+obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
+
 scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o constants.o \
 				   scsicam.o scsi_error.o scsi_lib.o \
 				   scsi_scan.o scsi_sysfs.o \
