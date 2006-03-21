Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWCUQbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWCUQbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWCUQan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28684 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030301AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Brian Gerst <bgerst@didntduck.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 15/46] kbuild: remove checkconfig.pl
In-Reply-To: <11429580551613-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <1142958055225-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

checkconfig.pl is no longer needed now that autoconf.h is automatically
included.  Remove it and all references to it.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/smart-config.txt          |    4 --
 drivers/video/matrox/matroxfb_DAC1064.c |    1 
 drivers/video/matrox/matroxfb_DAC1064.h |    1 
 drivers/video/matrox/matroxfb_Ti3026.c  |    1 
 drivers/video/matrox/matroxfb_Ti3026.h  |    1 
 drivers/video/matrox/matroxfb_base.c    |    1 
 drivers/video/matrox/matroxfb_misc.c    |    1 
 scripts/checkconfig.pl                  |   65 -------------------------------
 8 files changed, 0 insertions(+), 75 deletions(-)
 delete mode 100755 scripts/checkconfig.pl

18a43ba26dcbe2a7a51011c9daae37adc7fc5c93
diff --git a/Documentation/smart-config.txt b/Documentation/smart-config.txt
index c9bed4c..8467447 100644
--- a/Documentation/smart-config.txt
+++ b/Documentation/smart-config.txt
@@ -56,10 +56,6 @@ Here is the solution:
     writing one file per option.  It updates only the files for options
     that have changed.
 
-    mkdep.c no longer generates warning messages for missing or unneeded
-    <linux/config.h> lines.  The new top-level target 'make checkconfig'
-    checks for these problems.
-
 Flag Dependencies
 
     Martin Von Loewis contributed another feature to this patch:
diff --git a/drivers/video/matrox/matroxfb_DAC1064.c b/drivers/video/matrox/matroxfb_DAC1064.c
index 0fbd9b5..a456e67 100644
--- a/drivers/video/matrox/matroxfb_DAC1064.c
+++ b/drivers/video/matrox/matroxfb_DAC1064.c
@@ -12,7 +12,6 @@
  *
  */
 
-/* make checkconfig does not walk through include tree :-( */
 #include <linux/config.h>
 
 #include "matroxfb_DAC1064.h"
diff --git a/drivers/video/matrox/matroxfb_DAC1064.h b/drivers/video/matrox/matroxfb_DAC1064.h
index a6a4701..2e7238a 100644
--- a/drivers/video/matrox/matroxfb_DAC1064.h
+++ b/drivers/video/matrox/matroxfb_DAC1064.h
@@ -1,7 +1,6 @@
 #ifndef __MATROXFB_DAC1064_H__
 #define __MATROXFB_DAC1064_H__
 
-/* make checkconfig does not walk through include tree */
 #include <linux/config.h>
 
 #include "matroxfb_base.h"
diff --git a/drivers/video/matrox/matroxfb_Ti3026.c b/drivers/video/matrox/matroxfb_Ti3026.c
index 537ade5..23ebad0 100644
--- a/drivers/video/matrox/matroxfb_Ti3026.c
+++ b/drivers/video/matrox/matroxfb_Ti3026.c
@@ -78,7 +78,6 @@
  *
  */
 
-/* make checkconfig does not verify included files... */
 #include <linux/config.h>
 
 #include "matroxfb_Ti3026.h"
diff --git a/drivers/video/matrox/matroxfb_Ti3026.h b/drivers/video/matrox/matroxfb_Ti3026.h
index 541933d..536e5f6 100644
--- a/drivers/video/matrox/matroxfb_Ti3026.h
+++ b/drivers/video/matrox/matroxfb_Ti3026.h
@@ -1,7 +1,6 @@
 #ifndef __MATROXFB_TI3026_H__
 #define __MATROXFB_TI3026_H__
 
-/* make checkconfig does not walk through whole include tree */
 #include <linux/config.h>
 
 #include "matroxfb_base.h"
diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 4055ff6..951c997 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -99,7 +99,6 @@
  *
  */
 
-/* make checkconfig does not check included files... */
 #include <linux/config.h>
 #include <linux/version.h>
 
diff --git a/drivers/video/matrox/matroxfb_misc.c b/drivers/video/matrox/matroxfb_misc.c
index 455a46c..263d801 100644
--- a/drivers/video/matrox/matroxfb_misc.c
+++ b/drivers/video/matrox/matroxfb_misc.c
@@ -84,7 +84,6 @@
  *
  */
 
-/* make checkconfig does not check includes for this... */
 #include <linux/config.h>
 
 #include "matroxfb_misc.h"
diff --git a/scripts/checkconfig.pl b/scripts/checkconfig.pl
deleted file mode 100755
index ca1f231..0000000
--- a/scripts/checkconfig.pl
+++ /dev/null
@@ -1,65 +0,0 @@
-#! /usr/bin/perl
-#
-# checkconfig: find uses of CONFIG_* names without matching definitions.
-# Copyright abandoned, 1998, Michael Elizabeth Chastain <mailto:mec@shout.net>.
-
-use integer;
-
-$| = 1;
-
-foreach $file (@ARGV)
-{
-    # Open this file.
-    open(FILE, $file) || die "Can't open $file: $!\n";
-
-    # Initialize variables.
-    my $fInComment   = 0;
-    my $fInString    = 0;
-    my $fUseConfig   = 0;
-    my $iLinuxConfig = 0;
-    my %configList   = ();
-
-    LINE: while ( <FILE> )
-    {
-	# Strip comments.
-	$fInComment && (s+^.*?\*/+ +o ? ($fInComment = 0) : next);
-	m+/\*+o && (s+/\*.*?\*/+ +go, (s+/\*.*$+ +o && ($fInComment = 1)));
-
-	# Pick up definitions.
-	if ( m/^\s*#/o )
-	{
-	    $iLinuxConfig      = $. if m/^\s*#\s*include\s*"linux\/config\.h"/o;
-	    $configList{uc $1} = 1  if m/^\s*#\s*include\s*"config\/(\S*)\.h"/o;
-	}
-
-	# Strip strings.
-	$fInString && (s+^.*?"+ +o ? ($fInString = 0) : next);
-	m+"+o && (s+".*?"+ +go, (s+".*$+ +o && ($fInString = 1)));
-
-	# Pick up definitions.
-	if ( m/^\s*#/o )
-	{
-	    $iLinuxConfig      = $. if m/^\s*#\s*include\s*<linux\/config\.h>/o;
-	    $configList{uc $1} = 1  if m/^\s*#\s*include\s*<config\/(\S*)\.h>/o;
-	    $configList{$1}    = 1  if m/^\s*#\s*define\s+CONFIG_(\w*)/o;
-	    $configList{$1}    = 1  if m/^\s*#\s*undef\s+CONFIG_(\w*)/o;
-	}
-
-	# Look for usages.
-	next unless m/CONFIG_/o;
-	WORD: while ( m/\bCONFIG_(\w+)/og )
-	{
-	    $fUseConfig = 1;
-	    last LINE if $iLinuxConfig;
-	    next WORD if exists $configList{$1};
-	    print "$file: $.: need CONFIG_$1.\n";
-	    $configList{$1} = 0;
-	}
-    }
-
-    # Report superfluous includes.
-    if ( $iLinuxConfig && ! $fUseConfig )
-	{ print "$file: $iLinuxConfig: linux/config.h not needed.\n"; }
-
-    close(FILE);
-}
-- 
1.0.GIT


