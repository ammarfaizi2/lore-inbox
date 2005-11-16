Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVKPI5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVKPI5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVKPI5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:57:53 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:18586 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030255AbVKPI5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:57:52 -0500
Message-ID: <437AF48A.1090502@namesys.com>
Date: Wed, 16 Nov 2005 00:57:46 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, vs <vs@thebsh.namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH 6/8] reiser4-improved-comment.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070101090201040403090304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070101090201040403090304
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------070101090201040403090304
Content-Type: message/rfc822;
 name="[PATCH 6/8] reiser4-improved-comment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 6/8] reiser4-improved-comment.patch"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24432 invoked from network); 15 Nov 2005 17:00:12 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:12 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id 17EF971D996; Tue, 15 Nov 2005 19:59:46 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 6/8] reiser4-improved-comment.patch
Message-ID: <437A1402.mail7JR1VEH1G@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1C8YR12E6D-=-HGTBPS7XQX-CUT-HERE-WQF4A10SY8-=-UFZ531G3SG"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--1C8YR12E6D-=-HGTBPS7XQX-CUT-HERE-WQF4A10SY8-=-UFZ531G3SG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--1C8YR12E6D-=-HGTBPS7XQX-CUT-HERE-WQF4A10SY8-=-UFZ531G3SG
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-improved-comment.patch"


From: Vladimir Saveliev <vs@namesys.com>

Improved comment for structure hint. Cleanup.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/plugin/file/file.h |   67 +++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 27 deletions(-)

diff -puN fs/reiser4/plugin/file/file.h~reiser4-improved-comment fs/reiser4/plugin/file/file.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/file.h~reiser4-improved-comment	2005-11-15 17:19:21.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/file.h	2005-11-15 17:19:21.000000000 +0300
@@ -42,9 +42,11 @@ void init_inode_data_unix_file(struct in
 			       int create);
 int delete_object_unix_file(struct inode *);
 
-/* all the write into unix file is performed by item write method. Write method
-   of unix file plugin only decides which item plugin (extent or tail) and in
-   which mode (one from the enum below) to call */
+/*
+ * all the write into unix file is performed by item write method. Write method
+ * of unix file plugin only decides which item plugin (extent or tail) and in
+ * which mode (one from the enum below) to call
+ */
 typedef enum {
 	FIRST_ITEM = 1,
 	APPEND_ITEM = 2,
@@ -64,23 +66,29 @@ struct inode;
 
 /* unix file plugin specific part of reiser4 inode */
 typedef struct unix_file_info {
-	/* this read-write lock protects file containerization change. Accesses
-	   which do not change file containerization (see file_container_t)
-	   (read, readpage, writepage, write (until tail conversion is
-	   involved)) take read-lock. Accesses which modify file
-	   containerization (truncate, conversion from tail to extent and back)
-	   take write-lock. */
+	/*
+	 * this read-write lock protects file containerization change. Accesses
+	 * which do not change file containerization (see file_container_t)
+	 * (read, readpage, writepage, write (until tail conversion is
+	 * involved)) take read-lock. Accesses which modify file
+	 * containerization (truncate, conversion from tail to extent and back)
+	 * take write-lock.
+	 */
 	struct rw_semaphore latch;
-	/* this semaphore is used to serialize writes instead of inode->i_sem,
-	   because write_unix_file uses get_user_pages which is to be used
-	   under mm->mmap_sem and because it is required to take mm->mmap_sem
-	   before inode->i_sem, so inode->i_sem would have to be up()-ed before
-	   calling to get_user_pages which is unacceptable */
+	/*
+	 * this semaphore is used to serialize writes instead of inode->i_sem,
+	 * because write_unix_file uses get_user_pages which is to be used
+	 * under mm->mmap_sem and because it is required to take mm->mmap_sem
+	 * before inode->i_sem, so inode->i_sem would have to be up()-ed before
+	 * calling to get_user_pages which is unacceptable
+	 */
 	struct semaphore write;
 	/* this enum specifies which items are used to build the file */
 	file_container_t container;
-	/* plugin which controls when file is to be converted to extents and
-	   back to tail */
+	/*
+	 * plugin which controls when file is to be converted to extents and
+	 * back to tail
+	 */
 	struct formatting_plugin *tplug;
 	/* if this is set, file is in exclusive use */
 	int exclusive_use;
@@ -117,10 +125,15 @@ struct uf_coord {
 #include "../../seal.h"
 #include "../../lock.h"
 
-/* structure used to speed up file operations (reads and writes). It contains
- * a seal over last file item accessed. */
+/*
+ * This structure is used to speed up file operations (reads and writes).  A
+ * hint is a suggestion about where a key resolved to last time.  A seal
+ * indicates whether a node has been modified since a hint was last recorded.
+ * You check the seal, and if the seal is still valid, you can use the hint
+ * without traversing the tree again.
+ */
 struct hint {
-	seal_t seal;
+	seal_t seal; /* a seal over last file item accessed */
 	uf_coord_t ext_coord;
 	loff_t offset;
 	znode_lock_mode mode;
@@ -203,12 +216,12 @@ extern reiser4_plugin_ops cryptcompress_
 #endif
 
 /*
-   Local variables:
-   c-indentation-style: "K&R"
-   mode-name: "LC"
-   c-basic-offset: 8
-   tab-width: 8
-   fill-column: 120
-   scroll-step: 1
-   End:
+ * Local variables:
+ * c-indentation-style: "K&R"
+ * mode-name: "LC"
+ * c-basic-offset: 8
+ * tab-width: 8
+ * fill-column: 79
+ * scroll-step: 1
+ * End:
 */

_

--1C8YR12E6D-=-HGTBPS7XQX-CUT-HERE-WQF4A10SY8-=-UFZ531G3SG--



--------------070101090201040403090304--
