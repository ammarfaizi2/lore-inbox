Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVCSN72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVCSN72 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVCSNxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:53:30 -0500
Received: from coderock.org ([193.77.147.115]:48776 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262554AbVCSNTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:19:49 -0500
Subject: [patch 2/4] security/selinux/ss/ebitmap.c: fix sparse warnings
To: sds@epoch.ncsc.mil
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, domen@coderock.org,
       adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:19:41 +0100
Message-Id: <20050319131942.17B711F1EE@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/security/selinux/ss/ebitmap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN security/selinux/ss/ebitmap.c~sparse-security_selinux_ss_ebitmap security/selinux/ss/ebitmap.c
--- kj/security/selinux/ss/ebitmap.c~sparse-security_selinux_ss_ebitmap	2005-03-18 20:05:32.000000000 +0100
+++ kj-domen/security/selinux/ss/ebitmap.c	2005-03-18 20:05:32.000000000 +0100
@@ -239,8 +239,9 @@ int ebitmap_read(struct ebitmap *e, void
 {
 	int rc;
 	struct ebitmap_node *n, *l;
-	u32 buf[3], mapsize, count, i;
-	u64 map;
+	__le32 buf[3];
+	u32 mapsize, count, i;
+	__le64 map;
 
 	ebitmap_init(e);
 
_
