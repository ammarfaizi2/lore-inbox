Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUG2Sev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUG2Sev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUG2SdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:33:16 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:15569 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267515AbUG2SbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:31:23 -0400
Date: Thu, 29 Jul 2004 13:31:20 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] utilize all cpus when building an rpm
Message-ID: <20040729183120.GC15920@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize all processors on the system when building an rpm.

Signed-off-by: Greg Edwards <edwardsg@sgi.com>


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/29 13:15:17-05:00 edwardsg@attica.americas.sgi.com 
#   Utilize all processors on the system when building an rpm.
# 
# scripts/package/mkspec
#   2004/07/29 13:15:08-05:00 edwardsg@attica.americas.sgi.com +1 -1
#   Add %{?_smp_mflags} rpm macro to make command line to utilize the
#   number of processors on the system.
# 
diff -Nru a/scripts/package/mkspec b/scripts/package/mkspec
--- a/scripts/package/mkspec	2004-07-29 13:27:57 -05:00
+++ b/scripts/package/mkspec	2004-07-29 13:27:57 -05:00
@@ -40,7 +40,7 @@
 echo "%setup -q"
 echo ""
 echo "%build"
-echo "make clean && make"
+echo "make clean && make %{?_smp_mflags}"
 echo ""
 echo "%install"
 
