Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWBYNYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWBYNYL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWBYNYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:24:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49157 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030190AbWBYNYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:24:10 -0500
Date: Sat, 25 Feb 2006 14:24:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: [-mm patch] kernel/fork.c: make signal_cachep static
Message-ID: <20060225132409.GO3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
> +copy_process-cleanup-bad_fork_cleanup_signal.patch
>...
>  More core process/pid/thread updates from Oleg.
>...


signal_cachep can now become static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/slab.h |    1 -
 kernel/fork.c        |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.16-rc4-mm2-full/include/linux/slab.h.old	2006-02-25 04:48:29.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/include/linux/slab.h	2006-02-25 04:48:36.000000000 +0100
@@ -182,7 +182,6 @@
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
 extern kmem_cache_t	*fs_cachep;
-extern kmem_cache_t	*signal_cachep;
 extern kmem_cache_t	*sighand_cachep;
 extern kmem_cache_t	*bio_cachep;
 
--- linux-2.6.16-rc4-mm2-full/kernel/fork.c.old	2006-02-25 04:48:43.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/kernel/fork.c	2006-02-25 04:48:49.000000000 +0100
@@ -84,7 +84,7 @@
 #endif
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
-kmem_cache_t *signal_cachep;
+static kmem_cache_t *signal_cachep;
 
 /* SLAB cache for sighand_struct structures (tsk->sighand) */
 kmem_cache_t *sighand_cachep;

