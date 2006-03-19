Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWCSXMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWCSXMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 18:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCSXMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 18:12:54 -0500
Received: from hera.kernel.org ([140.211.167.34]:38283 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751194AbWCSXMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 18:12:54 -0500
Date: Sun, 19 Mar 2006 23:12:47 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603192312.k2JNClhj031794@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] 9p: update documentation
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] 9p: update documentation

Fix documentation to match current implementation.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 Documentation/filesystems/9p.txt |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

20a7393bc97a4fb743ae39ef308af173877685c1
diff --git a/Documentation/filesystems/9p.txt b/Documentation/filesystems/9p.txt
index 24c7a9c..43b89c2 100644
--- a/Documentation/filesystems/9p.txt
+++ b/Documentation/filesystems/9p.txt
@@ -1,5 +1,5 @@
-			V9FS: 9P2000 for Linux
-			======================
+	  	    v9fs: Plan 9 Resource Sharing for Linux
+		    =======================================
 
 ABOUT
 =====
@@ -9,18 +9,19 @@ v9fs is a Unix implementation of the Pla
 This software was originally developed by Ron Minnich <rminnich@lanl.gov>
 and Maya Gokhale <maya@lanl.gov>.  Additional development by Greg Watson
 <gwatson@lanl.gov> and most recently Eric Van Hensbergen
-<ericvh@gmail.com> and Latchesar Ionkov <lucho@ionkov.net>.
+<ericvh@gmail.com>, Latchesar Ionkov <lucho@ionkov.net> and Russ Cox
+<rsc@swtch.com>.
 
 USAGE
 =====
 
 For remote file server:
 
-	mount -t 9P 10.10.1.2 /mnt/9
+	mount -t 9p 10.10.1.2 /mnt/9
 
 For Plan 9 From User Space applications (http://swtch.com/plan9)
 
-	mount -t 9P `namespace`/acme /mnt/9 -o proto=unix,name=$USER
+	mount -t 9p `namespace`/acme /mnt/9 -o proto=unix,uname=$USER
 
 OPTIONS
 =======
@@ -32,7 +33,7 @@ OPTIONS
  			fd   - used passed file descriptors for connection
                                 (see rfdno and wfdno)
 
-  name=name	user name to attempt mount as on the remote server.  The
+  uname=name	user name to attempt mount as on the remote server.  The
   		server may override or ignore this value.  Certain user
 		names may require authentication.
 
@@ -42,7 +43,7 @@ OPTIONS
   debug=n	specifies debug level.  The debug level is a bitmask.
   			0x01 = display verbose error messages
 			0x02 = developer debug (DEBUG_CURRENT)
-			0x04 = display 9P trace
+			0x04 = display 9p trace
 			0x08 = display VFS trace
 			0x10 = display Marshalling debug
 			0x20 = display RPC debug
@@ -53,11 +54,11 @@ OPTIONS
 
   wfdno=n	the file descriptor for writing with proto=fd
 
-  maxdata=n	the number of bytes to use for 9P packet payload (msize)
+  maxdata=n	the number of bytes to use for 9p packet payload (msize)
 
   port=n	port to connect to on the remote server
 
-  noextend	force legacy mode (no 9P2000.u semantics)
+  noextend	force legacy mode (no 9p2000.u semantics)
 
   uid		attempt to mount as a particular uid
 
@@ -72,7 +73,7 @@ OPTIONS
 RESOURCES
 =========
 
-The Linux version of the 9P server is now maintained under the npfs project
+The Linux version of the 9p server is now maintained under the npfs project
 on sourceforge (http://sourceforge.net/projects/npfs).
 
 There are user and developer mailing lists available through the v9fs project
-- 
1.1.0
