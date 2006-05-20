Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWETEpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWETEpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWETEpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:45:40 -0400
Received: from xenotime.net ([66.160.160.81]:39131 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751202AbWETEpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:45:34 -0400
Date: Fri, 19 May 2006 21:48:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tali@admingilde.org, akpm <akpm@osdl.org>
Subject: [PATCH 2/2] kernel-doc: script cleanups
Message-Id: <20060519214800.d96e2117.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix indentation.
Quote a brace '{' so that vi won't be fooled by it.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 scripts/kernel-doc |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2617-rc4.orig/scripts/kernel-doc
+++ linux-2617-rc4/scripts/kernel-doc
@@ -1779,7 +1779,7 @@ sub process_file($) {
 		$prototype = "";
 		$state = 3;
 		$brcount = 0;
-#	    print STDERR "end of doc comment, looking for prototype\n";
+#		print STDERR "end of doc comment, looking for prototype\n";
 	    } elsif (/$doc_content/) {
 		# miguel-style comment kludge, look for blank lines after
 		# @parameter line to signify start of description
@@ -1796,7 +1796,7 @@ sub process_file($) {
 		print STDERR "Warning(${file}:$.): bad line: $_";
 		++$warnings;
 	    }
-	} elsif ($state == 3) {	# scanning for function { (end of prototype)
+	} elsif ($state == 3) {	# scanning for function '{' (end of prototype)
 	    if ($decl_type eq 'function') {
 	        process_state3_function($_, $file);
 	    } else {


---
