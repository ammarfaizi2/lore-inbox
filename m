Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVJBQcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVJBQcw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 12:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVJBQcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 12:32:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19159 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751121AbVJBQcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 12:32:51 -0400
Date: Sun, 2 Oct 2005 09:32:44 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Coywolf Qi Hunt <coywolf@gmail.com>, Greg KH <greg@kroah.com>,
       Paul Jackson <pj@sgi.com>
Message-Id: <20051002163244.17502.15351.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCHv2] Document from line in patch format
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document more details of patch format such as the "from" line
used to specify the patch author, and provide more references
for patch guidelines.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.14-rc2-mm2/Documentation/SubmittingPatches
===================================================================
--- 2.6.14-rc2-mm2.orig/Documentation/SubmittingPatches
+++ 2.6.14-rc2-mm2/Documentation/SubmittingPatches
@@ -301,8 +301,46 @@ now, but you can do this to mark interna
 point out some special detail about the sign-off. 
 
 
+12) The canonical patch format
 
-12) More references for submitting patches
+The canonical patch subject line is:
+
+    Subject: [PATCH 001/123] [<area>:] <explanation>
+
+The canonical patch message body contains the following:
+
+    The first line of the body contains a "from" line specifying
+    the author of the patch:
+
+        From: Original Author <author@email.com>
+
+    If the "from" line is missing, then the author of the patch will
+    be recorded in the source code revision history as whomever sent
+    Linus the email (the email message "From:" header.)
+
+    The "from" line is followed by an empty line and then the body
+    of the explanation.
+
+    After the body of the explanation comes the "Signed-off-by:"
+    lines, and then a simple "---" line, and below that comes the
+    diffstat of the patch and then the patch itself.  The "---" line
+    and diffstat are optional, but helpful to readers of non-trivial
+    patches.
+
+The Subject line format makes it very easy to sort the emails
+alphabetically by subject line - pretty much any email reader will
+support that - since because the sequence number is zero-padded,
+the numerical and alphabetic sort is the same.
+
+See further details on how to phrase the "<explanation>" in
+the "Subject:" line in Andrew Morton's "The perfect patch",
+referenced below.
+
+See more details on the proper patch format in the following
+references.
+
+
+13) More references for submitting patches
 
 Andrew Morton, "The perfect patch" (tpp).
   <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>
@@ -310,6 +348,14 @@ Andrew Morton, "The perfect patch" (tpp)
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
