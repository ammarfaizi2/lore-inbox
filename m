Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945944AbWGOAhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945944AbWGOAhB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945940AbWGOAge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:36:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945942AbWGOAgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:36:32 -0400
Date: Sat, 15 Jul 2006 02:36:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC: -mm patch] fs/dlm/lock.c: unexport dlm_lvb_operations
Message-ID: <20060715003631.GM3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc1-mm1:
>...
>  git-gfs2.patch
>...
>  git trees.
>...

This patch removes the unused EXPORT_SYMBOL_GPL(dlm_lvb_operations).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm2-full/fs/dlm/lock.c.old	2006-07-15 00:39:11.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/fs/dlm/lock.c	2006-07-15 00:39:17.000000000 +0200
@@ -128,7 +128,6 @@
         {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
         {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
 };
-EXPORT_SYMBOL_GPL(dlm_lvb_operations);
 
 #define modes_compat(gr, rq) \
 	__dlm_compat_matrix[(gr)->lkb_grmode + 1][(rq)->lkb_rqmode + 1]

