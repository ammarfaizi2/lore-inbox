Return-Path: <linux-kernel-owner+w=401wt.eu-S1762268AbWLJRJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762268AbWLJRJs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762270AbWLJRJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:09:48 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:11534 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762268AbWLJRJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:09:47 -0500
Message-Id: <20061210170856.756504000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 10 Dec 2006 09:08:56 -0800
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] remove likely profiling int cast
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some wrong casting from unsigned int to int. Reported by Andreas Mohr.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 lib/likely_prof.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18/lib/likely_prof.c
===================================================================
--- linux-2.6.18.orig/lib/likely_prof.c
+++ linux-2.6.18/lib/likely_prof.c
@@ -86,8 +86,8 @@ static void *lp_seq_next(struct seq_file
 static int lp_seq_show(struct seq_file *out, void *p)
 {
 	struct likeliness *entry = p;
-	int true = entry->count[1];
-	int false = entry->count[0];
+	unsigned int true = entry->count[1];
+	unsigned int false = entry->count[0];
 
 	if (!entry->type) {
 		if (true > false)
--
