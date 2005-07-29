Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVG2LDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVG2LDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVG2LBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:01:41 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:41486 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262598AbVG2LBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:01:35 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] fuse: documentation update
Message-Id: <E1DyScD-0004rS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Jul 2005 13:01:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add homepage pointer.

Clarify security requirements, based on discussion with Frank van
Maarseveen.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.13-rc3-mm3/Documentation/filesystems/fuse.txt linux-fuse/Documentation/filesystems/fuse.txt
--- linux-2.6.13-rc3-mm3/Documentation/filesystems/fuse.txt	2005-07-29 10:56:43.000000000 +0200
+++ linux-fuse/Documentation/filesystems/fuse.txt	2005-07-29 10:36:59.000000000 +0200
@@ -38,6 +38,11 @@ non-privileged mounts.  This opens up ne
 filesystems.  A good example is sshfs: a secure network filesystem
 using the sftp protocol.
 
+The userspace library and utilities are available from the FUSE
+homepage:
+
+  http://fuse.sourceforge.net/
+
 Mount options
 ~~~~~~~~~~~~~
 
@@ -166,14 +171,14 @@ How are requirements fulfilled?
      2) Even if 1) is solved the mount owner can change the behavior
         of other users' processes.
 
-         - It can slow down or indefinitely delay the execution of a
+         i) It can slow down or indefinitely delay the execution of a
            filesystem operation creating a DoS against the user or the
            whole system.  For example a suid application locking a
            system file, and then accessing a file on the mount owner's
            filesystem could be stopped, and thus causing the system
            file to be locked forever.
 
-         - It can present files or directories of unlimited length, or
+         ii) It can present files or directories of unlimited length, or
            directory structures of unlimited depth, possibly causing a
            system process to eat up diskspace, memory or other
            resources, again causing DoS.
@@ -186,6 +191,11 @@ How are requirements fulfilled?
 	ptrace can be used to check if a process is allowed to access
 	the filesystem or not.
 
+	Note that the ptrace check is not strictly necessary to
+	prevent B/2/i, it is enough to check if mount owner has enough
+	privilege to send signal to the process accessing the
+	filesystem, since SIGSTOP can be used to get a similar effect.
+
 I think these limitations are unacceptable?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
