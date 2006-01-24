Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWAXEn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWAXEn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 23:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWAXEn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 23:43:28 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:36561 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1030331AbWAXEn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 23:43:27 -0500
Date: Tue, 24 Jan 2006 05:43:26 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [Patch] quota: remove unused sync_dquots_dev()
Message-ID: <20060124044326.GB27513@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


browsing through the quota code, I found that the
already removed sync_dquots_dev(dev,type) is still
defined in the no-quota case, so here is a patch
to remove this unused define ...

best,
Herbert

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

--- ./include/linux/quotaops.h.orig	2006-01-03 17:30:10 +0100
+++ ./include/linux/quotaops.h	2006-01-24 05:36:57 +0100
@@ -190,7 +190,6 @@ static __inline__ int DQUOT_OFF(struct s
  */
 #define sb_dquot_ops				(NULL)
 #define sb_quotactl_ops				(NULL)
-#define sync_dquots_dev(dev,type)		(NULL)
 #define DQUOT_INIT(inode)			do { } while(0)
 #define DQUOT_DROP(inode)			do { } while(0)
 #define DQUOT_ALLOC_INODE(inode)		(0)

