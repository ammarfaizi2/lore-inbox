Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUBEHYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 02:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUBEHYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 02:24:05 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:30348 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S264137AbUBEHYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 02:24:02 -0500
To: torvalds@osdl.org
Subject: [PATCH 2.6.2] Documentation/SubmittingPatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <20040205072303.BCF79FA5F1@mrhankey.megahappy.net>
Date: Wed,  4 Feb 2004 23:23:03 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to get my feet wet by submitting trivial patchs to various maintainers and the responses have been, "your not submiting you patches correctly". It seems most developers/maintainers want a diff done like this:

cd /source-tree
diff -u linux-2.6.2/FileToPatch.orig linux-2.6.2/FileToPatch

instead of the "SubmitingPatches" document way:
cd /source-tree/linux-2.6.2
diff -u FileToPatch.orig FileToPatch

It would be _great_ if the Documentation was more accurate to the taste of developers/maintainers...

If the SubmittingPatches document is correct, then just toss this patch out because this won't be submitted right... ;)

--- linux-2.6.2/Documentation/SubmittingPatches.orig    2004-02-04 22:57:55.818563016 -0800
+++ linux-2.6.2/Documentation/SubmittingPatches 2004-02-04 23:01:28.799185040 -0800
@@ -33,13 +33,15 @@
                                                                                                                                    
 To create a patch for a single file, it is often sufficient to do:
                                                                                                                                    
-       SRCTREE= /devel/linux-2.4
+       SRCTREE= /devel/
+       SRCDIR= linux-2.4
        MYFILE=  drivers/net/mydriver.c
                                                                                                                                    
-       cd $SRCTREE
+       cd $SRCTREE/$SRCDIR
        cp $MYFILE $MYFILE.orig
        vi $MYFILE      # make your change
-       diff -u $MYFILE.orig $MYFILE > /tmp/patch
+       cd $SRCTREE
+       diff -u $SRCDIR/$MYFILE.orig $SRCDIR/$MYFILE > /tmp/patch
                                                                                                                                    
 To create a patch for multiple files, you should unpack a "vanilla",
 or unmodified kernel source tree, and generate a diff against your


-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
