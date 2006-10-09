Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWJIDH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWJIDH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWJIDH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:07:29 -0400
Received: from xenotime.net ([66.160.160.81]:29623 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932207AbWJIDH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:07:27 -0400
Date: Sun, 8 Oct 2006 20:08:51 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: drop __must_check and various "inline"
 qualifiers
Message-Id: <20061008200851.47eb99da.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Drop __inline, __always_inline, noinline, and __must_check in the
produced kernel-doc output, similar to other pseudo directives.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    4 ++++
 1 files changed, 4 insertions(+)

--- linux-2619-rc1g3.orig/scripts/kernel-doc
+++ linux-2619-rc1g3/scripts/kernel-doc
@@ -1518,7 +1518,11 @@ sub dump_function($$) {
     $prototype =~ s/^asmlinkage +//;
     $prototype =~ s/^inline +//;
     $prototype =~ s/^__inline__ +//;
+    $prototype =~ s/^__inline +//;
+    $prototype =~ s/^__always_inline +//;
+    $prototype =~ s/^noinline +//;
     $prototype =~ s/__devinit +//;
+    $prototype =~ s/__must_check +//;
     $prototype =~ s/^#define +//; #ak added
     $prototype =~ s/__attribute__ \(\([a-z,]*\)\)//;
 


---
