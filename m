Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVKPIvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVKPIvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVKPIvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:51:03 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:63127 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030232AbVKPIvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:51:02 -0500
Message-ID: <437AF2ED.1070305@namesys.com>
Date: Wed, 16 Nov 2005 00:50:53 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, vs <vs@thebsh.namesys.com>
Subject: [Fwd: [Fwd: [PATCH 2/8] reiser4-back-to-one-Makefile.patch]]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040503090708080904000009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040503090708080904000009
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Oops, I sent to akpm but forgot to cc lkml some of these....

--------------040503090708080904000009
Content-Type: message/rfc822;
 name="[Fwd: [PATCH 2/8] reiser4-back-to-one-Makefile.patch]"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Fwd: [PATCH 2/8] reiser4-back-to-one-Makefile.patch]"

Message-ID: <437AF29E.8010608@namesys.com>
Date: Wed, 16 Nov 2005 00:49:34 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: [Fwd: [PATCH 2/8] reiser4-back-to-one-Makefile.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030508070200020009020006"

This is a multi-part message in MIME format.
--------------030508070200020009020006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------030508070200020009020006
Content-Type: message/rfc822;
 name="[PATCH 2/8] reiser4-back-to-one-Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 2/8] reiser4-back-to-one-Makefile.patch"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24387 invoked from network); 15 Nov 2005 17:00:09 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:09 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id DA23671D991; Tue, 15 Nov 2005 19:59:46 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 2/8] reiser4-back-to-one-Makefile.patch
Message-ID: <437A1402.mail7JB1JT7FF@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="OTCQK1EB0R-=-1SV8Q147AL-CUT-HERE-16H1MY7KKT-=-F207T1QXDE"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--OTCQK1EB0R-=-1SV8Q147AL-CUT-HERE-16H1MY7KKT-=-F207T1QXDE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--OTCQK1EB0R-=-1SV8Q147AL-CUT-HERE-16H1MY7KKT-=-F207T1QXDE
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-back-to-one-Makefile.patch"


From: Vladimir V. Saveliev <vs@namesys.com>

This patch makes reiser4 to build as one module again.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/Makefile |  139 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 93 insertions(+), 46 deletions(-)

diff -puN fs/reiser4/Makefile~reiser4-back-to-one-Makefile fs/reiser4/Makefile
--- linux-2.6.14-mm2/fs/reiser4/Makefile~reiser4-back-to-one-Makefile	2005-11-15 16:59:51.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/Makefile	2005-11-15 17:00:36.000000000 +0300
@@ -4,50 +4,97 @@
 
 obj-$(CONFIG_REISER4_FS) += reiser4.o
 
-reiser4-objs := 		\
-	debug.o			\
-	jnode.o			\
-	znode.o			\
-	key.o			\
-	pool.o			\
-	tree_mod.o		\
-	estimate.o		\
-	carry.o			\
-	carry_ops.o		\
-	lock.o			\
-	tree.o			\
-	context.o		\
-	tap.o			\
-	coord.o			\
-	block_alloc.o		\
-	txnmgr.o		\
-	kassign.o		\
-	flush.o			\
-	wander.o		\
-	eottl.o			\
-	search.o		\
-	page_cache.o		\
-	seal.o			\
-	dscale.o		\
-	flush_queue.o		\
-	ktxnmgrd.o		\
-	blocknrset.o		\
-	super.o			\
-	super_ops.o		\
-	fsdata.o		\
-	export_ops.o		\
-	oid.o			\
-	tree_walk.o		\
-	inode.o			\
-	vfs_ops.o		\
-	as_ops.o		\
-	emergency_flush.o	\
-	entd.o			\
-	readahead.o		\
-	cluster.o		\
-	crypt.o			\
-	status_flags.o		\
-	init_super.o		\
-	safe_link.o
+reiser4-y := \
+		   debug.o \
+		   jnode.o \
+		   znode.o \
+		   key.o \
+		   pool.o \
+		   tree_mod.o \
+		   estimate.o \
+		   carry.o \
+		   carry_ops.o \
+		   lock.o \
+		   tree.o \
+		   context.o \
+		   tap.o \
+		   coord.o \
+		   block_alloc.o \
+		   txnmgr.o \
+		   kassign.o \
+		   flush.o \
+		   wander.o \
+		   eottl.o \
+		   search.o \
+		   page_cache.o \
+		   seal.o \
+		   dscale.o \
+		   flush_queue.o \
+		   ktxnmgrd.o \
+		   blocknrset.o \
+		   super.o \
+		   super_ops.o \
+		   fsdata.o \
+		   export_ops.o \
+		   oid.o \
+		   tree_walk.o \
+		   inode.o \
+		   vfs_ops.o \
+		   as_ops.o \
+		   emergency_flush.o \
+		   entd.o\
+		   readahead.o \
+		   cluster.o \
+		   crypt.o \
+		   status_flags.o \
+		   init_super.o \
+		   safe_link.o \
+           \
+		   plugin/plugin.o \
+		   plugin/plugin_set.o \
+		   plugin/node/node.o \
+		   plugin/object.o \
+		   plugin/inode_ops.o \
+		   plugin/inode_ops_rename.o \
+		   plugin/file_ops.o \
+		   plugin/file_ops_readdir.o \
+		   plugin/file_plugin_common.o \
+		   plugin/file/file.o \
+		   plugin/file/tail_conversion.o \
+		   plugin/file/symlink.o \
+		   plugin/file/cryptcompress.o \
+		   plugin/dir_plugin_common.o \
+		   plugin/dir/hashed_dir.o \
+		   plugin/dir/seekable_dir.o \
+		   plugin/digest.o \
+		   plugin/node/node40.o \
+           \
+		   plugin/compress/minilzo.o \
+		   plugin/compress/compress.o \
+		   plugin/compress/compress_mode.o \
+           \
+		   plugin/item/static_stat.o \
+		   plugin/item/sde.o \
+		   plugin/item/cde.o \
+		   plugin/item/blackbox.o \
+		   plugin/item/internal.o \
+		   plugin/item/tail.o \
+		   plugin/item/ctail.o \
+		   plugin/item/extent.o \
+		   plugin/item/extent_item_ops.o \
+		   plugin/item/extent_file_ops.o \
+		   plugin/item/extent_flush_ops.o \
+           \
+		   plugin/hash.o \
+		   plugin/fibration.o \
+		   plugin/tail_policy.o \
+		   plugin/item/item.o \
+           \
+		   plugin/security/perm.o \
+		   plugin/space/bitmap.o \
+           \
+		   plugin/disk_format/disk_format40.o \
+		   plugin/disk_format/disk_format.o \
+	   \
+		   plugin/regular.o
 
-obj-$(CONFIG_REISER4_FS) += plugin/

_

--OTCQK1EB0R-=-1SV8Q147AL-CUT-HERE-16H1MY7KKT-=-F207T1QXDE--



--------------030508070200020009020006--


--------------040503090708080904000009--
