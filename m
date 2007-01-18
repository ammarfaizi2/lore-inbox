Return-Path: <linux-kernel-owner+w=401wt.eu-S1751454AbXARVVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXARVVR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXARVVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:21:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:45726 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbXARVVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:21:16 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       Eric Van Hensbergen <ericvh@gmail.com>
Subject: [PATCH] 9p: update documentation regarding server applications
Date: Thu, 18 Jan 2007 15:18:19 -0600
Message-Id: <11691550991231-git-send-email-ericvh@gmail.com>
X-Mailer: git-send-email 1.5.0.rc1.gdf1b-dirty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to cover using Inferno as a server for 9p and to
include information about spfs (a stable single-threaded stand-alone 9p
server).

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 Documentation/filesystems/9p.txt |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/9p.txt b/Documentation/filesystems/9p.txt
index 43b89c2..be45fe3 100644
--- a/Documentation/filesystems/9p.txt
+++ b/Documentation/filesystems/9p.txt
@@ -73,8 +73,22 @@ OPTIONS
 RESOURCES
 =========
 
-The Linux version of the 9p server is now maintained under the npfs project
-on sourceforge (http://sourceforge.net/projects/npfs).
+Our current recommendation is to use Inferno (http://www.vitanuova.com/inferno)
+as the 9p server.  You can start a 9p server under Inferno by issuing the 
+following command:
+   ; styxlisten -A tcp!*!564 export '#U*'
+
+The -A specifies an unauthenticated export.  The 564 is the port # (you may
+have to choose a higher port number if running as a normal user).  The '#U*'
+specifies exporting the root of the Linux name space.  You may specify a 
+subset of the namespace by extending the path: '#U*'/tmp would just export
+/tmp.  For more information, see the Inferno manual pages covering styxlisten
+and export.
+
+A Linux version of the 9p server is now maintained under the npfs project
+on sourceforge (http://sourceforge.net/projects/npfs).  There is also a 
+more stable single-threaded version of the server (named spfs) available from 
+the same CVS repository.
 
 There are user and developer mailing lists available through the v9fs project
 on sourceforge (http://sourceforge.net/projects/v9fs).
@@ -96,5 +110,5 @@ STATUS
 
 The 2.6 kernel support is working on PPC and x86.
 
-PLEASE USE THE SOURCEFORGE BUG-TRACKER TO REPORT PROBLEMS.
+PLEASE USE THE KERNEL BUGZILLA TO REPORT PROBLEMS. (http://bugzilla.kernel.org)
 
-- 
1.5.0.rc1.gdf1b-dirty

