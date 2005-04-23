Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVDWWLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVDWWLy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVDWWKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:10:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44047 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262099AbVDWWIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:08:20 -0400
Date: Sun, 24 Apr 2005 00:08:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.co,
       linux-scsi@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/atp870u.c: make a function static
Message-ID: <20050423220817.GF4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/scsi/atp870u.c.old	2005-04-23 21:59:28.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/atp870u.c	2005-04-23 22:00:47.000000000 +0200
@@ -3146,8 +3146,8 @@
 }
 
 #define BLS buffer + len + size
-int atp870u_proc_info(struct Scsi_Host *HBAptr, char *buffer, 
-		      char **start, off_t offset, int length, int inout)
+static int atp870u_proc_info(struct Scsi_Host *HBAptr, char *buffer, 
+			     char **start, off_t offset, int length, int inout)
 {
 	static u8 buff[512];
 	int size = 0;

