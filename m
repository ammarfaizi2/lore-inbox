Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSEYIFG>; Sat, 25 May 2002 04:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSEYIFG>; Sat, 25 May 2002 04:05:06 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:6603 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S314083AbSEYIFE>; Sat, 25 May 2002 04:05:04 -0400
Date: Sat, 25 May 2002 04:09:03 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.18 -- build failure -- suspend.c:1052: dereferencing pointer to incomplete type
Mail-Followup-To: Miles Lane <miles@megapathdsl.net>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3CEF2DAA.8030902@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020525080500.DDYG10701.pop017.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> I have included the error, the output of ver_linux and
> snippets of .config.
[snip]

The buffer_head declaration was just moved into its own header.


--- linux/kernel/suspend.c.orig	Sat May 25 03:02:48 2002
+++ linux/kernel/suspend.c	Sat May 25 03:01:33 2002
@@ -66,6 +66,7 @@
 #include <linux/swap.h>
 #include <linux/pm.h>
 #include <linux/device.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>


-- 
Skip
