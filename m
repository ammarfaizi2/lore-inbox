Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWHDTMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWHDTMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161375AbWHDTMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:12:54 -0400
Received: from xenotime.net ([66.160.160.81]:677 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161374AbWHDTMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:12:54 -0400
Date: Fri, 4 Aug 2006 12:15:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: zippel@linux-m68k.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kconfig language: add more keywords
Message-Id: <20060804121534.7fe2515d.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add kconfig-language docs for mainmenu, def_bool[ean],
and def_tristate.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kbuild/kconfig-language.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+)

--- linux-2618-rc3g2.orig/Documentation/kbuild/kconfig-language.txt
+++ linux-2618-rc3g2/Documentation/kbuild/kconfig-language.txt
@@ -77,6 +77,11 @@ applicable everywhere (see syntax).
   Optionally dependencies only for this default value can be added with
   "if".
 
+- type definition + default value:
+	"def_bool"/"def_boolean"/"def_tristate" <expr> ["if" <expr>]
+  This is a shorthand notation for a type definition plus a value.
+  Optionally dependencies for this default value can be added with "if".
+
 - dependencies: "depends on"/"requires" <expr>
   This defines a dependency for this menu entry. If multiple
   dependencies are defined they are connected with '&&'. Dependencies
@@ -280,3 +285,10 @@ source:
 	"source" <prompt>
 
 This reads the specified configuration file. This file is always parsed.
+
+mainmenu:
+
+	"mainmenu" <prompt>
+
+This sets the config program's title bar if the config program chooses
+to use it.


---
