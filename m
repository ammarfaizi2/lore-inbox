Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUJZALS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUJZALS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUJYPHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:07:10 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:1961 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261882AbUJYOtz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:49:55 -0400
Cc: raven@themaw.net
Subject: [PATCH 22/28] VFS: Export put_namespace
In-Reply-To: <1098715750856@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:49:40 -0400
Message-Id: <10987157802675@sun.com>
References: <1098715750856@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the __put_namespace symbol so that autofsng can call it as
a module (used as part of the call-out mechanism).

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 namespace.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:41.368175224 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:45.491548376 -0400
@@ -1733,3 +1733,4 @@ void __put_namespace(struct namespace *n
 	mntput(namespace->root);
 	kfree(namespace);
 }
+EXPORT_SYMBOL(__put_namespace);

