Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422847AbWHYTiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422847AbWHYTiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422850AbWHYTh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:37:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422847AbWHYThi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:37:38 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 16/18] [PATCH] BLOCK: Remove no-longer necessary linux/mpage.h inclusions [try #4]
Date: Fri, 25 Aug 2006 20:37:35 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825193735.11384.93827.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Remove inclusions of linux/mpage.h that are no longer necessary due to the
transfer of generic_writepages().

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cifs/file.c |    1 -
 fs/nfs/write.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 944d2b9..8488f27 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -24,7 +24,6 @@ #include <linux/fs.h>
 #include <linux/backing-dev.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
-#include <linux/mpage.h>
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/smp_lock.h>
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5077499..18b248e 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -51,7 +51,6 @@ #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
-#include <linux/mpage.h>
 #include <linux/writeback.h>
 
 #include <linux/sunrpc/clnt.h>
