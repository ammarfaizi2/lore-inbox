Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVDUUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVDUUnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVDUUnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:43:12 -0400
Received: from bandersnatch.cs.drexel.edu ([129.25.6.163]:22677 "EHLO
	bandersnatch.cs.drexel.edu") by vger.kernel.org with ESMTP
	id S261870AbVDUUnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:43:08 -0400
From: Cosmin Nicolaescu <can29@bandersnatch.cs.drexel.edu>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH 2.6.11] [corrected] Documentation: remove super-{nr, max} to reflect fs/super.c  
Message-Id: <20050421204308.6462B2051048F@bandersnatch.cs.drexel.edu>
Date: Thu, 21 Apr 2005 16:43:08 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch updates the documentation for /proc. super-nr and super-max have
been dropped from the kernel since 2.4.9 due to minor numbering issues.
This change was not documented in the documentation.
The original patch submitted just a while ago had the files
reversed. Sorry about that.

--- linux-2.6.11/Documentation/filesystems/proc.txt.orig        2005-04-21 16:38:33.900779693 -0400
+++ linux-2.6.11/Documentation/filesystems/proc.txt     2005-04-21 16:38:45.805174536 -0400
@@ -909,16 +909,6 @@ nr_free_inodes
 Represents the  number of free inodes. Ie. The number of inuse inodes is
 (nr_inodes - nr_free_inodes).
 
-super-nr and super-max
-----------------------
-
-Again, super  block structures are allocated by the kernel, but not freed. The
-file super-max  contains  the  maximum  number  of super block handlers, where
-super-nr shows the number of currently allocated ones.
-
-Every mounted file system needs a super block, so if you plan to mount lots of
-file systems, you may want to increase these numbers.
-
 aio-nr and aio-max-nr
 ---------------------

Signed-off-by: Cosmin Nicolaescu <cos@camelot.homelinux.com>
