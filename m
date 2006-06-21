Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWFUTtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWFUTtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWFUTtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:49:20 -0400
Received: from ns.suse.de ([195.135.220.2]:56752 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030234AbWFUTtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:10 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/22] [PATCH] kobject: make people pay attention to kobject_add errors
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:44 -0700
Message-Id: <11509191652021-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <20060621194511.GA23982@kroah.com>
References: <20060621194511.GA23982@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

These really need to be fixed, shout it out to the world.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 lib/kobject.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 687ab41..8e7c719 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -198,14 +198,14 @@ int kobject_add(struct kobject * kobj)
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			pr_debug("kobject_add failed for %s with -EEXIST, "
+			printk("kobject_add failed for %s with -EEXIST, "
 			       "don't try to register things with the "
 			       "same name in the same directory.\n",
 			       kobject_name(kobj));
 		else
-			pr_debug("kobject_add failed for %s (%d)\n",
+			printk("kobject_add failed for %s (%d)\n",
 			       kobject_name(kobj), error);
-		/* dump_stack(); */
+		 dump_stack();
 	}
 
 	return error;
-- 
1.4.0

