Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWF2TUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWF2TUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWF2TUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:20:49 -0400
Received: from [141.84.69.5] ([141.84.69.5]:24848 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932266AbWF2TU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:20:26 -0400
Date: Thu, 29 Jun 2006 21:19:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport install_page
Message-ID: <20060629191944.GN19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No in-kernel module is using it, so there's no reason bloating the 
kernel with this EXPORT_SYMBOL.

The addition was justified back in 2003 with being required for a 
project, but it's still not used by any in-kernel module.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Feb 2006
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

