Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269777AbUJSQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269777AbUJSQzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269793AbUJSQwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:52:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:53444 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269788AbUJSQiq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:46 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037731314@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:15 -0700
Message-Id: <10982037753073@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.3.3, 2004/09/14 11:12:38-07:00, akpm@osdl.org

[PATCH] ksysfs warning fix

kernel/ksysfs.c: In function `hotplug_seqnum_show':
kernel/ksysfs.c:28: warning: long long unsigned int format, u64 arg (arg 3)

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 kernel/ksysfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/kernel/ksysfs.c b/kernel/ksysfs.c
--- a/kernel/ksysfs.c	2004-10-19 09:22:50 -07:00
+++ b/kernel/ksysfs.c	2004-10-19 09:22:50 -07:00
@@ -25,7 +25,7 @@
 #ifdef CONFIG_HOTPLUG
 static ssize_t hotplug_seqnum_show(struct subsystem *subsys, char *page)
 {
-	return sprintf(page, "%llu\n", hotplug_seqnum);
+	return sprintf(page, "%llu\n", (unsigned long long)hotplug_seqnum);
 }
 KERNEL_ATTR_RO(hotplug_seqnum);
 #endif

