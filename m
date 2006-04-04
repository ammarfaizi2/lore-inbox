Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWDDQb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWDDQb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWDDQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:30:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7438 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750752AbWDDQaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:30:12 -0400
Date: Tue, 4 Apr 2006 18:30:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [-mm patch] fs/nfsd/nfs4state.c: make a struct static
Message-ID: <20060404163010.GQ6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.16-mm2:
>...
> +knfsd-locks-flag-nfsv4-owned-locks.patch
>...
>  knfsd updates.
>...

This patch makes the needlessly global struct nfsd_posix_mng_ops static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/fs/nfsd/nfs4state.c.old	2006-04-04 18:03:25.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/fs/nfsd/nfs4state.c	2006-04-04 18:03:38.000000000 +0200
@@ -2507,7 +2507,7 @@
 
 /* Hack!: For now, we're defining this just so we can use a pointer to it
  * as a unique cookie to identify our (NFSv4's) posix locks. */
-struct lock_manager_operations nfsd_posix_mng_ops  = {
+static struct lock_manager_operations nfsd_posix_mng_ops  = {
 };
 
 static inline void
