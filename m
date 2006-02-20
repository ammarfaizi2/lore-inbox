Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWBTWjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWBTWjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWBTWjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:39:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2573 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161161AbWBTWhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:37:10 -0500
Date: Mon, 20 Feb 2006 23:37:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport install_page
Message-ID: <20060220223709.GT4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No in-kernel module is using it, so there's no reason bloating the 
kernel with this EXPORT_SYMBOL.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 Feb 2006

--- linux-2.6.16-rc3-mm1-full/mm/fremap.c.old	2006-02-16 16:45:09.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/mm/fremap.c	2006-02-16 16:45:18.000000000 +0100
@@ -89,7 +89,6 @@
 out:
 	return err;
 }
-EXPORT_SYMBOL(install_page);
 
 /*
  * Install a file pte to a given virtual memory address, release any

