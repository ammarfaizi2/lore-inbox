Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVCTLZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVCTLZV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVCTLXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:23:19 -0500
Received: from coderock.org ([193.77.147.115]:45195 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261729AbVCTLVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:21:23 -0500
Date: Sun, 20 Mar 2005 12:21:17 +0100
From: Domen Puncer <domen@coderock.org>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 4/4 with proper signed-off] crypto/tea.c: fix sparse warnings
Message-ID: <20050320112117.GK14273@nd47.coderock.org>
References: <20050319131819.9B87C1ECA8@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131819.9B87C1ECA8@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/tea.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN crypto/tea.c~sparse-crypto_tea crypto/tea.c
--- kj/crypto/tea.c~sparse-crypto_tea	2005-03-20 12:11:36.000000000 +0100
+++ kj-domen/crypto/tea.c	2005-03-20 12:11:36.000000000 +0100
@@ -31,8 +31,8 @@
 #define XTEA_ROUNDS		32
 #define XTEA_DELTA		0x9e3779b9
 
-#define u32_in(x) le32_to_cpu(*(const u32 *)(x))
-#define u32_out(to, from) (*(u32 *)(to) = cpu_to_le32(from))
+#define u32_in(x) le32_to_cpup((const __le32 *)(x))
+#define u32_out(to, from) (*(__le32 *)(to) = cpu_to_le32(from))
 
 struct tea_ctx {
 	u32 KEY[4];
_
