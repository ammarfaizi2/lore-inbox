Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWGBXAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWGBXAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWGBXAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:00:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45013 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751470AbWGBXAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:00:41 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:00:24 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 05/19] ieee1394: replace __inline__ by inline
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.807d7660a9468da5@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.244) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux-2.6.17-mm5/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/ieee1394_types.h	2006-07-01 10:56:29.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/ieee1394_types.h	2006-07-02 13:39:34.000000000 +0200
@@ -75,7 +75,7 @@ typedef u16 arm_length_t;
 
 #ifdef __BIG_ENDIAN
 
-static __inline__ void *memcpy_le32(u32 *dest, const u32 *__src, size_t count)
+static inline void *memcpy_le32(u32 *dest, const u32 *__src, size_t count)
 {
         void *tmp = dest;
 	u32 *src = (u32 *)__src;
Index: linux-2.6.17-mm5/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/ohci1394.c	2006-07-01 20:30:01.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/ohci1394.c	2006-07-02 13:39:34.000000000 +0200
@@ -2598,8 +2598,9 @@ static const int TCODE_SIZE[16] = {20, 0
  * Determine the length of a packet in the buffer
  * Optimization suggested by Pascal Drolet <pascal.drolet@informission.ca>
  */
-static __inline__ int packet_length(struct dma_rcv_ctx *d, int idx, quadlet_t *buf_ptr,
-			 int offset, unsigned char tcode, int noswap)
+static inline int packet_length(struct dma_rcv_ctx *d, int idx,
+				quadlet_t *buf_ptr, int offset,
+				unsigned char tcode, int noswap)
 {
 	int length = -1;
 
Index: linux-2.6.17-mm5/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/sbp2.c	2006-07-01 20:39:25.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/sbp2.c	2006-07-02 13:39:34.000000000 +0200
@@ -356,7 +356,7 @@ static const struct {
 /*
  * Converts a buffer from be32 to cpu byte ordering. Length is in bytes.
  */
-static __inline__ void sbp2util_be32_to_cpu_buffer(void *buffer, int length)
+static inline void sbp2util_be32_to_cpu_buffer(void *buffer, int length)
 {
 	u32 *temp = buffer;
 
@@ -369,7 +369,7 @@ static __inline__ void sbp2util_be32_to_
 /*
  * Converts a buffer from cpu to be32 byte ordering. Length is in bytes.
  */
-static __inline__ void sbp2util_cpu_to_be32_buffer(void *buffer, int length)
+static inline void sbp2util_cpu_to_be32_buffer(void *buffer, int length)
 {
 	u32 *temp = buffer;
 


