Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUECOsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUECOsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 10:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUECOsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 10:48:20 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:55814 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263766AbUECOsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 10:48:19 -0400
Date: Mon, 3 May 2004 22:49:56 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
In-Reply-To: <20040430014658.112a6181.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405032248270.4454@donald.themaw.net>
References: <20040430014658.112a6181.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 8,
	IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF, REFERENCES,
	UPPERCASE_25_50, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Found a couple of symbols not exported that were needed by the ext3.ko 
module.

--- linux-2.6.6-rc3-mm1/fs/dquot.c.orig	2004-05-03 21:59:24.000000000 +0800
+++ linux-2.6.6-rc3-mm1/fs/dquot.c	2004-05-03 22:01:19.000000000 +0800
@@ -1761,6 +1761,8 @@
 EXPORT_SYMBOL(vfs_set_dqblk);
 EXPORT_SYMBOL(dquot_commit);
 EXPORT_SYMBOL(dquot_commit_info);
+EXPORT_SYMBOL(dquot_acquire);
+EXPORT_SYMBOL(dquot_release);
 EXPORT_SYMBOL(dquot_mark_dquot_dirty);
 EXPORT_SYMBOL(dquot_initialize);
 EXPORT_SYMBOL(dquot_drop);
