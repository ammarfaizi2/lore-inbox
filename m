Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267764AbUHRVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267764AbUHRVLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267756AbUHRVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:09:50 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:52528 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267783AbUHRVH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:07:58 -0400
Date: Thu, 19 Aug 2004 01:08:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Add comments to Makefile.clean
Message-ID: <20040818230811.GF23495@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040818230252.GA23495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818230252.GA23495@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/18 23:17:03+02:00 sam@mars.ravnborg.org 
#   kbuild: add comments to Makefile.clean
#   
#   Chris Wedgwood <cw@f00f.org> wrote:
#   > P.S. I'd love to see the rules in scripts/Makefile.* documented.  I
#   >      would offer a patch for this but I don't understand the rules
#   >      myself...
#   And provided the following patch, slightly modified by me.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.clean
#   2004/08/18 23:16:47+02:00 sam@mars.ravnborg.org +12 -0
#   Add comments
# 
diff -Nru a/scripts/Makefile.clean b/scripts/Makefile.clean
--- a/scripts/Makefile.clean	2004-08-19 01:08:07 +02:00
+++ b/scripts/Makefile.clean	2004-08-19 01:08:07 +02:00
@@ -29,13 +29,25 @@
 # Add subdir path
 
 subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
+
+# build a list of files to remove, usually releative to the current
+# directory
+
 __clean-files	:= $(extra-y) $(EXTRA_TARGETS) $(always) \
 		   $(targets) $(clean-files)             \
 		   $(host-progs)                         \
 		   $(hostprogs-y) $(hostprogs-m) $(hostprogs-)
+
+# as clean-files is given relative to the current directory, this adds
+# a $(obj) prefix, except for absolute paths
+
 __clean-files   := $(wildcard                                               \
                    $(addprefix $(obj)/, $(filter-out /%, $(__clean-files))) \
 		   $(filter /%, $(__clean-files)))
+
+# as clean-dirs is given relative to the current directory, this adds
+# a $(obj) prefix, except for absolute paths
+
 __clean-dirs    := $(wildcard                                               \
                    $(addprefix $(obj)/, $(filter-out /%, $(clean-dirs)))    \
 		   $(filter /%, $(clean-dirs)))
