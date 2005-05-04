Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVEDHW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVEDHW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVEDHOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:14:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:60649 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262064AbVEDHLn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:11:43 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: aoe-stat should work for built-in as well as module
In-Reply-To: <1115190695150@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:11:36 -0700
Message-Id: <11151906962511@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: aoe-stat should work for built-in as well as module

aoe-stat should work for built-in as well as module

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -uprN a/Documentation/aoe/status.sh b/Documentation/aoe/status.sh

---
commit c59a24dc512952cb434b34a66c3792555159fa36
tree 3b13ab42ed88a09f304c1fc87962a82c1f49c098
parent 03c41c434775c52092d17a5031ad8ebaaf555bc4
author Ed L Cashin <ecashin@coraid.com> 1114784653 -0400
committer Greg KH <gregkh@suse.de> 1115188493 -0700

Index: Documentation/aoe/status.sh
===================================================================
--- a2f4e5f5fef46fac69b1e47e31ccbcf7d950b016/Documentation/aoe/status.sh  (mode:100644 sha1:6628116d4a9f7b4da22a8991cf5426c6e92b8d22)
+++ 3b13ab42ed88a09f304c1fc87962a82c1f49c098/Documentation/aoe/status.sh  (mode:100644 sha1:751f3be514b831296b038fd343443c15d0aa5b32)
@@ -14,10 +14,6 @@
 	echo "$me Error: sysfs is not mounted" 1>&2
 	exit 1
 }
-test -z "`lsmod | grep '^aoe'`" && {
-	echo  "$me Error: aoe module is not loaded" 1>&2
-	exit 1
-}
 
 for d in `ls -d $sysd/block/etherd* 2>/dev/null | grep -v p` end; do
 	# maybe ls comes up empty, so we use "end"

