Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUJVXSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUJVXSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJVXRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:17:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:15523 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268455AbUJVXKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:13 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <1098486572164@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 22 Oct 2004 16:09:32 -0700
Message-Id: <10984865723197@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2022, 2004/10/22 14:30:22-07:00, akpm@osdl.org

[PATCH] kobject_uevent warning fix

lib/kobject_uevent.c:39: warning: `action_to_string' defined but not used

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-22 15:59:42 -07:00
+++ b/lib/kobject_uevent.c	2004-10-22 15:59:42 -07:00
@@ -23,6 +23,7 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
+#if defined(CONFIG_KOBJECT_UEVENT) || defined(CONFIG_HOTPLUG)
 static char *action_to_string(enum kobject_action action)
 {
 	switch (action) {
@@ -42,6 +43,7 @@
 		return NULL;
 	}
 }
+#endif
 
 #ifdef CONFIG_KOBJECT_UEVENT
 static struct sock *uevent_sock;

