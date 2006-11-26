Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967179AbWKZBCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967179AbWKZBCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967192AbWKZBCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:02:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3087 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967179AbWKZBCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:02:49 -0500
Date: Sun, 26 Nov 2006 02:02:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] x86_64: remove duplicate ARCH_DISCONTIGMEM_ENABLE option
Message-ID: <20061126010252.GC15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One ARCH_DISCONTIGMEM_ENABLE option is enough.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/arch/x86_64/Kconfig.old	2006-11-26 02:01:17.000000000 +0100
+++ linux-2.6.19-rc6-mm1/arch/x86_64/Kconfig	2006-11-26 02:01:28.000000000 +0100
@@ -374,15 +374,10 @@
 config ARCH_DISCONTIGMEM_ENABLE
        bool
        depends on NUMA
        default y
 
-
-config ARCH_DISCONTIGMEM_ENABLE
-	def_bool y
-	depends on NUMA
-
 config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y
 	depends on NUMA
 
 config ARCH_SPARSEMEM_ENABLE
