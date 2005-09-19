Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVISVTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVISVTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVISVTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:19:16 -0400
Received: from host-84-9-200-79.bulldogdsl.com ([84.9.200.79]:60806 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932125AbVISVTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:19:15 -0400
Date: Mon, 19 Sep 2005 22:18:55 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: patch-out@fluff.org
Subject: [PATCH] - scripts ignoring Makefile settings
Message-ID: <20050919211855.GA22564@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The namespace.pl script is ignoring both
the Makefile set $OBJDUMP and $NM settings
for cross-compiling. Worse, it assumes that
objdump can be found in /usr/bin.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--- linux-2.6.13-simtec1/scripts/namespace.pl	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.13-simtec2/scripts/namespace.pl	2005-09-19 22:13:21.000000000 +0100
@@ -66,8 +66,8 @@
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
+my $nm = "\$NM -p";
+my $objdump = "\$OBJDUMP -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scripts-namespacecheck-crosscompile.patch"

--- linux-2.6.13-simtec1/scripts/namespace.pl	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.13-simtec2/scripts/namespace.pl	2005-09-19 22:13:21.000000000 +0100
@@ -66,8 +66,8 @@
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
+my $nm = "\$NM -p";
+my $objdump = "\$OBJDUMP -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scripts-namespacecheck-crosscompile.patch"

--- linux-2.6.13-simtec1/scripts/namespace.pl	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.13-simtec2/scripts/namespace.pl	2005-09-19 22:13:21.000000000 +0100
@@ -66,8 +66,8 @@
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
+my $nm = "\$NM -p";
+my $objdump = "\$OBJDUMP -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));

--CE+1k2dSO48ffgeK--
