Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbUKLXED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbUKLXED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUKLXDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:03:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31948 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262659AbUKLXAl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:41 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <11003004072900@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:07 -0800
Message-Id: <1100300407889@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2099, 2004/11/12 11:43:49-08:00, kay.sievers@vrfy.org

[PATCH] print hotplug SEQNUM as unsigned

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-11-12 14:52:56 -08:00
+++ b/lib/kobject_uevent.c	2004-11-12 14:52:56 -08:00
@@ -289,10 +289,10 @@
 	spin_lock(&sequence_lock);
 	seq = ++hotplug_seqnum;
 	spin_unlock(&sequence_lock);
-	sprintf(seq_buff, "SEQNUM=%lld", (long long)seq);
+	sprintf(seq_buff, "SEQNUM=%llu", (unsigned long long)seq);
 
-	pr_debug ("%s: %s %s seq=%lld %s %s %s %s %s\n",
-		  __FUNCTION__, argv[0], argv[1], (long long)seq,
+	pr_debug ("%s: %s %s seq=%llu %s %s %s %s %s\n",
+		  __FUNCTION__, argv[0], argv[1], (unsigned long long)seq,
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 
 	send_uevent(action_string, kobj_path, envp, GFP_KERNEL);

