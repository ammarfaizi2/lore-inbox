Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSGXVUv>; Wed, 24 Jul 2002 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSGXVUv>; Wed, 24 Jul 2002 17:20:51 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:29200 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317570AbSGXVUv>;
	Wed, 24 Jul 2002 17:20:51 -0400
Date: Wed, 24 Jul 2002 23:31:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: Improved support for man-page generation [2/9]
Message-ID: <20020724233116.A12782@mars.ravnborg.org>
References: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724232021.A12622@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jul 24, 2002 at 11:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.432   -> 1.433  
#	  scripts/kernel-doc	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.433
# [PATCH] kernel-doc: Improved support for man-page generation [2/9]
# Forward port from 2.4, originally by Christoph Hellwig 
# --------------------------------------------
#
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Wed Jul 24 23:25:47 2002
+++ b/scripts/kernel-doc	Wed Jul 24 23:25:47 2002
@@ -870,7 +870,7 @@
     my ($parameter, $section);
     my $count;
 
-    print ".TH \"$args{'module'}\" 9 \"$args{'function'}\" \"$man_date\" \"API Manual\" LINUX\n";
+    print ".TH \"$args{'function'}\" 9 \"$args{'function'}\" \"$man_date\" \"Kernel Hacker's Manual\" LINUX\n";
 
     print ".SH NAME\n";
     print $args{'function'}." \\- ".$args{'purpose'}."\n";
@@ -896,13 +896,13 @@
 	$parenth = "";
     }
 
-    print ".SH Arguments\n";
+    print ".SH ARGUMENTS\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
 	print ".IP \"".$parameter."\" 12\n";
 	output_highlight($args{'parameterdescs'}{$parameter});
     }
     foreach $section (@{$args{'sectionlist'}}) {
-	print ".SH \"$section\"\n";
+	print ".SH \"", uc $section, "\"\n";
 	output_highlight($args{'sections'}{$section});
     }
 }
