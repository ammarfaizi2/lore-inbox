Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWAaBAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWAaBAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 20:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWAaBAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 20:00:48 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:54180
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S964976AbWAaBAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 20:00:48 -0500
Date: Tue, 31 Jan 2006 03:00:43 +0200
From: Baruch Even <baruch@ev-en.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] rcu: undeclared variable used in documentation
Message-ID: <20060131010043.GA17021@ev-en.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The RCU documentation uses an fp variable which is not declared in the code
snippets. Use the new_fp variable instead.

Signed-Off-By: Baruch Even <baruch@ev-en.org>
---

 Documentation/RCU/whatisRCU.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: htcp-abc/Documentation/RCU/whatisRCU.txt
===================================================================
--- htcp-abc.orig/Documentation/RCU/whatisRCU.txt
+++ htcp-abc/Documentation/RCU/whatisRCU.txt
@@ -357,7 +357,7 @@ uses of RCU may be found in listRCU.txt,
 		struct foo *new_fp;
 		struct foo *old_fp;
 
-		new_fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
 		spin_lock(&foo_mutex);
 		old_fp = gbl_foo;
 		*new_fp = *old_fp;
@@ -456,7 +456,7 @@ The foo_update_a() function might then b
 		struct foo *new_fp;
 		struct foo *old_fp;
 
-		new_fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
 		spin_lock(&foo_mutex);
 		old_fp = gbl_foo;
 		*new_fp = *old_fp;
