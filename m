Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbSKCWQN>; Sun, 3 Nov 2002 17:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbSKCWQN>; Sun, 3 Nov 2002 17:16:13 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:61231 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262663AbSKCWQM>;
	Sun, 3 Nov 2002 17:16:12 -0500
Date: Sun, 3 Nov 2002 23:22:43 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Dave Jones <davej@codemonkey.org.uk>, Akira Tsukamoto <at541@columbia.edu>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Message-ID: <20021103222243.GB946@win.tue.nl>
References: <20021102025838.220E.AT541@columbia.edu> <3DC3A9C0.7979C276@digeo.com> <20021102214537.379A.AT541@columbia.edu> <20021103212421.GA733@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103212421.GA733@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 09:24:21PM +0000, Dave Jones wrote:

> As a sidenote, string-486.h has been disabled for years
> (Right back to at least 2.0.39 which is the earliest tree I have
>  to hand right now).  It should either be fixed, or considered
> worth dropping imo.


--- v1.3.75/linux/include/asm-i386/string.h     Wed Feb 28 11:50:11 1996
+++ linux/include/asm-i386/string.h     Mon Mar 18 10:52:08 1996
@@ -6,8 +6,11 @@
  * byte string operations. But on a 386 or a PPro the
  * byte string ops are faster than doing it by hand
  * (MUCH faster on a Pentium).
+ *
+ * Also, the byte strings actually work correctly. Forget
+ * the i486 routines for now as they may be broken..
  */
-#if CPU == 486 || CPU == 586
+#if FIXED_486_STRING && (CPU == 486 || CPU == 586)
 #include <asm/string-486.h>
 #else

