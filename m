Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUC1MVw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUC1MVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:21:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:63753 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261610AbUC1MVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:21:47 -0500
Date: Sun, 28 Mar 2004 14:21:39 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, faith@valinux.com
Subject: [PATCH-2.4.26] drm/radeon_mem cleanup
Message-ID: <20040328122139.GE24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

drm/radeon_mem ouputs a warning because print_heap() is never
used in 2.4.26-rc1. I only commented it out to keep it useful
for debugging purposes. Please apply.

Willy

--- ./drivers/char/drm/radeon_mem.c.orig	Sun Mar 28 14:07:38 2004
+++ ./drivers/char/drm/radeon_mem.c	Sun Mar 28 14:08:16 2004
@@ -131,6 +131,7 @@
 	}
 }
 
+#if 0
 static void print_heap( struct mem_block *heap )
 {
 	struct mem_block *p;
@@ -140,6 +141,7 @@
 			  p->start, p->start + p->size,
 			  p->size, p->pid);
 }
+#endif
 
 /* Initialize.  How to check for an uninitialized heap?
  */
