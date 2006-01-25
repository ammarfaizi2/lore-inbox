Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWAYBAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWAYBAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 20:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWAYBAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 20:00:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17419 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750836AbWAYBAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 20:00:53 -0500
Date: Wed, 25 Jan 2006 02:00:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: support@lsil.com, mpt_linux_developer@lsil.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/message/fusion/mptfc.c: make 2 functions static
Message-ID: <20060125010052.GO3590@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Jan 2006

 drivers/message/fusion/mptfc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc1-mm1-full/drivers/message/fusion/mptfc.c.old	2006-01-18 23:16:09.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/message/fusion/mptfc.c	2006-01-18 23:16:34.000000000 +0100
@@ -93,7 +93,7 @@
 static int	mptfcTaskCtx = -1;
 static int	mptfcInternalCtx = -1; /* Used only for internal commands */
 
-int mptfc_slave_alloc(struct scsi_device *device);
+static int mptfc_slave_alloc(struct scsi_device *device);
 static int mptfc_qcmd(struct scsi_cmnd *SCpnt,
     void (*done)(struct scsi_cmnd *));
 
@@ -153,7 +153,7 @@
 
 static struct scsi_transport_template *mptfc_transport_template = NULL;
 
-struct fc_function_template mptfc_transport_functions = {
+static struct fc_function_template mptfc_transport_functions = {
 	.dd_fcrport_size = 8,
 	.show_host_node_name = 1,
 	.show_host_port_name = 1,
@@ -432,7 +432,7 @@
  *	Return non-zero if allocation fails.
  *	Init memory once per LUN.
  */
-int
+static int
 mptfc_slave_alloc(struct scsi_device *sdev)
 {
 	MPT_SCSI_HOST		*hd;

