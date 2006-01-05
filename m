Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752117AbWAETPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbWAETPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWAETPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:15:15 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:23190 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752117AbWAETPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:15:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Y5d5ECSe3Q0KjIZkr4s8uuyJc5x4TLkPawNeOprpb9aJ4uy8ZBBNIVM5tMPzAtdtz09xsmnmLU28s0g5YGV5S6F7F24FvM9CZbDytNkpKNb2W/cZg4b8maWrc9avqUUr0rHYMMiEyizCYZoNq+nc+LI2JVrXil0bmdq5HzClzfY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] Docs update: typos, corrections and additions to applying-patches.txt
Date: Thu, 5 Jan 2006 20:15:08 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601052015.08606.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Typos/corrections.

A few extra additions on top of Randy's fixes.


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/applying-patches.txt |   56 +++++++++++++++++++++----------------
 1 files changed, 32 insertions(+), 24 deletions(-)

--- linux-2.6.15-mm1-orig/Documentation/applying-patches.txt	2006-01-05 18:15:25.000000000 +0100
+++ linux-2.6.15-mm1/Documentation/applying-patches.txt	2006-01-05 18:55:12.000000000 +0100
@@ -3,8 +3,7 @@
 	------------------------------------
 
 	Original by: Jesper Juhl, August 2005
-	Last update: 2005-12-02
-
+	Last update: 2006-01-05
 
 
 A frequently asked question on the Linux Kernel Mailing List is how to apply
@@ -77,7 +76,7 @@
 
 If you wish to uncompress the patch file by hand first before applying it
 (what I assume you've done in the examples below), then you simply run
-gunzip or bunzip2 on the file - like this:
+gunzip or bunzip2 on the file -- like this:
 	gunzip patch-x.y.z.gz
 	bunzip2 patch-x.y.z.bz2
 
@@ -95,7 +94,7 @@
 ---
  When patch applies a patch file it attempts to verify the sanity of the
 file in different ways.
-Checking that the file looks like a valid patch file, checking the code
+Checking that the file looks like a valid patch file & checking the code
 around the bits being modified matches the context provided in the patch are
 just two of the basic sanity checks patch does.
 
@@ -122,7 +121,7 @@
 read this file to see exactly what change couldn't be applied, so you can
 go fix it up by hand if you wish.
 
-If you don't have any third party patches applied to your kernel source, but
+If you don't have any third-party patches applied to your kernel source, but
 only patches from kernel.org and you apply the patches in the correct order,
 and have made no modifications yourself to the source files, then you should
 never see a fuzz or reject message from patch. If you do see such messages
@@ -137,7 +136,7 @@
 find a file to be patched. Most likely you forgot to specify -p1 or you are
 in the wrong directory. Less often, you'll find patches that need to be
 applied with -p0 instead of -p1 (reading the patch file should reveal if
-this is the case - if so, then this is an error by the person who created
+this is the case -- if so, then this is an error by the person who created
 the patch but is not fatal).
 
 If you get "Hunk #2 succeeded at 1887 with fuzz 2 (offset 7 lines)." or a
@@ -168,13 +167,17 @@
 
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
 
@@ -200,10 +203,10 @@
  Another alternative is `ketchup', which is a python script for automatic
 downloading and applying of patches (http://www.selenic.com/ketchup/).
 
- Other nice tools are diffstat which shows a summary of changes made by a
-patch, lsdiff which displays a short listing of affected files in a patch
-file, along with (optionally) the line numbers of the start of each patch
-and grepdiff which displays a list of the files modified by a patch where
+ Other nice tools are diffstat, which shows a summary of changes made by a
+patch; lsdiff, which displays a short listing of affected files in a patch
+file, along with (optionally) the line numbers of the start of each patch;
+and grepdiff, which displays a list of the files modified by a patch where
 the patch contains a given regular expression.
 
 
@@ -228,8 +231,8 @@
 In place of ftp.kernel.org you can use ftp.cc.kernel.org, where cc is a
 country code. This way you'll be downloading from a mirror site that's most
 likely geographically closer to you, resulting in faster downloads for you,
-less bandwidth used globally and less load on the main kernel.org servers -
-these are good things, do use mirrors when possible.
+less bandwidth used globally and less load on the main kernel.org servers --
+these are good things, so do use mirrors when possible.
 
 
 The 2.6.x kernels
@@ -237,14 +240,14 @@
  These are the base stable releases released by Linus. The highest numbered
 release is the most recent.
 
-If regressions or other serious flaws are found then a -stable fix patch
+If regressions or other serious flaws are found, then a -stable fix patch
 will be released (see below) on top of this base. Once a new 2.6.x base
 kernel is released, a patch is made available that is a delta between the
 previous 2.6.x kernel and the new one.
 
-To apply a patch moving from 2.6.11 to 2.6.12 you'd do the following (note
+To apply a patch moving from 2.6.11 to 2.6.12, you'd do the following (note
 that such patches do *NOT* apply on top of 2.6.x.y kernels but on top of the
-base 2.6.x kernel - if you need to move from 2.6.x.y to 2.6.x+1 you need to
+base 2.6.x kernel -- if you need to move from 2.6.x.y to 2.6.x+1 you need to
 first revert the 2.6.x.y patch).
 
 Here are some examples:
@@ -266,7 +269,7 @@
 
 The 2.6.x.y kernels
 ---
- Kernels with 4 digit versions are -stable kernels. They contain small(ish)
+ Kernels with 4-digit versions are -stable kernels. They contain small(ish)
 critical fixes for security problems or significant regressions discovered
 in a given 2.6.x kernel.
 
@@ -277,9 +280,14 @@
 If no 2.6.x.y kernel is available, then the highest numbered 2.6.x kernel is
 the current stable kernel.
 
+ note: the -stable team usually do make incremental patches available as well
+ as patches against the latest mainline release, but I only cover the
+ non-incremental ones below. The incremental ones can be found at
+ ftp://ftp.kernel.org/pub/linux/kernel/v2.6/incr/
+
 These patches are not incremental, meaning that for example the 2.6.12.3
 patch does not apply on top of the 2.6.12.2 kernel source, but rather on top
-of the base 2.6.12 kernel source.
+of the base 2.6.12 kernel source .
 So, in order to apply the 2.6.12.3 patch to your existing 2.6.12.2 kernel
 source you have to first back out the 2.6.12.2 patch (so you are left with a
 base 2.6.12 kernel source) and then apply the new 2.6.12.3 patch.
@@ -345,12 +353,12 @@
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
 
@@ -393,12 +401,12 @@
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


