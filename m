Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWCDMPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWCDMPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCDMOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23056 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751843AbWCDMOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:42 -0500
Date: Sat, 4 Mar 2006 13:14:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] mm/bootmem.c: make bdata_list static
Message-ID: <20060304121442.GQ9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bdata_list is global for no good reason.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/mm/bootmem.c.old	2006-03-03 18:21:41.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/mm/bootmem.c	2006-03-03 18:21:58.000000000 +0100
@@ -33,7 +33,7 @@
 				 * dma_get_required_mask(), which uses
 				 * it, can be an inline function */
 
-LIST_HEAD(bdata_list);
+static LIST_HEAD(bdata_list);
 #ifdef CONFIG_CRASH_DUMP
 /*
  * If we have booted due to a crash, max_pfn will be a very low value. We need

