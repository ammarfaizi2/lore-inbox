Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVCTMAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVCTMAN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 07:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVCTL7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:59:48 -0500
Received: from coderock.org ([193.77.147.115]:2700 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262147AbVCTL7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:59:43 -0500
Date: Sun, 20 Mar 2005 12:59:39 +0100
From: Domen Puncer <domen@coderock.org>
To: sds@epoch.ncsc.mil
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 2/4 with proper signed-off] security/selinux/ss/ebitmap.c: fix sparse warnings
Message-ID: <20050320115939.GU14273@nd47.coderock.org>
References: <20050319131942.17B711F1EE@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131942.17B711F1EE@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/security/selinux/ss/ebitmap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN security/selinux/ss/ebitmap.c~sparse-security_selinux_ss_ebitmap security/selinux/ss/ebitmap.c
--- kj/security/selinux/ss/ebitmap.c~sparse-security_selinux_ss_ebitmap	2005-03-20 12:11:31.000000000 +0100
+++ kj-domen/security/selinux/ss/ebitmap.c	2005-03-20 12:11:31.000000000 +0100
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
