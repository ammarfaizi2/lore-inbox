Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVAPH7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVAPH7G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVAPH7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:59:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7183 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262448AbVAPH6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:58:51 -0500
Date: Sun, 16 Jan 2005 08:58:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adam@yggdrasil.com, clemens@endorphin.org, jmorris@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/crypto/aes.c: make some code static
Message-ID: <20050116075846.GA4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/arch/i386/crypto/aes.c.old	2005-01-16 04:21:08.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/crypto/aes.c	2005-01-16 04:22:06.000000000 +0100
@@ -93,12 +93,12 @@
 
 u32 ft_tab[4][256];
 u32 fl_tab[4][256];
-u32 ls_tab[4][256];
-u32 im_tab[4][256];
+static u32 ls_tab[4][256];
+static u32 im_tab[4][256];
 u32 il_tab[4][256];
 u32 it_tab[4][256];
 
-void gen_tabs(void)
+static void gen_tabs(void)
 {
 	u32 i, w;
 	u8 pow[512], log[256];

