Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUIGWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUIGWcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUIGWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:32:06 -0400
Received: from [216.70.31.95] ([216.70.31.95]:36269 "HELO
	rock.mm-interactive.com") by vger.kernel.org with SMTP
	id S268709AbUIGWbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:31:05 -0400
Date: Tue, 7 Sep 2004 17:31:06 -0500
From: Thor Kooda <tkooda-patch-kernel@devsec.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.27 crypto: tea.c xtea_encrypt should use XTEA_DELTA
Message-ID: <20040907223106.GB15730@rock>
References: <20040903222936.GC18362@rock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903222936.GC18362@rock>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2004, Thor Kooda wrote:
> Patch for crypto/tea.c, added in 2.4.27-rc4:
> 
> xtea_encrypt() should use XTEA_DELTA instead of TEA_DELTA.

Fixed tab mangling.

Signed-off-by: Thor Kooda <tkooda-patch-kernel@devsec.org>

-- 
Thor Kooda
tkooda-patch-kernel@devsec.org


--- linux-2.4.27.orig/crypto/tea.c	Sat Aug  7 18:26:04 2004
+++ linux-2.4.27/crypto/tea.c	Tue Sep  7 17:15:58 2004
@@ -154,7 +154,7 @@
 
 	while (sum != limit) {
 		y += (z << 4 ^ z >> 5) + (z ^ sum) + ctx->KEY[sum&3]; 
-		sum += TEA_DELTA;
+		sum += XTEA_DELTA;
 		z += (y << 4 ^ y >> 5) + (y ^ sum) + ctx->KEY[sum>>11 &3]; 
 	}
 	
