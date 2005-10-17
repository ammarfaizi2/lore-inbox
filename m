Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVJPX75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVJPX75 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 19:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJPX75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 19:59:57 -0400
Received: from imap.gmx.net ([213.165.64.20]:61831 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751211AbVJPX74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 19:59:56 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] add missing header in include/asm/atomic.h
Date: Mon, 17 Oct 2005 02:05:56 +0200
User-Agent: KMail/1.8.91
Cc: linux-kernel@vger.kernel.org
References: <20051016154108.25735ee3.akpm@osdl.org>
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kruUDNw1/dCW2dL"
Message-Id: <200510170205.56526.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kruUDNw1/dCW2dL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 17 October 2005 00:41, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.
>6.14-rc4-mm1/

This patch should fix a compile error for fs/ntfs/namei.o, caused by a missing 
header for u32 in include/asm/atomic.h.

I hope it's correctly fixed this way.

dominik

--Boundary-00=_kruUDNw1/dCW2dL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="atomic-compile-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atomic-compile-fix.patch"

--- linux/include/asm/atomic.h.orig	2005-10-17 01:40:48.000000000 +0200
+++ linux/include/asm/atomic.h	2005-10-17 01:41:05.000000000 +0200
@@ -2,6 +2,7 @@
 #define __ARCH_X86_64_ATOMIC__
 
 #include <linux/config.h>
+#include <linux/types.h>
 
 /* atomic_t should be 32 bit signed type */
 

--Boundary-00=_kruUDNw1/dCW2dL--
