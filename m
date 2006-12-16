Return-Path: <linux-kernel-owner+w=401wt.eu-S1753719AbWLPN50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbWLPN50 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbWLPN5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:57:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3341 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753714AbWLPN5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:57:01 -0500
Date: Sat, 16 Dec 2006 14:57:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [-mm patch] mm/vmscan.c: make a function static
Message-ID: <20061216135700.GD3388@stusta.de>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-mm1:
>...
> +lumpy-reclaim-v2.patch
>...
>  Teach page reclaim to perform a short physical scan to try to generate free
>  higher-order pages.  Needs work.
>...

This patch makes the needlessly global __isolate_lru_page() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc1-mm1/mm/vmscan.c.old	2006-12-15 23:37:18.000000000 +0100
+++ linux-2.6.20-rc1-mm1/mm/vmscan.c	2006-12-16 00:36:00.000000000 +0100
@@ -616,7 +616,7 @@
  *
  * returns 0 on success, -ve errno on failure.
  */
-int __isolate_lru_page(struct page *page, int active)
+static int __isolate_lru_page(struct page *page, int active)
 {
 	int ret = -EINVAL;
 

