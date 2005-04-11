Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVDKQKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVDKQKM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVDKQJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:09:34 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:24468 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261816AbVDKQHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:07:47 -0400
Message-Id: <20050411160739.635973000@faui31y>
References: <20050411155806.754650000@faui31y>
Date: Mon, 11 Apr 2005 17:58:07 +0200
From: Martin Waitz <tali@admingilde.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 1/2] Docbook: use custom stylesheet
Content-Disposition: inline; filename=docbook-custom-stylesheet.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Docbook: use custom stylesheet

With the custom stylesheet, functions are rendered using ANSI-C syntax
and xmlto is a bit quieter.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
 Documentation/DocBook/Makefile       |    3 ++-
 Documentation/DocBook/stylesheet.xsl |    5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-docbook/Documentation/DocBook/Makefile
===================================================================
--- linux-docbook.orig/Documentation/DocBook/Makefile	2005-04-06 15:46:05.000000000 +0200
+++ linux-docbook/Documentation/DocBook/Makefile	2005-04-10 12:57:53.678951360 +0200
@@ -49,7 +49,8 @@ installmandocs: mandocs
 KERNELDOC = scripts/kernel-doc
 DOCPROC   = scripts/basic/docproc
 
-#XMLTOFLAGS = --skip-validation
+XMLTOFLAGS = -m Documentation/DocBook/stylesheet.xsl
+#XMLTOFLAGS += --skip-validation
 
 ###
 # DOCPROC is used for two purposes:
Index: linux-docbook/Documentation/DocBook/stylesheet.xsl
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-docbook/Documentation/DocBook/stylesheet.xsl	2005-04-09 13:59:56.000000000 +0200
@@ -0,0 +1,5 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<param name="chunk.quietly">1</param>
+<param name="funcsynopsis.style">ansi</param>
+</stylesheet>

--
Martin Waitz
