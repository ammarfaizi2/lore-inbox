Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWILSc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWILSc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWILSc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:32:56 -0400
Received: from server6.greatnet.de ([83.133.96.26]:29831 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030353AbWILScz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:32:55 -0400
Message-ID: <4506FD57.8030602@nachtwindheim.de>
Date: Tue, 12 Sep 2006 20:32:55 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] sgiwd93: Scsi_Cmnd to struct scsi_cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes obsolete typedef'd Scsi_Cmnd to struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6/drivers/scsi/sgiwd93.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/sgiwd93.c	2006-09-12 20:16:37.000000000 +0200
@@ -97,7 +97,7 @@
 }
 
 static inline
-void fill_hpc_entries(struct hpc_chunk *hcp, Scsi_Cmnd *cmd, int datainp)
+void fill_hpc_entries(struct hpc_chunk *hcp, struct scsi_cmnd *cmd, int datainp)
 {
 	unsigned long len = cmd->SCp.this_residual;
 	void *addr = cmd->SCp.ptr;
@@ -129,7 +129,7 @@
 	hcp->desc.cntinfo = HPCDMA_EOX;
 }
 
-static int dma_setup(Scsi_Cmnd *cmd, int datainp)
+static int dma_setup(struct scsi_cmnd *cmd, int datainp)
 {
 	struct ip22_hostdata *hdata = HDATA(cmd->device->host);
 	struct hpc3_scsiregs *hregs =
@@ -163,7 +163,7 @@
 	return 0;
 }
 
-static void dma_stop(struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 		     int status)
 {
 	struct ip22_hostdata *hdata = HDATA(instance);
@@ -305,7 +305,7 @@
 	return 1;
 }
 
-static int sgiwd93_bus_reset(Scsi_Cmnd *cmd)
+static int sgiwd93_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 


