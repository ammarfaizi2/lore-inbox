Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265005AbUETGVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbUETGVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 02:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265003AbUETGVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 02:21:33 -0400
Received: from palrel10.hp.com ([156.153.255.245]:58251 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265002AbUETGVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 02:21:32 -0400
Date: Wed, 19 May 2004 23:21:30 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200405200621.i4K6LUfO003870@napali.hpl.hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: make fbmem.c:sys_{in,out}buf() static
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell, sys_inbuf() and sys_outbuf() aren't used
anywhere outside of fbmem.c, so make them static.

	--david

===== drivers/video/fbmem.c 1.96 vs edited =====
--- 1.96/drivers/video/fbmem.c	Wed Apr 21 12:02:56 2004
+++ edited/drivers/video/fbmem.c	Wed May 19 22:49:23 2004
@@ -411,12 +411,12 @@
 /*
  * Drawing helpers.
  */
-u8 sys_inbuf(struct fb_info *info, u8 *src)
+static u8 sys_inbuf(struct fb_info *info, u8 *src)
 {	
 	return *src;
 }
 
-void sys_outbuf(struct fb_info *info, u8 *dst, u8 *src, unsigned int size)
+static void sys_outbuf(struct fb_info *info, u8 *dst, u8 *src, unsigned int size)
 {
 	memcpy(dst, src, size);
 }	
