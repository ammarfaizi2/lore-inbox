Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVIATiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVIATiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVIATiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:38:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34551 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965185AbVIATi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:38:29 -0400
Subject: [PATCH 2.6.13] Warning in the qla2xxx driver
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 01 Sep 2005 12:38:26 -0700
Message-Id: <1125603506.4867.23.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove possible uninitialized "sg" field warning in the qla24xx driver

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/drivers/scsi/qla2xxx/qla_iocb.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/qla2xxx/qla_iocb.c	2005-08-28 23:41:01.000000000 +0000
+++ linux-2.6.13/drivers/scsi/qla2xxx/qla_iocb.c	2005-08-31 18:31:03.000000000 +0000
@@ -744,7 +744,7 @@ qla24xx_start_scsi(srb_t *sp)
 	uint32_t        index;
 	uint32_t	handle;
 	struct cmd_type_7 *cmd_pkt;
-	struct scatterlist *sg;
+	struct scatterlist *sg = NULL;
 	uint16_t	cnt;
 	uint16_t	req_cnt;
 	uint16_t	tot_dsds;


