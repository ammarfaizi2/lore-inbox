Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbULAB05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbULAB05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULAB0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:26:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:5543 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbULABXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:23:11 -0500
Date: Tue, 30 Nov 2004 16:51:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: sclin@sis.com.tw, lkml <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.sourceforge.net, akpm <akpm@osdl.org>
Subject: [PATCH] SIS DRM bool. bitfields
Message-Id: <20041130165103.5ca0b428.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)

Make 1-bit fields be unsigned (no sign bit :).
sparse complains about them:
drivers/char/drm/sis_ds.h:88:12: warning: dubious one-bit signed bitfield
drivers/char/drm/sis_ds.h:89:16: warning: dubious one-bit signed bitfield

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/char/drm/sis_ds.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/char/drm/sis_ds.h~sis_bits ./drivers/char/drm/sis_ds.h
--- ./drivers/char/drm/sis_ds.h~sis_bits	2004-08-13 22:36:57.000000000 -0700
+++ ./drivers/char/drm/sis_ds.h	2004-10-11 07:59:31.861263400 -0700
@@ -85,8 +85,8 @@ struct mem_block_t {
 	struct mem_block_t *heap;
 	int ofs,size;
 	int align;
-	int free:1;
-	int reserved:1;
+	unsigned int free:1;
+	unsigned int reserved:1;
 };
 typedef struct mem_block_t TMemBlock;
 typedef struct mem_block_t *PMemBlock;


---
