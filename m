Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVCSN31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVCSN31 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVCSN0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:26:06 -0500
Received: from coderock.org ([193.77.147.115]:7048 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262490AbVCSNRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:54 -0500
Subject: [patch 10/10] arch/i386/crypto/aes.c: fix sparse warnings
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:44 +0100
Message-Id: <20050319131745.0FD7B1F240@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/crypto/aes.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/crypto/aes.c~sparse-arch_i386_crypto_aes arch/i386/crypto/aes.c
--- kj/arch/i386/crypto/aes.c~sparse-arch_i386_crypto_aes	2005-03-18 20:05:21.000000000 +0100
+++ kj-domen/arch/i386/crypto/aes.c	2005-03-18 20:05:21.000000000 +0100
@@ -59,7 +59,7 @@ struct aes_ctx {
 };
 
 #define WPOLY 0x011b
-#define u32_in(x) le32_to_cpu(*(const u32 *)(x))
+#define u32_in(x) le32_to_cpup((const __le32 *)(x))
 #define bytes2word(b0, b1, b2, b3)  \
 	(((u32)(b3) << 24) | ((u32)(b2) << 16) | ((u32)(b1) << 8) | (b0))
 
_
