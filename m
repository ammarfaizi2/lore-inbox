Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270586AbTGNMdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270617AbTGNMcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:32:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50564
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270583AbTGNMRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:17:04 -0400
Date: Mon, 14 Jul 2003 13:30:57 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141230.h6ECUvx9030962@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: use the right function in reiserfs (resend #3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#ra1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/fs/reiserfs/prints.c linux.22-pre5-ac1/fs/reiserfs/prints.c
--- linux.22-pre5/fs/reiserfs/prints.c	2003-07-14 12:27:42.000000000 +0100
+++ linux.22-pre5-ac1/fs/reiserfs/prints.c	2003-07-06 14:06:59.000000000 +0100
@@ -159,7 +159,7 @@
 
   *skip = 0;
   
-  while ((k = strstr (k, "%")) != NULL)
+  while ((k = strchr (k, '%')) != NULL)
   {
     if (k[1] == 'k' || k[1] == 'K' || k[1] == 'h' || k[1] == 't' ||
 	      k[1] == 'z' || k[1] == 'b' || k[1] == 'y' || k[1] == 'a' ) {
