Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWDEDQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWDEDQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWDEDQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:16:48 -0400
Received: from xenotime.net ([66.160.160.81]:58326 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750934AbWDEDQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:16:47 -0400
Date: Tue, 4 Apr 2006 20:13:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, bart@samwel.tk
Subject: [PATCH] docs: laptop-mode.txt source file build
Message-Id: <20060404201313.909a9357.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix C source file in Doc/laptop-mode.txt to compile.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/laptop-mode.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2617-rc1-docsrc.orig/Documentation/laptop-mode.txt
+++ linux-2617-rc1-docsrc/Documentation/laptop-mode.txt
@@ -919,11 +919,11 @@ int main(int argc, char **argv)
     int settle_time = 60;
 
     /* Parse the simple command-line */
-    if (ac == 2)
-	disk = av[1];
-    else if (ac == 4) {
-	settle_time = atoi(av[2]);
-	disk = av[3];
+    if (argc == 2)
+	disk = argv[1];
+    else if (argc == 4) {
+	settle_time = atoi(argv[2]);
+	disk = argv[3];
     } else
 	usage();
 


---
