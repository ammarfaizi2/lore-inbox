Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWCWX51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWCWX51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWCWX50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:57:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55568 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422736AbWCWX5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:57:25 -0500
Date: Fri, 24 Mar 2006 00:57:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [-mm patch] drivers/video/intelfb/intelfbhw.c: make struct plls static
Message-ID: <20060323235724.GI22727@stusta.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm2:
>...
>  git-intelfb.patch
>...
>  git trees.
>...

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm1-full/drivers/video/intelfb/intelfbhw.c.old	2006-03-23 23:12:20.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/video/intelfb/intelfbhw.c	2006-03-23 23:12:30.000000000 +0100
@@ -56,7 +56,7 @@
 #define PLLS_I9xx 1
 #define PLLS_MAX 2
 
-struct pll_min_max plls[PLLS_MAX] = {
+static struct pll_min_max plls[PLLS_MAX] = {
 	{ 108, 140, 18, 26, 6, 16, 3, 16, 4, 128, 0, 31, 930000, 1400000, 165000, 4, 22 }, //I8xx
 	{  75, 120, 10, 20, 5, 9, 4,  7, 5, 80, 1, 8, 930000, 2800000, 200000, 10, 5 }  //I9xx
 };

