Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269965AbUICWaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269965AbUICWaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269947AbUICWaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:30:02 -0400
Received: from [216.70.31.95] ([216.70.31.95]:64913 "HELO
	rock.mm-interactive.com") by vger.kernel.org with SMTP
	id S269961AbUICW3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:29:39 -0400
Date: Fri, 3 Sep 2004 17:29:36 -0500
From: Thor Kooda <tkooda-patch-kernel@devsec.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.27 crypto: tea.c xtea_encrypt should use XTEA_DELTA
Message-ID: <20040903222936.GC18362@rock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for crypto/tea.c, added in 2.4.27-rc4:

xtea_encrypt() should use XTEA_DELTA instead of TEA_DELTA.

Signed-off-by: Thor Kooda <tkooda-patch-kernel@devsec.org>

-- 
Thor Kooda
tkooda-patch-kernel@devsec.org


--- linux-2.4.27.orig/crypto/tea.c      Sat Aug  7 18:26:04 2004
+++ linux-2.4.27/crypto/tea.c   Fri Sep  3 17:08:18 2004
@@ -154,7 +154,7 @@
 
        while (sum != limit) {
                y += (z << 4 ^ z >> 5) + (z ^ sum) + ctx->KEY[sum&3]; 
-               sum += TEA_DELTA;
+               sum += XTEA_DELTA;
                z += (y << 4 ^ y >> 5) + (y ^ sum) + ctx->KEY[sum>>11 &3]; 
        }
        
