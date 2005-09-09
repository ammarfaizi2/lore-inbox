Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVIIIrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVIIIrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVIIIrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:47:12 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:64172 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932543AbVIIIrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:47:11 -0400
Date: Fri, 9 Sep 2005 17:43:42 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: [PATCH 1/6] jbd: remove duplicated debug print
Message-ID: <20050909084342.GC14205@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909084214.GB14205@miraclelinux.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicated debug print

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

---

 commit.c |    2 --
 1 files changed, 2 deletions(-)

--- 2.6-mm/fs/jbd/commit.c.orig	2005-09-02 00:53:49.000000000 +0900
+++ 2.6-mm/fs/jbd/commit.c	2005-09-02 00:54:11.000000000 +0900
@@ -425,8 +425,6 @@ write_out_data:
 
 	journal_write_revoke_records(journal, commit_transaction);
 
-	jbd_debug(3, "JBD: commit phase 2\n");
-
 	/*
 	 * If we found any dirty or locked buffers, then we should have
 	 * looped back up to the write_out_data label.  If there weren't
