Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757484AbWKXBqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484AbWKXBqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 20:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757523AbWKXBqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 20:46:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27913 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1757498AbWKXBqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 20:46:04 -0500
Date: Fri, 24 Nov 2006 02:46:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make readahead_debug_level static
Message-ID: <20061124014607.GS3557@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
> +readahead-kconfig-options-fix.patch
> +radixtree-introduce-scan-hole-data-functions.patch
> -readahead-delay-page-release-in-do_generic_mapping_read.patch
> -readahead-initial-method-expected-read-size.patch
> -readahead-seeking-reads-method.patch
> +readahead-call-scheme-ifdef-fix.patch
> +readahead-call-scheme-build-fix.patch
> +readahead-nfsd-case-fix.patch
> -readahead-debug-radix-tree-new-functions.patch
> -readahead-debug-traces-showing-accessed-file-names.patch
> -readahead-debug-traces-showing-read-patterns.patch
> -readahead-backward-prefetching-method-fix.patch
> -readahead-remove-the-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch
> +readahead-remove-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch
> 
>  Updated readahead patch series
>...

readahead_debug_level can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/mm/readahead.c.old	2006-11-24 01:26:26.000000000 +0100
+++ linux-2.6.19-rc6-mm1/mm/readahead.c	2006-11-24 01:26:41.000000000 +0100
@@ -93,7 +93,7 @@
 };
 
 #ifdef CONFIG_DEBUG_READAHEAD
-u32 readahead_debug_level = 1;
+static u32 readahead_debug_level = 1;
 static u32 disable_stateful_method;
 static const char * const ra_class_name[];
 static void ra_account(struct file_ra_state *ra, enum ra_event e, int pages);

