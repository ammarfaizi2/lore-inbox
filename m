Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVKNTid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVKNTid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKNTid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:38:33 -0500
Received: from 81-178-76-253.dsl.pipex.com ([81.178.76.253]:64931 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751261AbVKNTiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:38:17 -0500
Date: Mon, 14 Nov 2005 19:37:41 +0000
To: akpm@osdl.org
Cc: apw@shadowen.org, kravetz@us.ibm.com, haveblue@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] memory_hotplug_name should be const
Message-ID: <20051114193741.GA15508@shadowen.org>
References: <exportbomb.1131997056@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1131997056@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug ops name entry for memory (memory_hotplug_name) should
be const.  This fixes a compiler warning when HOTPLUG is enabled.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff -upN reference/drivers/base/memory.c current/drivers/base/memory.c
--- reference/drivers/base/memory.c
+++ current/drivers/base/memory.c
@@ -30,7 +30,7 @@ static struct sysdev_class memory_sysdev
 };
 EXPORT_SYMBOL(memory_sysdev_class);
 
-static char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	return MEMORY_CLASS_NAME;
 }
