Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVCSN71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVCSN71 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVCSNxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:53:44 -0500
Received: from coderock.org ([193.77.147.115]:50312 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262555AbVCSNTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:19:53 -0500
Subject: [patch 3/4] security/selinux/ss/avtab.c: fix sparse warnings
To: sds@epoch.ncsc.mil
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, domen@coderock.org,
       adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:19:44 +0100
Message-Id: <20050319131945.3A8CE1ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/security/selinux/ss/avtab.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN security/selinux/ss/avtab.c~sparse-security_selinux_ss_avtab security/selinux/ss/avtab.c
--- kj/security/selinux/ss/avtab.c~sparse-security_selinux_ss_avtab	2005-03-18 20:05:32.000000000 +0100
+++ kj-domen/security/selinux/ss/avtab.c	2005-03-18 20:05:32.000000000 +0100
@@ -303,7 +303,7 @@ void avtab_hash_eval(struct avtab *h, ch
 
 int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey)
 {
-	u32 buf[7];
+	__le32 buf[7];
 	u32 items, items2;
 	int rc;
 
@@ -370,7 +370,7 @@ int avtab_read(struct avtab *a, void *fp
 	int rc;
 	struct avtab_key avkey;
 	struct avtab_datum avdatum;
-	u32 buf[1];
+	__le32 buf[1];
 	u32 nel, i;
 
 
_
