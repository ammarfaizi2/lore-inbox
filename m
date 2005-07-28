Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVG1Psx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVG1Psx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVG1PqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:46:06 -0400
Received: from [151.97.230.9] ([151.97.230.9]:43940 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261497AbVG1Poe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:44:34 -0400
Subject: [patch 1/2] doc: describe Kbuild pitfall
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       sam@ravnborg.org
From: blaisorblade@yahoo.it
Date: Thu, 28 Jul 2005 17:56:17 +0200
Message-Id: <20050728155622.62F2E1ADB5@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Sam Ravnborg <sam@ravnborg.org>

Whitespace is significant for make, and I just fought against this... so
please apply this patch.

I'm resending since this hasn't been applied for a long time.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/Documentation/kbuild/makefiles.txt |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN Documentation/kbuild/makefiles.txt~doc-add-pitfall Documentation/kbuild/makefiles.txt
--- linux-2.6.git/Documentation/kbuild/makefiles.txt~doc-add-pitfall	2005-07-28 17:47:08.000000000 +0200
+++ linux-2.6.git-paolo/Documentation/kbuild/makefiles.txt	2005-07-28 17:47:08.000000000 +0200
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
