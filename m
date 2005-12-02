Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVLBTbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVLBTbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVLBTbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:31:05 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:46631 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750841AbVLBTbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:31:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IjlBqoNWPFragkWY4jI2x3OyUhj2QAbAjjflWJMO4rayvlc2oJRFLsf8Ay2A41e7+oWqMfHj4/zvLs7X36ngC4YdovLU6K79pKDyLMixHQXR8eqPuc56YSJYkvujgVrffSdR7PAspJoeXiKr7efteUOrgxTZjE+ZxT1A2JClwYs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Documentation: Small applying-patches.txt update
Date: Fri, 2 Dec 2005 20:31:14 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512022031.14957.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor update to Documentation/applying-patches.txt

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/applying-patches.txt |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

--- linux-2.6.15-rc4-git1-orig/Documentation/applying-patches.txt	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc4-git1/Documentation/applying-patches.txt	2005-12-02 20:26:55.000000000 +0100
@@ -2,7 +2,8 @@
 	Applying Patches To The Linux Kernel
 	------------------------------------
 
-	(Written by Jesper Juhl, August 2005)
+	Original by: Jesper Juhl, August 2005
+	Last update: 2005-12-02
 
 
 
@@ -118,7 +119,7 @@
 
 When patch encounters a change that it can't fix up with fuzz it rejects it
 outright and leaves a file with a .rej extension (a reject file). You can
-read this file to see exactely what change couldn't be applied, so you can
+read this file to see exactly what change couldn't be applied, so you can
 go fix it up by hand if you wish.
 
 If you don't have any third party patches applied to your kernel source, but
@@ -127,7 +128,7 @@
 never see a fuzz or reject message from patch. If you do see such messages
 anyway, then there's a high risk that either your local source tree or the
 patch file is corrupted in some way. In that case you should probably try
-redownloading the patch and if things are still not OK then you'd be advised
+re-downloading the patch and if things are still not OK then you'd be advised
 to start with a fresh tree downloaded in full from kernel.org.
 
 Let's look a bit more at some of the messages patch can produce.
@@ -180,9 +181,11 @@
 
 Are there any alternatives to `patch'?
 ---
- Yes there are alternatives. You can use the `interdiff' program
-(http://cyberelk.net/tim/patchutils/) to generate a patch representing the
-differences between two patches and then apply the result.
+ Yes there are alternatives. 
+
+ You can use the `interdiff' program (http://cyberelk.net/tim/patchutils/) to
+generate a patch representing the differences between two patches and then
+apply the result.
 This will let you move from something like 2.6.12.2 to 2.6.12.3 in a single
 step. The -z flag to interdiff will even let you feed it patches in gzip or
 bzip2 compressed form directly without the use of zcat or bzcat or manual
@@ -197,7 +200,7 @@
  Another alternative is `ketchup', which is a python script for automatic
 downloading and applying of patches (http://www.selenic.com/ketchup/).
 
-Other nice tools are diffstat which shows a summary of changes made by a
+ Other nice tools are diffstat which shows a summary of changes made by a
 patch, lsdiff which displays a short listing of affected files in a patch
 file, along with (optionally) the line numbers of the start of each patch
 and grepdiff which displays a list of the files modified by a patch where
@@ -258,7 +261,7 @@
 					# source dir is now 2.6.11
 $ patch -p1 < ../patch-2.6.12		# apply new 2.6.12 patch
 $ cd ..
-$ mv linux-2.6.11.1 inux-2.6.12		# rename source dir
+$ mv linux-2.6.11.1 linux-2.6.12		# rename source dir
 
 
 The 2.6.x.y kernels
@@ -433,7 +436,11 @@
 $ mv linux-2.6.12-mm1 linux-2.6.13-rc3-mm3	# rename the source dir
 
 
-This concludes this list of explanations of the various kernel trees and I
-hope you are now crystal clear on how to apply the various patches and help
-testing the kernel.
+This concludes this list of explanations of the various kernel trees.
+I hope you are now clear on how to apply the various patches and help testing
+the kernel.
+
+Thank you's to Randy Dunlap, Rolf Eike Beer, Linus Torvalds, Bodo Eggert,
+Johannes Stezenbach, Grant Coady, Pavel Machek and others that I may have
+forgotten for their reviews and contributions to this document.
 



