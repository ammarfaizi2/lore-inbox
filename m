Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWEWSyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWEWSyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWEWSyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:54:43 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:31416 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932269AbWEWSyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:54:24 -0400
Date: Tue, 23 May 2006 20:54:23 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Clay Haapala <chaapala@cisco.com>
Subject: [PATCH] -mm: constify libcrc32c table
Message-ID: <20060523185423.GF10827@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

constify a medium-large CRC code table.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/lib/libcrc32c.c linux-2.6.17-rc4-mm3.my/lib/libcrc32c.c
--- linux-2.6.17-rc4-mm3.orig/lib/libcrc32c.c	2006-05-23 17:46:35.000000000 +0200
+++ linux-2.6.17-rc4-mm3/lib/libcrc32c.c	2006-05-22 20:17:16.000000000 +0200
@@ -88,7 +88,7 @@
  * reflect output bytes = true
  */
 
-static u32 crc32c_table[256] = {
+static const u32 crc32c_table[256] = {
 	0x00000000L, 0xF26B8303L, 0xE13B70F7L, 0x1350F3F4L,
 	0xC79A971FL, 0x35F1141CL, 0x26A1E7E8L, 0xD4CA64EBL,
 	0x8AD958CFL, 0x78B2DBCCL, 0x6BE22838L, 0x9989AB3BL,
