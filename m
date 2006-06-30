Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932982AbWF3SCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbWF3SCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932984AbWF3SCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:02:12 -0400
Received: from xenotime.net ([66.160.160.81]:50922 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932982AbWF3SCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:02:10 -0400
Date: Fri, 30 Jun 2006 11:04:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tali@admingilde.org
Subject: [PATCH] kernel-doc: make man/text mode function output same
Message-Id: <20060630110452.e11d6f04.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Make output of function descriptions in text mode match contents
of 'man' mode by adding Name: plus function-short-description ("purpose")
and changing Function: to Synopsis:.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2617-g13.orig/scripts/kernel-doc
+++ linux-2617-g13/scripts/kernel-doc
@@ -1118,7 +1118,10 @@ sub output_function_text(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
 
-    print "Function:\n\n";
+    print "Name:\n\n";
+    print $args{'function'}." - ".$args{'purpose'}."\n";
+
+    print "\nSynopsis:\n\n";
     my $start=$args{'functiontype'}." ".$args{'function'}." (";
     print $start;
     my $count = 0;


---
