Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290749AbSA3Xhb>; Wed, 30 Jan 2002 18:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290747AbSA3XhO>; Wed, 30 Jan 2002 18:37:14 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:22424 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290746AbSA3XhG>; Wed, 30 Jan 2002 18:37:06 -0500
Date: Thu, 31 Jan 2002 00:36:58 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: [PATCH] Fix zlib symbol export
Message-ID: <20020131003658.A1480@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes ppp_deflate load as a module again.
It also needs the obvious mv linux/* include/linux fix for 2.5.3 to let the
new zlib library compile. 

Patch against 2.5.3. Please apply.

Thanks,
-Andi

--- linux-2.5.3-work/lib/zlib_inflate/inflate_syms.c-ZLIB	Wed Jan 30 22:38:11 2002
+++ linux-2.5.3-work/lib/zlib_inflate/inflate_syms.c	Wed Jan 30 23:20:07 2002
@@ -18,4 +18,5 @@
 EXPORT_SYMBOL(zlib_inflateSync);
 EXPORT_SYMBOL(zlib_inflateReset);
 EXPORT_SYMBOL(zlib_inflateSyncPoint);
+EXPORT_SYMBOL(zlib_inflateIncomp); 
 MODULE_LICENSE("GPL");
