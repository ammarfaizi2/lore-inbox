Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266108AbUFEAhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbUFEAhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUFEAhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:37:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:35024 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266108AbUFEAhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:37:14 -0400
Date: Sat, 5 Jun 2004 02:36:36 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Proposed change to Documentation/CodingStyle regarding
 newline at end of file
Message-ID: <Pine.LNX.4.56.0406050232220.17646@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Having found a few files in the source that did not end in a newline
(patches for those submitted earlier) I thought it might be good to add a
small bit to Documentation/CodingStyle telling people to please ensure
their files end in newline.

Here's a patch with the Change I propose, comments are welcome. Btw, I
could not find any maintainer listed for this document, so I just send
this to linux-kernel - if someone specific should be send the patch please
inform me.


--- linux-2.6.7-rc2/Documentation/CodingStyle-orig	2004-06-05 02:25:45.000000000 +0200
+++ linux-2.6.7-rc2/Documentation/CodingStyle	2004-06-05 02:32:21.000000000 +0200
@@ -47,7 +47,7 @@
 Get a decent editor and don't leave whitespace at the end of lines.


-		Chapter 2: Breaking long lines and strings
+		Chapter 2: Breaking long lines and strings and NL at EOF

 Coding style is all about readability and maintainability using commonly
 available tools.
@@ -69,6 +69,12 @@
 		next_statement;
 }

+Please also make sure that your files have a newline at the end of the file.
+Files that do not end in a newline are not as friendly to tools such grep,
+cat, sed and various others. A missing newline will also needlessly cause
+gcc to emit a warning message for your file.
+
+
 		Chapter 3: Placing Braces

 The other issue that always comes up in C styling is the placement of
@@ -220,6 +226,7 @@
 	return result;
 }

+
 		Chapter 7: Commenting

 Comments are good, but there is also a danger of over-commenting.  NEVER
@@ -428,4 +435,4 @@
 language C, URL: http://std.dkuug.dk/JTC1/SC22/WG14/

 --
-Last updated on 16 February 2004 by a community effort on LKML.
+Last updated on 05 June 2004 by a community effort on LKML.


--
Jesper Juhl <juhl-lkml@dif.dk>
