Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVLMV3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVLMV3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVLMV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:29:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8139 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932385AbVLMV3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:29:54 -0500
Date: Tue, 13 Dec 2005 13:29:44 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] slab gcc fix
Message-ID: <Pine.LNX.4.62.0512131327140.23733@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we no longer support 2.95, we can get rid of this ugly thing.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/slab.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/slab.c	2005-12-13 13:18:48.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/slab.c	2005-12-13 13:19:11.000000000 -0800
@@ -265,11 +265,10 @@ struct array_cache {
 	unsigned int batchcount;
 	unsigned int touched;
 	spinlock_t lock;
-	void *entry[0];		/*
+	void *entry[];		/*
 				 * Must have this definition in here for the proper
 				 * alignment of array_cache. Also simplifies accessing
 				 * the entries.
-				 * [0] is for gcc 2.95. It should really be [].
 				 */
 };
 
