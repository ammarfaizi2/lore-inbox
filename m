Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263205AbUJ2Ac7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUJ2Ac7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbUJ2A2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:28:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62982 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263275AbUJ2A1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:27:52 -0400
Date: Fri, 29 Oct 2004 02:27:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/qla2xxx/qla_rscn.c: remove unused functions
Message-ID: <20041029002716.GA29142@stusta.de>
References: <20041028232101.GH3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028232101.GH3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes two unused functions from 
drivers/scsi/qla2xxx/qla_rscn.c


diffstat output:
 drivers/scsi/qla2xxx/qla_rscn.c |   26 --------------------------
 1 files changed, 26 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/scsi/qla2xxx/qla_rscn.c.old	2004-10-28 23:26:04.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/scsi/qla2xxx/qla_rscn.c	2004-10-28 23:26:32.000000000 +0200
@@ -47,8 +47,6 @@
 /* Local Prototypes. */
 static inline uint32_t qla2x00_to_handle(uint16_t, uint16_t, uint16_t);
 static inline uint16_t qla2x00_handle_to_idx(uint32_t);
-static inline uint16_t qla2x00_handle_to_iter(uint32_t);
-static inline uint16_t qla2x00_handle_to_type(uint32_t);
 static inline uint32_t qla2x00_iodesc_to_handle(struct io_descriptor *);
 static inline struct io_descriptor *qla2x00_handle_to_iodesc(scsi_qla_host_t *,
     uint32_t);
@@ -130,30 +128,6 @@
 }
 
 /**
- * qla2x00_handle_to_type() - Retrive the descriptor type for a given handle.
- * @handle: descriptor handle
- *
- * Returns the descriptor type specified by the @handle.
- */
-static inline uint16_t
-qla2x00_handle_to_type(uint32_t handle)
-{
-	return ((uint16_t)(((handle) >> HDL_TYPE_SHIFT) & HDL_TYPE_MASK));
-}
-
-/**
- * qla2x00_handle_to_iter() - Retrive the rolling signature for a given handle.
- * @handle: descriptor handle
- *
- * Returns the signature specified by the @handle.
- */
-static inline uint16_t
-qla2x00_handle_to_iter(uint32_t handle)
-{
-	return ((uint16_t)(((handle) >> HDL_ITER_SHIFT) & HDL_ITER_MASK));
-}
-
-/**
  * qla2x00_iodesc_to_handle() - Convert an IO descriptor to a unique handle.
  * @iodesc: io descriptor
  *
