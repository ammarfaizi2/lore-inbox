Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbULHBQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbULHBQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbULHBPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:15:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18450 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261988AbULHBOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:14:39 -0500
Date: Wed, 8 Dec 2004 02:14:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/qla2xxx/qla_rscn.c: remove unused functions (fwd)
Message-ID: <20041208011434.GH5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:27:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/qla2xxx/qla_rscn.c: remove unused functions

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

