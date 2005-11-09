Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbVKIAzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbVKIAzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbVKIAzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:55:04 -0500
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:32744 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030482AbVKIAzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:55:02 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Replace kcalloc(1, with kzalloc.
Message-Id: <20051109005427.462A420A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 01:54:27 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace kcalloc(1, ... by kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 kernel/kprobes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 9ca77cd1b92bf258e069b0d08b61a7812ac0c7d8
3cac421d544b4cf6381e1ebe41fcb6d995e4f150
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5beda37..3ae9842 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -420,7 +420,7 @@ static int __kprobes register_aggr_kprob
 		copy_kprobe(old_p, p);
 		ret = add_new_kprobe(old_p, p);
 	} else {
-		ap = kcalloc(1, sizeof(struct kprobe), GFP_ATOMIC);
+		ap = kzalloc(sizeof(struct kprobe), GFP_ATOMIC);
 		if (!ap)
 			return -ENOMEM;
 		add_aggr_kprobe(ap, old_p);
---
0.99.9.GIT
