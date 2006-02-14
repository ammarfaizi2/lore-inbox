Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWBNPWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWBNPWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWBNPWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:22:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12804 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161075AbWBNPWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:22:11 -0500
Date: Tue, 14 Feb 2006 16:22:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] block/blktrace.c: make blk_trace_cleanup() static
Message-ID: <20060214152209.GG10701@stusta.de>
References: <20060214014157.59af972f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214014157.59af972f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc2-mm1:
>...
>  git-blktrace.patch
>...


blk_trace_cleanup() is needlessly global.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc3-mm1-full/block/blktrace.c.old	2006-02-14 15:42:12.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/block/blktrace.c	2006-02-14 15:42:23.000000000 +0100
@@ -171,7 +171,7 @@
 	return dir;
 }
 
-void blk_trace_cleanup(struct blk_trace *bt)
+static void blk_trace_cleanup(struct blk_trace *bt)
 {
 	relay_close(bt->rchan);
 	relayfs_remove_file(bt->dropped_file);

