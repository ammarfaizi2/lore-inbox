Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756797AbWLCQmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbWLCQmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757083AbWLCQmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:42:54 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:24747 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1756797AbWLCQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:42:54 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 11:38:50 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] mm: Remove worthless comment referring to kzalloc_node().
Message-ID: <Pine.LNX.4.64.0612031137070.4530@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove comment referring to non-existent kzalloc_node() routine.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/mm/allocpercpu.c b/mm/allocpercpu.c
index eaa9abe..9adcf4d 100644
--- a/mm/allocpercpu.c
+++ b/mm/allocpercpu.c
@@ -55,7 +55,6 @@ void *percpu_populate(void *__pdata, siz

 	BUG_ON(pdata->ptrs[cpu]);
 	if (node_online(node)) {
-		/* FIXME: kzalloc_node(size, gfp, node) */
 		pdata->ptrs[cpu] = kmalloc_node(size, gfp, node);
 		if (pdata->ptrs[cpu])
 			memset(pdata->ptrs[cpu], 0, size);
