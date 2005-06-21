Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVFUEtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVFUEtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFUEqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 00:46:50 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:43166 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261746AbVFUCJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:09:16 -0400
Date: Mon, 20 Jun 2005 19:09:11 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] Doc/Submitting: corrections, additions
Message-Id: <20050620190911.26456151.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Corrections to Documentation/Submitting{Drivers,Patches}
- update LANANA info.
- fix some typos
- update 2.2 kernel maintainer info.
- update 'dontdiff' info.
- update URLs for patch scripts
- add Trivial Patch Monkey URL
- add more references for submitting patches

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 Documentation/SubmittingDrivers |   14 +++++++-----
 Documentation/SubmittingPatches |   44 ++++++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff -Naurp linux-2612/Documentation/SubmittingDrivers~doc-submit linux-2612/Documentation/SubmittingDrivers
--- linux-2612/Documentation/SubmittingDrivers~doc-submit	2005-06-17 12:48:29.000000000 -0700
+++ linux-2612/Documentation/SubmittingDrivers	2005-06-20 17:23:06.000000000 -0700
@@ -13,13 +13,14 @@ Allocating Device Numbers
 -------------------------
 
 Major and minor numbers for block and character devices are allocated
-by the Linux assigned name and number authority (currently better
-known as H Peter Anvin). The site is http://www.lanana.org/. This
+by the Linux assigned name and number authority (currently this is
+Torben Mathiasen). The site is http://www.lanana.org/. This
 also deals with allocating numbers for devices that are not going to
 be submitted to the mainstream kernel.
+See Documentation/devices.txt for more information on this.
 
-If you don't use assigned numbers then when you device is submitted it will
-get given an assigned number even if that is different from values you may
+If you don't use assigned numbers then when your device is submitted it will
+be given an assigned number even if that is different from values you may
 have shipped to customers before.
 
 Who To Submit Drivers To
@@ -32,7 +33,8 @@ Linux 2.2:
 	If the code area has a general maintainer then please submit it to
 	the maintainer listed in MAINTAINERS in the kernel file. If the
 	maintainer does not respond or you cannot find the appropriate
-	maintainer then please contact Alan Cox <alan@lxorguk.ukuu.org.uk>
+	maintainer then please contact the 2.2 kernel maintainer:
+	Marc-Christian Petersen <m.c.p@wolk-project.de>.
 
 Linux 2.4:
 	The same rules apply as 2.2. The final contact point for Linux 2.4
@@ -48,7 +50,7 @@ What Criteria Determine Acceptance
 
 Licensing:	The code must be released to us under the
 		GNU General Public License. We don't insist on any kind
-		of exclusively GPL licensing, and if you wish the driver
+		of exclusive GPL licensing, and if you wish the driver
 		to be useful to other communities such as BSD you may well
 		wish to release under multiple licenses.
 
diff -Naurp linux-2612/Documentation/SubmittingPatches~doc-submit linux-2612/Documentation/SubmittingPatches
--- linux-2612/Documentation/SubmittingPatches~doc-submit	2005-06-17 12:48:29.000000000 -0700
+++ linux-2612/Documentation/SubmittingPatches	2005-06-20 18:29:48.000000000 -0700
@@ -35,7 +35,7 @@ not in any lower subdirectory.
 
 To create a patch for a single file, it is often sufficient to do:
 
-	SRCTREE= linux-2.4
+	SRCTREE= linux-2.6
 	MYFILE=  drivers/net/mydriver.c
 
 	cd $SRCTREE
@@ -48,17 +48,18 @@ To create a patch for multiple files, yo
 or unmodified kernel source tree, and generate a diff against your
 own source tree.  For example:
 
-	MYSRC= /devel/linux-2.4
+	MYSRC= /devel/linux-2.6
 
-	tar xvfz linux-2.4.0-test11.tar.gz
-	mv linux linux-vanilla
-	wget http://www.moses.uklinux.net/patches/dontdiff
-	diff -uprN -X dontdiff linux-vanilla $MYSRC > /tmp/patch
-	rm -f dontdiff
+	tar xvfz linux-2.6.12.tar.gz
+	mv linux-2.6.12 linux-2.6.12-vanilla
+	diff -uprN -X linux-2.6.12-vanilla/Documentation/dontdiff \
+		linux-2.6.12-vanilla $MYSRC > /tmp/patch
 
 "dontdiff" is a list of files which are generated by the kernel during
 the build process, and should be ignored in any diff(1)-generated
-patch.  dontdiff is maintained by Tigran Aivazian <tigran@veritas.com>
+patch.  The "dontdiff" file is included in the kernel tree in
+2.6.12 and later.  For earlier kernel versions, you can get it
+from <http://www.xenotime.net/linux/doc/dontdiff>.
 
 Make sure your patch does not include any extra files which do not
 belong in a patch submission.  Make sure to review your patch -after-
@@ -66,18 +67,20 @@ generated it with diff(1), to ensure acc
 
 If your changes produce a lot of deltas, you may want to look into
 splitting them into individual patches which modify things in
-logical stages, this will facilitate easier reviewing by other
+logical stages.  This will facilitate easier reviewing by other
 kernel developers, very important if you want your patch accepted.
-There are a number of scripts which can aid in this;
+There are a number of scripts which can aid in this:
 
 Quilt:
 http://savannah.nongnu.org/projects/quilt
 
 Randy Dunlap's patch scripts:
-http://developer.osdl.org/rddunlap/scripts/patching-scripts.tgz
+http://www.xenotime.net/linux/scripts/patching-scripts-002.tar.gz
 
 Andrew Morton's patch scripts:
-http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.16
+http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.20
+
+
 
 2) Describe your changes.
 
@@ -110,6 +113,7 @@ complete, that is OK.  Simply note "this
 in your patch description.
 
 
+
 4) Select e-mail destination.
 
 Look through the MAINTAINERS file and the source code, and determine
@@ -146,6 +150,7 @@ patches. Trivial patches must qualify fo
  since people copy, as long as it's trivial)
  Any fix by the author/maintainer of the file. (ie. patch monkey
  in re-transmission mode)
+URL: <http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/>
 
 
 
@@ -306,6 +311,17 @@ now, but you can do this to mark interna
 point out some special detail about the sign-off. 
 
 
+
+12) More references for submitting patches
+
+Andrew Morton, "The perfect patch" (tpp).
+  <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>
+
+Jeff Garzik, "Linux kernel patch submission format."
+  <http://linux.yyz.us/patch-format.html>
+
+
+
 -----------------------------------
 SECTION 2 - HINTS, TIPS, AND TRICKS
 -----------------------------------
@@ -374,7 +390,5 @@ and 'extern __inline__'.
 4) Don't over-design.
 
 Don't try to anticipate nebulous future cases which may or may not
-be useful:  "Make it as simple as you can, and no simpler"
-
-
+be useful:  "Make it as simple as you can, and no simpler."
 


---
