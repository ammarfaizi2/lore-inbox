Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWH3UfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWH3UfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWH3UfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:35:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21252 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751492AbWH3UfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:35:09 -0400
Date: Wed, 30 Aug 2006 22:35:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] net/sched/act_simple.c: make struct simp_hash_info static
Message-ID: <20060830203507.GL18276@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm2:
>...
>  git-net.patch
>...
>  git trees
>...

This patch makes the needlessly global struct simp_hash_info static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm3/net/sched/act_simple.c.old	2006-08-30 20:54:20.000000000 +0200
+++ linux-2.6.18-rc4-mm3/net/sched/act_simple.c	2006-08-30 20:54:43.000000000 +0200
@@ -28,7 +28,7 @@
 static u32 simp_idx_gen;
 static DEFINE_RWLOCK(simp_lock);
 
-struct tcf_hashinfo simp_hash_info = {
+static struct tcf_hashinfo simp_hash_info = {
 	.htab	=	tcf_simp_ht,
 	.hmask	=	SIMP_TAB_MASK,
 	.lock	=	&simp_lock,

