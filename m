Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032069AbWLGLe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032069AbWLGLe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032067AbWLGLe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:34:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1345 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032070AbWLGLe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:34:27 -0500
Date: Thu, 7 Dec 2006 12:34:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Chan <mchan@broadcom.com>
Cc: davem@davemloft.net, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/bnx2.c: add an error check
Message-ID: <20061207113433.GC8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing error check spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/drivers/net/bnx2.c.old	2006-12-06 13:32:51.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/net/bnx2.c	2006-12-06 13:33:34.000000000 +0100
@@ -2510,7 +2510,7 @@
 	if (CHIP_NUM(bp) == CHIP_NUM_5709) {
 		fw = &bnx2_cp_fw_09;
 
-		load_cpu_fw(bp, &cpu_reg, fw);
+		rc = load_cpu_fw(bp, &cpu_reg, fw);
 		if (rc)
 			goto init_cpu_err;
 	}

