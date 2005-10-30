Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVJ3PyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVJ3PyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVJ3PyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:54:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49934 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932169AbVJ3Pxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:53:44 -0500
Date: Sun, 30 Oct 2005 16:53:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/namei.c: make path_lookup_create() static
Message-ID: <20051030155343.GF4180@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 01:48:38AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.14-rc4-mm1:
>...
>  git-nfs.patch
>...
>  Subsystem trees
>...


<--  snip  -->


This patch makes the needlessly global function path_lookup_create() 
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/fs/namei.c.old	2005-10-30 16:24:01.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/namei.c	2005-10-30 16:24:25.000000000 +0100
@@ -1109,8 +1109,9 @@
  * @open_flags: open intent flags
  * @create_mode: create intent flags
  */
-int path_lookup_create(const char *name, unsigned int lookup_flags,
-		struct nameidata *nd, int open_flags, int create_mode)
+static int path_lookup_create(const char *name, unsigned int lookup_flags,
+			      struct nameidata *nd, int open_flags,
+			      int create_mode)
 {
 	return __path_lookup_intent_open(name, lookup_flags|LOOKUP_CREATE, nd,
 			open_flags, create_mode);

