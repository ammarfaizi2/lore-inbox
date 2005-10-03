Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVJCH3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVJCH3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 03:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVJCH3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 03:29:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57827 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932171AbVJCH3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 03:29:31 -0400
Date: Mon, 3 Oct 2005 00:29:10 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>, Coywolf Qi Hunt <coywolf@gmail.com>,
       Greg KH <greg@kroah.com>, Paul Jackson <pj@sgi.com>
Message-Id: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Document patch subject line better
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve explanation of the Subject line fields in
Documentation/SubmittingPatches Canonical Patch Format.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.14-rc2-mm2/Documentation/SubmittingPatches
===================================================================
--- 2.6.14-rc2-mm2.orig/Documentation/SubmittingPatches
+++ 2.6.14-rc2-mm2/Documentation/SubmittingPatches
@@ -305,7 +305,7 @@ point out some special detail about the 
 
 The canonical patch subject line is:
 
-    Subject: [PATCH 001/123] [<area>:] <explanation>
+    Subject: [PATCH 001/123] subsystem: summary phrase
 
 The canonical patch message body contains the following:
 
@@ -330,9 +330,25 @@ alphabetically by subject line - pretty 
 support that - since because the sequence number is zero-padded,
 the numerical and alphabetic sort is the same.
 
-See further details on how to phrase the "<explanation>" in the
-"Subject:" line in Andrew Morton's "The perfect patch", referenced
-below.
+The "subsystem" in the email's Subject should identify which
+area or subsystem of the kernel is being patched.
+
+The "summary phrase" in the email's Subject should concisely
+describe the patch which that email contains.  The "summary
+phrase" should not be a filename.  Do not use the same "summary
+phrase" for every patch in a whole patch series.
+
+Bear in mind that the "summary phrase" of your email becomes
+a globally-unique identifier for that patch.  It propagates
+all the way into the git changelog.  The "summary phrase" may
+later be used in developer discussions which refer to the patch.
+People will want to google for the "summary phrase" to read
+discussion regarding that patch.
+
+A couple of example Subjects:
+
+    Subject: [patch 2/5] ext2: improve scalability of bitmap searching
+    Subject: [PATCHv2 001/207] x86: fix eflags tracking
 
 The "from" line must be the very first line in the message body,
 and has the form:

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
