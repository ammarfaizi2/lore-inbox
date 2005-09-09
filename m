Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbVIIE5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbVIIE5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 00:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbVIIE5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 00:57:12 -0400
Received: from xenotime.net ([66.160.160.81]:21967 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965253AbVIIE5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 00:57:11 -0400
Date: Thu, 8 Sep 2005 21:56:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: magnade@gmail.com, jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Doc: update oops-tracing.txt (Tainted flags)
Message-Id: <20050908215606.6c31790f.rdunlap@xenotime.net>
In-Reply-To: <20050906183008.GG10632@fieldses.org>
References: <dda83e78050904124454fc675a@mail.gmail.com>
	<dda83e78050904135113b95c4a@mail.gmail.com>
	<20050904215219.GA9812@fieldses.org>
	<dda83e780509042008294fbe26@mail.gmail.com>
	<20050905031825.GA22209@fieldses.org>
	<dda83e78050905134420f06fbf@mail.gmail.com>
	<9a87484905090513481118e67b@mail.gmail.com>
	<dda83e7805090520407aefb4d1@mail.gmail.com>
	<20050906181327.GE10632@fieldses.org>
	<Pine.LNX.4.50.0509061119380.19596-100000@shark.he.net>
	<20050906183008.GG10632@fieldses.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Update Documentation/oops-tracing.txt:
- add descriptions of 3 more "Tainted" flags;
- fix some typos;

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/oops-tracing.txt |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff -Naurp linux-2613-work/Documentation/oops-tracing.txt~doc_taint_update linux-2613-work/Documentation/oops-tracing.txt
--- linux-2613-work/Documentation/oops-tracing.txt~doc_taint_update	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-work/Documentation/oops-tracing.txt	2005-09-08 21:43:02.000000000 -0700
@@ -205,8 +205,8 @@ Phone: 701-234-7556
 Tainted kernels:
 
 Some oops reports contain the string 'Tainted: ' after the program
-counter, this indicates that the kernel has been tainted by some
-mechanism.  The string is followed by a series of position sensitive
+counter. This indicates that the kernel has been tainted by some
+mechanism.  The string is followed by a series of position-sensitive
 characters, each representing a particular tainted value.
 
   1: 'G' if all modules loaded have a GPL or compatible license, 'P' if
@@ -214,16 +214,25 @@ characters, each representing a particul
      MODULE_LICENSE or with a MODULE_LICENSE that is not recognised by
      insmod as GPL compatible are assumed to be proprietary.
 
-  2: 'F' if any module was force loaded by insmod -f, ' ' if all
+  2: 'F' if any module was force loaded by "insmod -f", ' ' if all
      modules were loaded normally.
 
   3: 'S' if the oops occurred on an SMP kernel running on hardware that
-      hasn't been certified as safe to run multiprocessor.
-	  Currently this occurs only on various Athlons that are not
-	  SMP capable.
+     hasn't been certified as safe to run multiprocessor.
+     Currently this occurs only on various Athlons that are not
+     SMP capable.
+
+  4: 'R' if a module was force unloaded by "rmmod -f", ' ' if all
+     modules were unloaded normally.
+
+  5: 'M' if any processor has reported a Machine Check Exception,
+     ' ' if no Machine Check Exceptions have occurred.
+
+  6: 'B' if a page-release function has found a bad page reference or
+     some unexpected page flags.
 
 The primary reason for the 'Tainted: ' string is to tell kernel
 debuggers if this is a clean kernel or if anything unusual has
-occurred.  Tainting is permanent, even if an offending module is
-unloading the tainted value remains to indicate that the kernel is not
+occurred.  Tainting is permanent: even if an offending module is
+unloaded, the tainted value remains to indicate that the kernel is not
 trustworthy.


---
