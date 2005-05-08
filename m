Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVEHUYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVEHUYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVEHUVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:21:49 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:65174 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262928AbVEHTKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:04 -0400
Message-Id: <20050508184349.054894000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:58 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-twinhan-200103A.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 29/37] DST: add support for Twinhan 200103A
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add support for the old Twinhan 200103A card (Steffen Motzer)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/bt8xx/dst.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:30.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:39.000000000 +0200
@@ -538,7 +538,7 @@ static int dst_type_print (u8 type)
 	Known cards list
 	Satellite
 	-------------------
-
+		  200103A
 	VP-1020   DST-MOT	LG(old), TS=188
 
 	VP-1020   DST-03T	LG(new), TS=204
@@ -571,6 +571,14 @@ static int dst_type_print (u8 type)
 
 struct dst_types dst_tlist[] = {
 	{
+		.device_id = "200103A",
+		.offset = 0,
+		.dst_type =  DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_FW_1,
+		.dst_feature = 0
+	},	/*	obsolete	*/
+
+	{
 		.device_id = "DST-020",
 		.offset = 0,
 		.dst_type =  DST_TYPE_IS_SAT,

--

