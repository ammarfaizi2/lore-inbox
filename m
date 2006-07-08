Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWGHV26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWGHV26 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWGHV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:28:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19976 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030403AbWGHV2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:28:55 -0400
Date: Sat, 8 Jul 2006 23:28:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] sound/oss/mpu401.c: don't export a static function
Message-ID: <20060708212856.GB19487@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I made mpuintr() static, I forgot to remove the export...

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm6-full/sound/oss/mpu401.c.old	2006-07-08 23:14:50.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/mpu401.c	2006-07-08 23:15:06.000000000 +0200
@@ -1752,7 +1752,6 @@
 EXPORT_SYMBOL(probe_mpu401);
 EXPORT_SYMBOL(attach_mpu401);
 EXPORT_SYMBOL(unload_mpu401);
-EXPORT_SYMBOL(mpuintr);
 
 static struct address_info cfg;
 

