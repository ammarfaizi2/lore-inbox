Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSFXUCw>; Mon, 24 Jun 2002 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSFXUCv>; Mon, 24 Jun 2002 16:02:51 -0400
Received: from [200.250.102.36] ([200.250.102.36]:48910 "HELO
	sergioyamada.com.br") by vger.kernel.org with SMTP
	id <S315218AbSFXUCv>; Mon, 24 Jun 2002 16:02:51 -0400
Date: 24 Jun 2002 20:13:40 -0000
Message-ID: <20020624201340.2254.qmail@sergioyamada.com.br>
From: polo@sergioyamada.com.br
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/DocBook/Makefile - 2.4.19-rc1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A little patch to fix somethings that I think it isn't correct.

--- linux/Documentation/DocBook/Makefile.orig   Mon Jun 24 15:50:07 2002
+++ linux/Documentation/DocBook/Makefile        Mon Jun 24 15:53:36 2002
@@ -26,9 +26,15 @@
 man:   kernel-api-man

 %.eps: %.fig
+       @(which fig2dev > /dev/null 2>&1) || \
+        (echo "*** You need to instal transfig ***"; \
+         exit 1)
        fig2dev -Leps $< $@

 %.png: %.fig
+       @(which fig2dev > /dev/null 2>&1) || \
+        (echo "*** You need to instal transfig ***"; \
+         exit 1)
        fig2dev -Lpng $< $@

 %.sgml: %.c
@@ -160,19 +166,19 @@

 %.ps : %.sgml
        @(which db2ps > /dev/null 2>&1) || \
-        (echo "*** You need to install DocBook stylesheets ***"; \
+        (echo "*** You need to install DocBook utils ***"; \
          exit 1)
        db2ps $<

 %.pdf : %.sgml
        @(which db2pdf > /dev/null 2>&1) || \
-        (echo "*** You need to install DocBook stylesheets ***"; \
+        (echo "*** You need to install DocBook utils ***"; \
          exit 1)
        db2pdf $<

 %:     %.sgml
        @(which db2html > /dev/null 2>&1) || \
-        (echo "*** You need to install DocBook stylesheets ***"; \
+        (echo "*** You need to install DocBook utils ***"; \
          exit 1)
        rm -rf $@
        db2html $<
