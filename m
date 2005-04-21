Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVDUSxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVDUSxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVDUSxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:53:41 -0400
Received: from shim1.irt.drexel.edu ([144.118.29.71]:49402 "EHLO
	shim1.irt.drexel.edu") by vger.kernel.org with ESMTP
	id S261762AbVDUSvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:51:14 -0400
Date: Thu, 21 Apr 2005 14:51:09 -0400
From: Cosmin Nicolaescu <cos@camelot.homelinux.com>
Subject: [PATCH 2.6.11] Documentation: correct minor mistake and   remove
 redundant info from SubmittingPatches
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Message-id: <20050421185109.4004.qmail@camelot.homelinux.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first fix is to reverse the order of the files being diffed. Since
we make the change in $MYFILE (and not $MYFILE.orig}, the diff should
have the .orig file first followed by $MYFILE (which has been
modified).

The second modification is to remove redundant text. The information
about the Trivial Patch Monkey is both in steps 4 and 5. Since trivial
should be CCed, the information should only go in step 5 (Select your
CC list) and be removed from step 4 (Select e-mail destination).

--- linux-2.6.11/Documentation/SubmittingPatches        2005-04-21 14:22:22.242714051 -0400
+++ linux-2.6.11/Documentation/SubmittingPatches.orig   2005-04-21 14:17:07.375698154 -0400
@@ -42,7 +42,7 @@ To create a patch for a single file, it 
        cp $MYFILE $MYFILE.orig
        vi $MYFILE      # make your change
        cd ..
-       diff -up $SRCTREE/$MYFILE{,.orig} > /tmp/patch
+       diff -up $SRCTREE/$MYFILE{.orig,} > /tmp/patch
 
 To create a patch for multiple files, you should unpack a "vanilla",
 or unmodified kernel source tree, and generate a diff against your
@@ -132,6 +132,21 @@ which require discussion or do not have 
 usually be sent first to linux-kernel.  Only after the patch is
 discussed should the patch then be submitted to Linus.
 
+For small patches you may want to CC the Trivial Patch Monkey
+trivial@rustcorp.com.au set up by Rusty Russell; which collects "trivial"
+patches. Trivial patches must qualify for one of the following rules:
+ Spelling fixes in documentation
+ Spelling fixes which could break grep(1).
+ Warning fixes (cluttering with useless warnings is bad)
+ Compilation fixes (only if they are actually correct)
+ Runtime fixes (only if they actually fix things)
+ Removing use of deprecated functions/macros (eg. check_region).
+ Contact detail and documentation fixes
+ Non-portable code replaced by portable code (even in arch-specific,
+ since people copy, as long as it's trivial)
+ Any fix by the author/maintainer of the file. (ie. patch monkey
+ in re-transmission mode)
+
 
 
 5) Select your CC (e-mail carbon copy) list.

Signed-off-by: Cosmin Nicolaescu <cos@camelot.homelinux.com>
