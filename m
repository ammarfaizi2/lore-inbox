Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269769AbUJSSPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269769AbUJSSPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269774AbUJSQ5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:57:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:47812 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269773AbUJSQim convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:42 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037552948@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:35:58 -0700
Message-Id: <10982037582673@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.55.5, 2004/09/04 01:20:44+02:00, greg@kroah.com

kobject: adjust hotplug_seqnum increment to keep userspace and kernel agreeing.


 lib/kobject.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-10-19 09:23:30 -07:00
+++ b/lib/kobject.c	2004-10-19 09:23:30 -07:00
@@ -178,7 +178,7 @@
 	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
 
 	spin_lock(&sequence_lock);
-	seq = hotplug_seqnum++;
+	seq = ++hotplug_seqnum;
 	spin_unlock(&sequence_lock);
 
 	envp [i++] = scratch;

