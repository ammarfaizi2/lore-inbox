Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVDKQIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVDKQIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDKQIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:08:52 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:24980 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261829AbVDKQHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:07:50 -0400
Message-Id: <20050411160740.112425000@faui31y>
References: <20050411155806.754650000@faui31y>
Date: Mon, 11 Apr 2005 17:58:08 +0200
From: Martin Waitz <tali@admingilde.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2/2] DocBook: fix html link
Content-Disposition: inline; filename=docbook-fix-html-link.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: fix html link

The start page for each book has changed from book1.html to index.html.
Update our generated links acocrdingly.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
 Documentation/DocBook/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-docbook/Documentation/DocBook/Makefile
===================================================================
--- linux-docbook.orig/Documentation/DocBook/Makefile	2005-04-09 13:27:12.000000000 +0200
+++ linux-docbook/Documentation/DocBook/Makefile	2005-04-09 14:35:55.000000000 +0200
@@ -115,7 +115,7 @@ quiet_cmd_db2pdf = XMLTO   $@
 
 quiet_cmd_db2html = XMLTO  $@
       cmd_db2html = xmlto xhtml $(XMLTOFLAGS) -o $(patsubst %.html,%,$@) $< && \
-		echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/book1.html"> \
+		echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/index.html"> \
          Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
 
 %.html:	%.xml

--
Martin Waitz
