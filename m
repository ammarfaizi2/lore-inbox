Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVEHTMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVEHTMR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVEHTJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:09:58 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:56214 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262822AbVEHTJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:34 -0400
Message-Id: <20050508184345.985363000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:36 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Content-Disposition: inline; filename=dvb-core-static-dvb-class.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 07/37] make dvb_class static
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unexport dvb_class and make it static

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/dvb-core/dvbdev.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvbdev.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvbdev.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvbdev.c	2005-05-08 20:24:48.000000000 +0200
@@ -56,8 +56,7 @@ static const char * const dnames[] = {
 #define nums2minor(num,type,id)	((num << 6) | (id << 4) | type)
 #define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS*64)
 
-struct class_simple *dvb_class;
-EXPORT_SYMBOL(dvb_class);
+static struct class_simple *dvb_class;
 
 static struct dvb_device* dvbdev_find_device (int minor)
 {

--

