Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVJBVwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVJBVwv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVJBVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 17:52:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33469 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932079AbVJBVwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 17:52:50 -0400
Date: Sun, 2 Oct 2005 14:52:22 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Coywolf Qi Hunt <coywolf@gmail.com>, Greg KH <greg@kroah.com>,
       Paul Jackson <pj@sgi.com>
Message-Id: <20051002215222.4444.51101.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCHv3] Document from line in patch format
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document more details of patch format such as the "from" line
and the "---" marker line, and provide more references for
patch guidelines.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

How's this, Linus?  I made "---" mandatory, and buffed
the text some more.

--- 2.6.14-rc2-mm2.orig/Documentation/SubmittingPatches
+++ 2.6.14-rc2-mm2/Documentation/SubmittingPatches
@@ -301,8 +301,71 @@ now, but you can do this to mark interna
 point out some special detail about the sign-off. 
 
 
+12) The canonical patch format
 
-12) More references for submitting patches
+The canonical patch subject line is:
+
+    Subject: [PATCH 001/123] [<area>:] <explanation>
+
+The canonical patch message body contains the following:
+
+  - A "from" line specifying the patch author.
+
+  - An empty line.
+
+  - The body of the explanation, which will be copied to the
+    permanent changelog to describe this patch.
+
+  - The "Signed-off-by:" lines, described above, which will
+    also go in the changelog.
+
+  - A marker line containing simply "---".
+
+  - Any additional comments not suitable for the changelog.
+
+  - The actual patch (diff output).
+
+The Subject line format makes it very easy to sort the emails
+alphabetically by subject line - pretty much any email reader will
+support that - since because the sequence number is zero-padded,
+the numerical and alphabetic sort is the same.
+
+See further details on how to phrase the "<explanation>" in the
+"Subject:" line in Andrew Morton's "The perfect patch", referenced
+below.
+
+The "from" line must be the very first line in the message body,
+and has the form:
+
+        From: Original Author <author@example.com>
+
+The "from" line specifies who will be credited as the author of the
+patch in the permanent changelog.  If the "from" line is missing,
+then the "From:" line from the email header will be used to determine
+the patch author in the changelog.
+
+The explanation body will be committed to the permanent source
+changelog, so should make sense to a competent reader who has long
+since forgotten the immediate details of the discussion that might
+have led to this patch.
+
+The "---" marker line serves the essential purpose of marking for patch
+handling tools where the changelog message ends.  As a compatibility
+hack, some of the patch handling tools take lines beginning with
+"diff -" or "Index: " as alternative forms of the "---" marker.
+The recommended form is "---".
+
+One good use for the additional comments after the "---" marker is for
+a diffstat, to show what files have changed, and the number of inserted
+and deleted lines per file.  A diffstat is especially useful on bigger
+patches.  Other comments relevant only to the moment or the maintainer,
+not suitable for the permanent changelog, should also go here.
+
+See more details on the proper patch format in the following
+references.
+
+
+13) More references for submitting patches
 
 Andrew Morton, "The perfect patch" (tpp).
   <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>
@@ -310,6 +373,14 @@ Andrew Morton, "The perfect patch" (tpp)
 Jeff Garzik, "Linux kernel patch submission format."
   <http://linux.yyz.us/patch-format.html>
 
+Greg KH, "How to piss off a kernel subsystem maintainer"
+  <http://www.kroah.com/log/2005/03/31/>
+
+Kernel Documentation/CodingStyle
+  <http://sosdg.org/~coywolf/lxr/source/>
+
+Linus Torvald's mail on the canonical patch format:
+  <http://lkml.org/lkml/2005/4/7/183>
 
 
 -----------------------------------

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
