Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUIGW00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUIGW00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268711AbUIGW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:26:26 -0400
Received: from [216.70.31.95] ([216.70.31.95]:34221 "HELO
	rock.mm-interactive.com") by vger.kernel.org with SMTP
	id S268703AbUIGW0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:26:22 -0400
Date: Tue, 7 Sep 2004 17:26:22 -0500
From: Thor Kooda <tkooda-patch-kernel@devsec.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8.1 crypto: tea.c xtea_encrypt should use XTEA_DELTA
Message-ID: <20040907222622.GA15730@rock>
References: <20040903223458.GD18362@rock> <20040907134141.6c634f26.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907134141.6c634f26.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2004, David S. Miller wrote:
> Thor, your patches do not apply because your email
> client turns tab characters into spaces, please fix
> this up.

Fixed.

Signed-off-by: Thor Kooda <tkooda-patch-kernel@devsec.org>

-- 
Thor Kooda
tkooda-patch-kernel@devsec.org


--- linux-2.6.8.1.orig/crypto/tea.c	Sat Aug 14 05:56:25 2004
+++ linux-2.6.8.1/crypto/tea.c	Tue Sep  7 17:22:51 2004
@@ -154,7 +154,7 @@
 
 	while (sum != limit) {
 		y += (z << 4 ^ z >> 5) + (z ^ sum) + ctx->KEY[sum&3]; 
-		sum += TEA_DELTA;
+		sum += XTEA_DELTA;
 		z += (y << 4 ^ y >> 5) + (y ^ sum) + ctx->KEY[sum>>11 &3]; 
 	}
 	

