Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVL0F2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVL0F2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVL0F2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:28:09 -0500
Received: from xenotime.net ([66.160.160.81]:48590 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932237AbVL0F2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:28:03 -0500
Date: Mon, 26 Dec 2005 21:28:40 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jesper.juhl@gmail.com
Subject: [PATCH] Doc/applying-patches.txt fixups
Message-Id: <20051226212840.61faddc5.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Typos/corrections.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/applying-patches.txt |   48 +++++++++++++++++++------------------
 1 files changed, 25 insertions(+), 23 deletions(-)

--- linux-2615-rc7.orig/Documentation/applying-patches.txt
+++ linux-2615-rc7/Documentation/applying-patches.txt
@@ -5,7 +5,6 @@
 	(Written by Jesper Juhl, August 2005)
 
 
-
 A frequently asked question on the Linux Kernel Mailing List is how to apply
 a patch to the kernel or, more specifically, what base kernel a patch for
 one of the many trees/branches should be applied to. Hopefully this document
@@ -76,7 +75,7 @@ instead:
 
 If you wish to uncompress the patch file by hand first before applying it
 (what I assume you've done in the examples below), then you simply run
-gunzip or bunzip2 on the file - like this:
+gunzip or bunzip2 on the file -- like this:
 	gunzip patch-x.y.z.gz
 	bunzip2 patch-x.y.z.bz2
 
@@ -94,7 +93,7 @@ Common errors when patching
 ---
  When patch applies a patch file it attempts to verify the sanity of the
 file in different ways.
-Checking that the file looks like a valid patch file, checking the code
+Checking that the file looks like a valid patch file & checking the code
 around the bits being modified matches the context provided in the patch are
 just two of the basic sanity checks patch does.
 
@@ -118,10 +117,10 @@ wrong.
 
 When patch encounters a change that it can't fix up with fuzz it rejects it
 outright and leaves a file with a .rej extension (a reject file). You can
-read this file to see exactely what change couldn't be applied, so you can
+read this file to see exactly what change couldn't be applied, so you can
 go fix it up by hand if you wish.
 
-If you don't have any third party patches applied to your kernel source, but
+If you don't have any third-party patches applied to your kernel source, but
 only patches from kernel.org and you apply the patches in the correct order,
 and have made no modifications yourself to the source files, then you should
 never see a fuzz or reject message from patch. If you do see such messages
@@ -136,7 +135,7 @@ If patch stops and presents a "File to p
 find a file to be patched. Most likely you forgot to specify -p1 or you are
 in the wrong directory. Less often, you'll find patches that need to be
 applied with -p0 instead of -p1 (reading the patch file should reveal if
-this is the case - if so, then this is an error by the person who created
+this is the case -- if so, then this is an error by the person who created
 the patch but is not fatal).
 
 If you get "Hunk #2 succeeded at 1887 with fuzz 2 (offset 7 lines)." or a
@@ -167,13 +166,17 @@ the patch will in fact apply it.
 
 A message similar to "patch: **** unexpected end of file in patch" or "patch
 unexpectedly ends in middle of line" means that patch could make no sense of
-the file you fed to it. Either your download is broken or you tried to feed
-patch a compressed patch file without uncompressing it first.
+the file you fed to it. Either your download is broken, you tried to feed
+patch a compressed patch file without uncompressing it first, or the patch
+file that you are using has been mangled by a mail client or mail transfer
+agent along the way somewhere, e.g., by splitting a long line into two lines.
+Often these warnings can easily be fixed by joining (concatenating) the
+two lines that had been split.
 
 As I already mentioned above, these errors should never happen if you apply
 a patch from kernel.org to the correct version of an unmodified source tree.
 So if you get these errors with kernel.org patches then you should probably
-assume that either your patch file or your tree is broken and I'd advice you
+assume that either your patch file or your tree is broken and I'd advise you
 to start over with a fresh download of a full kernel tree and the patch you
 wish to apply.
 
@@ -197,10 +200,10 @@ do the additional steps since interdiff 
  Another alternative is `ketchup', which is a python script for automatic
 downloading and applying of patches (http://www.selenic.com/ketchup/).
 
-Other nice tools are diffstat which shows a summary of changes made by a
-patch, lsdiff which displays a short listing of affected files in a patch
-file, along with (optionally) the line numbers of the start of each patch
-and grepdiff which displays a list of the files modified by a patch where
+Other nice tools are diffstat, which shows a summary of changes made by a
+patch; lsdiff, which displays a short listing of affected files in a patch
+file, along with (optionally) the line numbers of the start of each patch;
+and grepdiff, which displays a list of the files modified by a patch where
 the patch contains a given regular expression.
 
 
@@ -225,8 +228,8 @@ The -mm kernels live at
 In place of ftp.kernel.org you can use ftp.cc.kernel.org, where cc is a
 country code. This way you'll be downloading from a mirror site that's most
 likely geographically closer to you, resulting in faster downloads for you,
-less bandwidth used globally and less load on the main kernel.org servers -
-these are good things, do use mirrors when possible.
+less bandwidth used globally and less load on the main kernel.org servers --
+these are good things, so do use mirrors when possible.
 
 
 The 2.6.x kernels
@@ -239,9 +242,9 @@ will be released (see below) on top of t
 kernel is released, a patch is made available that is a delta between the
 previous 2.6.x kernel and the new one.
 
-To apply a patch moving from 2.6.11 to 2.6.12 you'd do the following (note
+To apply a patch moving from 2.6.11 to 2.6.12, you'd do the following (note
 that such patches do *NOT* apply on top of 2.6.x.y kernels but on top of the
-base 2.6.x kernel - if you need to move from 2.6.x.y to 2.6.x+1 you need to
+base 2.6.x kernel -- if you need to move from 2.6.x.y to 2.6.x+1 you need to
 first revert the 2.6.x.y patch).
 
 Here are some examples:
@@ -263,7 +266,7 @@ $ mv linux-2.6.11.1 inux-2.6.12		# renam
 
 The 2.6.x.y kernels
 ---
- Kernels with 4 digit versions are -stable kernels. They contain small(ish)
+ Kernels with 4-digit versions are -stable kernels. They contain small(ish)
 critical fixes for security problems or significant regressions discovered
 in a given 2.6.x kernel.
 
@@ -342,12 +345,12 @@ The -git kernels
 repository, hence the name).
 
 These patches are usually released daily and represent the current state of
-Linus' tree. They are more experimental than -rc kernels since they are
+Linus's tree. They are more experimental than -rc kernels since they are
 generated automatically without even a cursory glance to see if they are
 sane.
 
 -git patches are not incremental and apply either to a base 2.6.x kernel or
-a base 2.6.x-rc kernel - you can see which from their name.
+a base 2.6.x-rc kernel -- you can see which from their name.
 A patch named 2.6.12-git1 applies to the 2.6.12 kernel source and a patch
 named 2.6.13-rc3-git2 applies to the source of the 2.6.13-rc3 kernel.
 
@@ -390,12 +393,12 @@ You should generally strive to get your 
 ensure maximum testing.
 
 This branch is in constant flux and contains many experimental features, a
-lot of debugging patches not appropriate for mainline etc and is the most
+lot of debugging patches not appropriate for mainline etc., and is the most
 experimental of the branches described in this document.
 
 These kernels are not appropriate for use on systems that are supposed to be
 stable and they are more risky to run than any of the other branches (make
-sure you have up-to-date backups - that goes for any experimental kernel but
+sure you have up-to-date backups -- that goes for any experimental kernel but
 even more so for -mm kernels).
 
 These kernels in addition to all the other experimental patches they contain
@@ -436,4 +439,3 @@ $ mv linux-2.6.12-mm1 linux-2.6.13-rc3-m
 This concludes this list of explanations of the various kernel trees and I
 hope you are now crystal clear on how to apply the various patches and help
 testing the kernel.
-


---
