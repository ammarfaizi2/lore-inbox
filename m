Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266881AbUHOUUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266881AbUHOUUA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHOUSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:18:23 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:36465 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266879AbUHOUQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:16:46 -0400
Date: Sun, 15 Aug 2004 22:19:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: kbuild: Delete unnessesary $(wildcard ...)
Message-ID: <20040815201921.GD14133@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815201224.GI7682@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 21:41:02+02:00 coywolf@greatcn.org 
#   kbuild: Remove wildcard on KBUILD_OUTPUT
#   
#   This patch removes unnecessary wildcard on KBUILD_OUTPUT
#   
#   Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/08/12 23:09:08+02:00 coywolf@greatcn.org +1 -1
#   kbuild: Remove wildcard on KBUILD_OUTPUT
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-15 22:19:15 +02:00
+++ b/Makefile	2004-08-15 22:19:15 +02:00
@@ -102,7 +102,7 @@
 # check that the output directory actually exists
 saved-output := $(KBUILD_OUTPUT)
 KBUILD_OUTPUT := $(shell cd $(KBUILD_OUTPUT) && /bin/pwd)
-$(if $(wildcard $(KBUILD_OUTPUT)),, \
+$(if $(KBUILD_OUTPUT),, \
      $(error output directory "$(saved-output)" does not exist))
 
 .PHONY: $(MAKECMDGOALS)
