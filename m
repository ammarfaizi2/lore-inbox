Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVBGTPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVBGTPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVBGTPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:15:42 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:14300 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261254AbVBGTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:15:16 -0500
Subject: [patch 1/2] uml - kbuild: add further cleaning [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Mon, 07 Feb 2005 20:11:32 +0100
Message-Id: <20050207191133.25DEF21251@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Descend into arch/um/kernel/skas/util during make clean.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/skas/Makefile |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/um/kernel/skas/Makefile~uml-kbuild-add-further-cleaning arch/um/kernel/skas/Makefile
--- linux-2.6.11/arch/um/kernel/skas/Makefile~uml-kbuild-add-further-cleaning	2005-02-07 19:36:20.077171544 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/skas/Makefile	2005-02-07 19:36:20.080171088 +0100
@@ -11,3 +11,5 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+
+subdir- := util
_
