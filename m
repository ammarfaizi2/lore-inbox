Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVCTK1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVCTK1X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVCTK1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:27:23 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:19599 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262136AbVCTK06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:26:58 -0500
Subject: [patch 1/1] doc: describe Kbuild pitfall
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       sam@ravnborg.org
From: blaisorblade@yahoo.it
Date: Sat, 19 Mar 2005 17:58:35 +0100
Message-Id: <20050319165836.BDB6D647C@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Sam Ravnborg <sam@ravnborg.org>

Whitespace is significant for make, and I just fought against this... so
please apply this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/Documentation/kbuild/makefiles.txt |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN Documentation/kbuild/makefiles.txt~doc-add-pitfall Documentation/kbuild/makefiles.txt
--- linux-2.6.11/Documentation/kbuild/makefiles.txt~doc-add-pitfall	2005-03-19 17:52:48.000000000 +0100
+++ linux-2.6.11-paolo/Documentation/kbuild/makefiles.txt	2005-03-19 17:53:57.000000000 +0100
@@ -872,7 +872,13 @@ When kbuild executes the following steps
 	Assignments to $(targets) are without $(obj)/ prefix.
 	if_changed may be used in conjunction with custom commands as
 	defined in 6.7 "Custom kbuild commands".
+
 	Note: It is a typical mistake to forget the FORCE prerequisite.
+	Another pitfall that bit me once is that whitespace is sometimes
+	significant; for instance, the below will fail (note the extra space
+	after the comma):
+		target: source(s) FORCE
+			$(call if_changed, ld/objcopy/gzip)
 
     ld
 	Link target. Often LDFLAGS_$@ is used to set specific options to ld.
_
