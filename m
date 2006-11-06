Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423628AbWKFJhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423628AbWKFJhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423629AbWKFJhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:37:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57100 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423628AbWKFJhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:37:21 -0500
Date: Mon, 6 Nov 2006 10:37:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/telephony/ixj: fix an array overrun
Message-ID: <20061106093722.GF5778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted that in 
drivers/telephony/ixj.c:ixj_build_filter_cadence(), filter_en[4] or 
filter_en[5] could be written to.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/telephony/ixj.h.old	2006-11-06 10:34:56.000000000 +0100
+++ linux-2.6/drivers/telephony/ixj.h	2006-11-06 10:35:10.000000000 +0100
@@ -1295,7 +1295,7 @@
 	Proc_Info_Type Info_write;
 	unsigned short frame_count;
 	unsigned int filter_hist[4];
-	unsigned char filter_en[4];
+	unsigned char filter_en[6];
 	unsigned short proc_load;
 	unsigned long framesread;
 	unsigned long frameswritten;

