Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269772AbUJSQ6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269772AbUJSQ6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269773AbUJSQ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:57:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:47300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269772AbUJSQim convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:42 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037712438@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:13 -0700
Message-Id: <10982037731314@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.3.2, 2004/09/14 11:12:09-07:00, akpm@osdl.org

[PATCH] kobject_uevent warning fix

lib/kobject_uevent.c: In function `kobject_hotplug':
lib/kobject_uevent.c:225: warning: long long int format, u64 arg (arg 3)


Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-19 09:22:55 -07:00
+++ b/lib/kobject_uevent.c	2004-10-19 09:22:55 -07:00
@@ -222,7 +222,7 @@
 	spin_unlock(&sequence_lock);
 
 	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SEQNUM=%lld", seq) + 1;
+	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
 
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;

