Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262192AbSJASrD>; Tue, 1 Oct 2002 14:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSJASrD>; Tue, 1 Oct 2002 14:47:03 -0400
Received: from tbaytel3.tbaytel.net ([206.47.150.179]:58024 "EHLO tbaytel.net")
	by vger.kernel.org with ESMTP id <S262192AbSJASrB> convert rfc822-to-8bit;
	Tue, 1 Oct 2002 14:47:01 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
Organization: Garrett Kajmowicz
To: linux-kernel@vger.kernel.org
Subject: [PATCH, TRIVIAL] 2.4.20-pre8 BeFS Config.in modification
Date: Tue, 1 Oct 2002 14:48:06 -0400
User-Agent: KMail/1.4.1
Cc: will@cs.earlham.edu
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210011448.06125.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am planning on making an effort to move the relevent code for the Config.in 
files into the appropriate directory.  Attached is a simple patch which will 
do this for the BeFS.

Questions:
Is this appropriate for this list?
Are there any reasons not to do this?
As I am planning on doing a lot of these, where should I send them?
Any other suggestions/advice?

Please Cc: all comments to:

Garrett Kajmowicz
gkajmowi@tbaytel.net

diff -Nru linux-2.4.19old/fs/Config.in linux-2.4.19new/fs/Config.in
--- linux-2.4.19old/fs/Config.in        2002-10-01 08:22:21.000000000 -0400
+++ linux-2.4.19new/fs/Config.in        2002-10-01 14:11:39.000000000 -0400
@@ -19,8 +19,7 @@

 dep_tristate 'Apple Macintosh file system support (EXPERIMENTAL)' 
CONFIG_HFS_FS $CONFIG_EXPERIMENTAL

-dep_tristate 'BeOS file systemv(BeFS) support (read only) (EXPERIMENTAL)' 
CONFIG_BEFS_FS $CONFIG_EXPERIMENTAL
-dep_mbool '  Debug Befs' CONFIG_BEFS_DEBUG $CONFIG_BEFS_FS
+source fs/befs/Config.in

 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS 
$CONFIG_EXPERIMENTAL

diff -Nru linux-2.4.19old/fs/befs/Config.in linux-2.4.19new/fs/befs/Config.in
--- linux-2.4.19old/fs/befs/Config.in   1969-12-31 19:00:00.000000000 -0500
+++ linux-2.4.19new/fs/befs/Config.in   2002-10-01 14:10:54.000000000 -0400
@@ -0,0 +1,2 @@
+dep_tristate 'BeOS file systemv(BeFS) support (read only) (EXPERIMENTAL)' 
CONFIG_BEFS_FS $CONFIG_EXPERIMENTAL
+dep_mbool '  Debug Befs' CONFIG_BEFS_DEBUG $CONFIG_BEFS_FS
