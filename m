Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVCTLUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVCTLUb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVCTLTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:19:13 -0500
Received: from coderock.org ([193.77.147.115]:32395 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262136AbVCTLRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:17:13 -0500
Date: Sun, 20 Mar 2005 12:17:06 +0100
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 10/10 with proper signed-off] arch/i386/crypto/aes.c: fix sparse warnings
Message-ID: <20050320111706.GE14273@nd47.coderock.org>
References: <20050319131745.0FD7B1F240@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131745.0FD7B1F240@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/crypto/aes.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/crypto/aes.c~sparse-arch_i386_crypto_aes arch/i386/crypto/aes.c
--- kj/arch/i386/crypto/aes.c~sparse-arch_i386_crypto_aes	2005-03-20 12:11:21.000000000 +0100
+++ kj-domen/arch/i386/crypto/aes.c	2005-03-20 12:11:21.000000000 +0100
@@ -59,7 +59,7 @@ struct aes_ctx {
 };
 
 #define WPOLY 0x011b
-#define u32_in(x) le32_to_cpu(*(const u32 *)(x))
+#define u32_in(x) le32_to_cpup((const __le32 *)(x))
 #define bytes2word(b0, b1, b2, b3)  \
 	(((u32)(b3) << 24) | ((u32)(b2) << 16) | ((u32)(b1) << 8) | (b0))
 
_
