Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVAUPJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVAUPJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVAUPJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:09:29 -0500
Received: from mail.suse.de ([195.135.220.2]:15770 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262383AbVAUPJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:09:25 -0500
Subject: [trivial patch] fs/mbcache.c: Remove an unused wait queue variable
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106320163.19651.13.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 Jan 2005 16:09:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This one slipped me. The "real" wait queue is defined some lines further
down inside the loop.

In the future, where should I best send trivial tings like this? Thank
you!

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/mbcache.c
===================================================================
--- linux-2.6.11-latest.orig/fs/mbcache.c
+++ linux-2.6.11-latest/fs/mbcache.c
@@ -554,8 +554,6 @@ static struct mb_cache_entry *
 __mb_cache_entry_find(struct list_head *l, struct list_head *head,
 		      int index, struct block_device *bdev, unsigned int key)
 {
-	DEFINE_WAIT(wait);
-
 	while (l != head) {
 		struct mb_cache_entry *ce =
 			list_entry(l, struct mb_cache_entry,


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

