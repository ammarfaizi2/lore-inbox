Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVKNTiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVKNTiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKNTiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:38:11 -0500
Received: from 81-178-76-253.dsl.pipex.com ([81.178.76.253]:63651 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751241AbVKNTiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:38:10 -0500
Date: Mon, 14 Nov 2005 19:37:40 +0000
To: akpm@osdl.org
Cc: apw@shadowen.org, kravetz@us.ibm.com, haveblue@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] register_memory should be global
Message-ID: <20051114193740.GA15501@shadowen.org>
References: <exportbomb.1131997056@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1131997056@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

register_memory is global and declared so in linux.h.  Update the
HOTPLUG specific definition to match.  This fixes a compile warning
when HOTPLUG is enabled.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 memory.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
diff -upN reference/drivers/base/memory.c current/drivers/base/memory.c
--- reference/drivers/base/memory.c
+++ current/drivers/base/memory.c
@@ -63,8 +63,7 @@ void unregister_memory_notifier(struct n
 /*
  * register_memory - Setup a sysfs device for a memory block
  */
-static int
-register_memory(struct memory_block *memory, struct mem_section *section,
+int register_memory(struct memory_block *memory, struct mem_section *section,
 		struct node *root)
 {
 	int error;
