Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSK0Wy1>; Wed, 27 Nov 2002 17:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSK0Wy0>; Wed, 27 Nov 2002 17:54:26 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:27130 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264903AbSK0Wy0>; Wed, 27 Nov 2002 17:54:26 -0500
Message-Id: <200211272301.AAA29750@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: hugetlbpage.c build failure?
To: Kevin Brosius <cobra@compuserve.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Trivial Patches <trivial@rustcorp.com.au>
Date: Thu, 28 Nov 2002 01:58:06 +0100
References: <3DE54702.44D98750@compuserve.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Brosius wrote:
> arch/i386/mm/hugetlbpage.c:610: parse error before '*' token

The patch below fixed this for me

===== arch/i386/mm/hugetlbpage.c 1.17 vs edited =====
--- 1.17/arch/i386/mm/hugetlbpage.c     Thu Nov 14 23:03:02 2002
+++ edited/arch/i386/mm/hugetlbpage.c   Wed Nov 27 19:18:23 2002
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/sysctl.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
