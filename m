Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWDRWHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWDRWHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDRWHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:07:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4874 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750746AbWDRWHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:07:24 -0400
Date: Wed, 19 Apr 2006 00:07:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let X86_VOYAGER depend on SMP
Message-ID: <20060418220723.GR11582@stusta.de>
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

