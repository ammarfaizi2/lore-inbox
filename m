Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVDFLrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVDFLrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVDFLrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:47:13 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:61375 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262172AbVDFLrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:47:05 -0400
Message-Id: <20050406114654.627959000@faui31y>
References: <20050406114610.287064000@faui31y>
Date: Wed, 06 Apr 2005 13:46:14 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/6] DocBook: use <informalexample> for examples
Content-Disposition: inline; filename=docbook-informal-example.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: use <informalexample> for examples

From: Rich Walker <rw@shadow.org.uk>
Signed-off-by: Martin Waitz <tali@admingilde.org>

 scripts/kernel-doc |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

Index: linux-docbook/scripts/kernel-doc
===================================================================
--- linux-docbook.orig/scripts/kernel-doc	2005-04-06 12:25:14.115702254 +0200
+++ linux-docbook/scripts/kernel-doc	2005-04-06 12:25:17.867134335 +0200
@@ -553,15 +553,20 @@ sub output_section_xml(%) {
     # print out each section
     $lineprefix="   ";
     foreach $section (@{$args{'sectionlist'}}) {
-	print "<refsect1>\n <title>$section</title>\n <para>\n";
+	print "<refsect1>\n";
+	print "<title>$section</title>\n";
 	if ($section =~ m/EXAMPLE/i) {
-	    print "<example><para>\n";
+	    print "<informalexample><programlisting>\n";
+	} else {
+	    print "<para>\n";
 	}
 	output_highlight($args{'sections'}{$section});
 	if ($section =~ m/EXAMPLE/i) {
-	    print "</para></example>\n";
+	    print "</programlisting></example>\n";
+	} else {
+	    print "</para>\n";
 	}
-	print " </para>\n</refsect1>\n";
+	print "</refsect1>\n";
     }
 }
 

--
Martin Waitz
