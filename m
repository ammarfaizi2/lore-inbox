Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945939AbWGOAfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945939AbWGOAfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945941AbWGOAfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:35:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31497 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945939AbWGOAfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:35:42 -0400
Date: Sat, 15 Jul 2006 02:35:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Michal Ludvig <michal@logix.cz>,
       Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
       linux-crypto@vger.kernel.org
Subject: [-mm patch] drivers/crypto/padlock-sha.c: make 2 functions static
Message-ID: <20060715003540.GI3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc1-mm1:
>...
>  git-cryptodev.patch 
> 
>  git trees.
>...

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/crypto/padlock-sha.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc1-mm2-full/drivers/crypto/padlock-sha.c.old	2006-07-14 23:25:40.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/crypto/padlock-sha.c	2006-07-14 23:25:54.000000000 +0200
@@ -112,7 +112,7 @@
 		*dst++ = swab32(*src++);
 }
 
-void padlock_do_sha1(const char *in, char *out, int count)
+static void padlock_do_sha1(const char *in, char *out, int count)
 {
 	/* We can't store directly to *out as it may be unaligned. */
 	/* BTW Don't reduce the buffer size below 128 Bytes!
@@ -133,7 +133,7 @@
 	padlock_output_block((uint32_t *)result, (uint32_t *)out, 5);
 }
 
-void padlock_do_sha256(const char *in, char *out, int count)
+static void padlock_do_sha256(const char *in, char *out, int count)
 {
 	/* We can't store directly to *out as it may be unaligned. */
 	/* BTW Don't reduce the buffer size below 128 Bytes!

