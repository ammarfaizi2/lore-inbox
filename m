Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272578AbTG1AeI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272577AbTG1AEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272719AbTG0W6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:15 -0400
Date: Sun, 27 Jul 2003 21:26:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272026.h6RKQ1Eo029822@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix posix compliance for mkcompile_h script
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/scripts/mkcompile_h linux-2.6.0-test2-ac1/scripts/mkcompile_h
--- linux-2.6.0-test2/scripts/mkcompile_h	2003-07-10 21:15:45.000000000 +0100
+++ linux-2.6.0-test2-ac1/scripts/mkcompile_h	2003-07-15 17:24:40.000000000 +0100
@@ -54,7 +54,7 @@
     echo \#define LINUX_COMPILE_DOMAIN
   fi
 
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -1`\"
+  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -n 1`\"
 ) > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,
