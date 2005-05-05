Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVEEK03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVEEK03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 06:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVEEK03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 06:26:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19417 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262029AbVEEK0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 06:26:22 -0400
Date: Thu, 5 May 2005 12:26:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] add simple git documentation
Message-ID: <20050505102600.GA16387@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds short intro to git aimed at kernel hackers.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit addb0833bdadda14495d66749e6cb95b6a9445d7
tree 7e66cb899004fbec0fadae5c9265d0731d3a26f3
parent 1f9ca1262e6b27dde44d456a87c456d15f0a9b80
author <pavel@amd.(none)> 1115288688 +0200
committer <pavel@amd.(none)> 1115288688 +0200

Index: Documentation/git.txt
===================================================================
--- /dev/null  (tree:de65e7579ed050d324357e3040b37c561676ab7d)
+++ 7e66cb899004fbec0fadae5c9265d0731d3a26f3/Documentation/git.txt  (mode:100644 sha1:353d5ae7f46eeb79c058be611cb429622167f784)
@@ -0,0 +1,41 @@
+	Kernel hacker's guide to git
+	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+      2005 Pavel Machek <pavel@suse.cz>
+
+You can get cogito at http://www.kernel.org/pub/software/scm/cogito/
+. Compile it, and place it somewhere in $PATH. Then you can get kernel
+by running
+
+mkdir clean-cg; cd clean-cg
+cg-init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+
+... Do cg-update origin to pickup latest changes from Linus. You can
+do cg-diff to see what changes you done in your local tree. cg-cancel
+will kill any such changes, and cg-commit will make them permanent.
+
+To get diff between your working tree and "next tree up", do cg-diff
+-r origin: . If you want to get the same diff but separated
+patch-by-patch, do cg-mkpatch origin: . If you want to pull changes
+from the "up" tree to your working tree, do cg-update origin.
+
+
+How to set up your trees so that you can cooperate with Linus
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+What I did:
+
+Created clean-cg. Initialized straight from Linus (as above). Then I
+created "nice" tree, good for Linus to pull from 
+
+mkdir /data/l/linux-good; cd /data/l/linux-good
+cg-init /data/l/clean-cg
+
+and then my working tree, based on linux-good
+
+mkdir /data/l/linux-cg; cd /data/l/linux-cg
+cg-init /data/l/linux-good
+
+. I do my work in linux-cg. If someone sends me nice patch I should
+pass up, I apply it to linux-good with nice message and do
+
+cd /data/l/linux-cg; cg-update origin

-- 
Boycott Kodak -- for their patent abuse against Java.
