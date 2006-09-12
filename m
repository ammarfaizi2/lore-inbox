Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWILUIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWILUIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWILUIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:08:37 -0400
Received: from server6.greatnet.de ([83.133.96.26]:22689 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030396AbWILUIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:08:36 -0400
Message-ID: <450713C4.2050303@nachtwindheim.de>
Date: Tue, 12 Sep 2006 22:08:36 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] 53c7xx linked drivers: Scsi_Cmnd to struct scsi_cmnd
 convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Chenges obsolete typedef'd Scsi_Cmnd into struct scsi_cmnd for drivers
which use 53c7xx.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6/drivers/scsi/amiga7xx.h devel/drivers/scsi/amiga7xx.h
--- linux-2.6/drivers/scsi/amiga7xx.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/amiga7xx.h	2006-09-12 21:13:15.000000000 +0200
@@ -4,10 +4,11 @@
 
 int amiga7xx_detect(struct scsi_host_template *);
 const char *NCR53c7x0_info(void);
-int NCR53c7xx_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int NCR53c7xx_abort(Scsi_Cmnd *);
+int NCR53c7xx_queue_command(struct scsi_cmnd *,
+			    void (*done) (struct scsi_cmnd *));
+int NCR53c7xx_abort(struct scsi_cmnd *);
 int NCR53c7x0_release (struct Scsi_Host *);
-int NCR53c7xx_reset(Scsi_Cmnd *, unsigned int);
+int NCR53c7xx_reset(struct scsi_cmnd *, unsigned int);
 void NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs);
 
 #ifndef CMD_PER_LUN
diff -ruN linux-2.6/drivers/scsi/bvme6000.h devel/drivers/scsi/bvme6000.h
--- linux-2.6/drivers/scsi/bvme6000.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/bvme6000.h	2006-09-12 21:18:50.000000000 +0200
@@ -5,10 +5,11 @@
 
 int bvme6000_scsi_detect(struct scsi_host_template *);
 const char *NCR53c7x0_info(void);
-int NCR53c7xx_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int NCR53c7xx_abort(Scsi_Cmnd *);
+int NCR53c7xx_queue_command(struct scsi_cmnd *,
+			    void (*done) (struct scsi_cmnd *));
+int NCR53c7xx_abort(struct scsi_cmnd *);
 int NCR53c7x0_release (struct Scsi_Host *);
-int NCR53c7xx_reset(Scsi_Cmnd *, unsigned int);
+int NCR53c7xx_reset(struct scsi_cmnd *, unsigned int);
 void NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs);
 
 #ifndef CMD_PER_LUN
diff -ruN linux-2.6/drivers/scsi/mvme16x.h devel/drivers/scsi/mvme16x.h
--- linux-2.6/drivers/scsi/mvme16x.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/mvme16x.h	2006-09-12 21:16:20.000000000 +0200
@@ -5,10 +5,11 @@
 
 int mvme16x_scsi_detect(struct scsi_host_template *);
 const char *NCR53c7x0_info(void);
-int NCR53c7xx_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int NCR53c7xx_abort(Scsi_Cmnd *);
+int NCR53c7xx_queue_command(struct scsi_cmnd *,
+			    void (*done) (struct scsi_cmnd *));
+int NCR53c7xx_abort(struct scsi_cmnd *);
 int NCR53c7x0_release (struct Scsi_Host *);
-int NCR53c7xx_reset(Scsi_Cmnd *, unsigned int);
+int NCR53c7xx_reset(struct scsi_cmnd *, unsigned int);
 void NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs);
 
 #ifndef CMD_PER_LUN


