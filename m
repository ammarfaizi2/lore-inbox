Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTG2B6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 21:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTG2B6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 21:58:01 -0400
Received: from www.13thfloor.at ([212.16.59.250]:43936 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S264067AbTG2B57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 21:57:59 -0400
Date: Tue, 29 Jul 2003 03:58:07 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Jan Kara <jack@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 quota
Message-ID: <20030729015807.GA13770@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Jan Kara <jack@ucw.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Honza!

maybe this is already fixed somewhere, but
here it is anyway ...


diff -NurP --minimal linux-2.6.0-test2/include/linux/quota.h linux-2.6.0-test2-qfix/include/linux/quota.h
--- linux-2.6.0-test2/include/linux/quota.h	2003-07-14 05:36:38.000000000 +0200
+++ linux-2.6.0-test2-qfix/include/linux/quota.h	2003-07-29 03:53:31.000000000 +0200
@@ -172,7 +172,7 @@
 #define DQF_INFO_DIRTY_B 16
 #define DQF_ANY_DQUOT_DIRTY_B 17
 #define DQF_INFO_DIRTY (1 << DQF_INFO_DIRTY_B)	/* Is info dirty? */
-#define DQF_ANY_DQUOT_DIRTY (1 << DQF_ANY_DQUOT_DIRTY B)	/* Is any dquot dirty? */
+#define DQF_ANY_DQUOT_DIRTY (1 << DQF_ANY_DQUOT_DIRTY_B) /* Is any dquot dirty? */
 
 extern inline void mark_info_dirty(struct mem_dqinfo *info)
 {

