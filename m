Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWD0UeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWD0UeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWD0UeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:34:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30215 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751489AbWD0Udw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:33:52 -0400
Date: Thu, 27 Apr 2006 22:33:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let X86_VOYAGER depend on SMP
Message-ID: <20060427203350.GR3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noted that X86_VOYAGER=y and SMP=n doesn't compile.

It might be possible to fix this, but as far as I understand it, all 
Voyager machines are SMP, implying that such a configuration doesn't 
make much sense.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2006
- 7 Apr 2006

--- linux-2.6.17-rc1-mm1-voyager/arch/i386/Kconfig.old	2006-04-07 01:02:34.000000000 +0200
+++ linux-2.6.17-rc1-mm1-voyager/arch/i386/Kconfig	2006-04-07 01:02:47.000000000 +0200
@@ -77,6 +77,7 @@
 
 config X86_VOYAGER
 	bool "Voyager (NCR)"
+	depends on SMP
 	help
 	  Voyager is an MCA-based 32-way capable SMP architecture proprietary
 	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are Voyager-based.

