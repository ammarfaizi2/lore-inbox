Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVCSNU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVCSNU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVCSNTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:19:39 -0500
Received: from coderock.org ([193.77.147.115]:19336 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262498AbVCSNSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:18:25 -0500
Subject: [patch 4/4] crypto/tea.c: fix sparse warnings
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, domen@coderock.org,
       adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:18:19 +0100
Message-Id: <20050319131819.9B87C1ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/tea.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN crypto/tea.c~sparse-crypto_tea crypto/tea.c
--- kj/crypto/tea.c~sparse-crypto_tea	2005-03-18 20:05:37.000000000 +0100
+++ kj-domen/crypto/tea.c	2005-03-18 20:05:37.000000000 +0100
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
