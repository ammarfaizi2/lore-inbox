Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbTFNLeM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 07:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265666AbTFNLeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 07:34:12 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:47519 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265665AbTFNLeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 07:34:11 -0400
Date: Sat, 14 Jun 2003 13:47:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [Patch] 2.5.70-bk18 adjust ppp to zlib change
Message-ID: <20030614114742.GA15099@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This bit is left from the zlib changes.  According to Paul, the zlib
bug is already caught in userspace pppd, but not in the kernel ppp
code.  With this patch, there is one potential hickup less in ppp.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918

--- linux-2.5.70-bk14/include/linux/ppp-comp.h~ppp_deflate_min_size	2003-06-09 16:17:52.000000000 +0200
+++ linux-2.5.70-bk14/include/linux/ppp-comp.h	2003-06-09 16:27:12.000000000 +0200
@@ -182,7 +182,7 @@
 #define CI_DEFLATE_DRAFT	24	/* value used in original draft RFC */
 #define CILEN_DEFLATE		4	/* length of its config option */
 
-#define DEFLATE_MIN_SIZE	8
+#define DEFLATE_MIN_SIZE	9
 #define DEFLATE_MAX_SIZE	15
 #define DEFLATE_METHOD_VAL	8
 #define DEFLATE_SIZE(x)		(((x) >> 4) + DEFLATE_MIN_SIZE)
