Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269700AbUJVGb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269700AbUJVGb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269851AbUJSQyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:54:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:51652 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269780AbUJSQio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:44 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <1098203761440@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:03 -0700
Message-Id: <10982037633428@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.55.7, 2004/09/05 00:59:19+02:00, greg@kroah.com

kobject: fix build error if CONFIG_HOTPLUG is not enabled.

Thanks to Kay Sievers for pointing this out.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-10-19 09:23:20 -07:00
+++ b/lib/kobject.c	2004-10-19 09:23:20 -07:00
@@ -118,11 +118,11 @@
 	return path;
 }
 
+unsigned long hotplug_seqnum;
 #ifdef CONFIG_HOTPLUG
 
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
-unsigned long hotplug_seqnum;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 
 static void kset_hotplug(const char *action, struct kset *kset,

