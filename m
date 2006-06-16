Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWFPGRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWFPGRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWFPGRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:17:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47514 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751067AbWFPGRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:17:11 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: marcelo@kvack.org
Subject: Older git hooks for linux-2.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Jun 2006 16:16:37 +1000
Message-ID: <26721.1150438597@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rsync rsync://rsync.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/

has hooks that do not match the current git template hooks.

git-clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/

appears to install the hooks from the local template directory, rather
than cloning from the remote repository.  Is the difference between the
rsync and git-clone commands an expected behaviour?  And should the
hooks in /pub/scm/linux/kernel/git/marcelo/linux-2.4.git be updated to
match the current git templates?

--- rsync/linux-2.4.git/hooks/pre-commit	2006-04-27 09:47:55.000000000 +1000
+++ git-clone/.git/hooks/pre-commit	2006-06-16 14:46:21.408899146 +1000
@@ -61,6 +61,9 @@
 	    if (/^\s* 	/) {
 		bad_line("indent SP followed by a TAB", $_);
 	    }
+	    if (/^(?:[<>=]){7}/) {
+		bad_line("unresolved merge conflict", $_);
+	    }
 	}
     }
     exit($found_bad);

