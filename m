Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVA0Wvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVA0Wvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVA0Wvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:51:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:33950 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261264AbVA0WvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:51:00 -0500
Subject: Re: 2.6.11-rc2-mm1: kernel bad access while booting diskless client
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050127142333.0ba81907.akpm@osdl.org>
References: <20050127215619.56535.qmail@web52309.mail.yahoo.com>
	 <20050127142333.0ba81907.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-JuKV9Hs5LadLzOGk7CMe"
Organization: SUSE Labs
Message-Id: <1106866256.7616.50.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 27 Jan 2005 23:50:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JuKV9Hs5LadLzOGk7CMe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

here is a fix for a NULL pointer access problem with NFSv2 that isn't in
2.6.11-rc2-mm1, but it can't explain this NULL inode->i_op.

-- Andreas.

--=-JuKV9Hs5LadLzOGk7CMe
Content-Disposition: inline
Content-Type: message/rfc822

Return-Path: <agruen@suse.de>
Received: from imap-dhs.suse.de ([unix socket]) by imap-dhs (Cyrus v2.1.16)
	with LMTP; Tue, 25 Jan 2005 02:30:53 +0100
X-Sieve: CMU Sieve 2.2
Received: from hermes.suse.de (hermes.suse.de [149.44.160.1]) (using TLSv1
	with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits)) (Client CN
	"hermes.suse.de", Issuer "SuSE Linux AG internal IMAP-Server CA" (verified
	OK)) by imap-dhs.suse.de (Postfix) with ESMTP id 486BB7D4814 for
	<agruen@imap-dhs.suse.de>; Tue, 25 Jan 2005 02:30:53 +0100 (CET)
Received: from wotan.suse.de (wotan.suse.de [10.10.0.1]) by hermes.suse.de
	(Postfix) with ESMTP id 294E310FD09 for <agruen@imap-dhs.suse.de>; Tue, 25
	Jan 2005 02:30:53 +0100 (CET)
Received: by wotan.suse.de (Postfix, from userid 10268) id 23F8719BCD4;
	Tue, 25 Jan 2005 02:30:53 +0100 (CET)
X-Original-To: agruen@wotan.suse.de
Received: from hermes.suse.de (hermes.suse.de [149.44.160.1]) by
	wotan.suse.de (Postfix) with ESMTP id 1BBAE19BCD2 for
	<agruen@wotan.suse.de>; Tue, 25 Jan 2005 02:30:53 +0100 (CET)
Received: by hermes.suse.de (Postfix) id 172DC13AC50; Tue, 25 Jan 2005
	02:30:53 +0100 (CET)
Received: from scanhost.suse.de (scanhost.suse.de [149.44.160.36]) by
	hermes.suse.de (Postfix) with ESMTP id 109AE13AD2A for <agruen@suse.de>;
	Tue, 25 Jan 2005 02:30:53 +0100 (CET)
Received: from hermes.suse.de ([149.44.160.1]) by scanhost.suse.de
	(scanhost [149.44.160.36]) (amavisd-new, port 10025) with ESMTP id 01535-18
	for <agruen@suse.de>; Tue, 25 Jan 2005 02:30:49 +0100 (CET)
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2]) (using TLSv1
	with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits)) (No client certificate
	requested) by hermes.suse.de (Postfix) with ESMTP id D6EED13AD64 for
	<agruen@suse.de>; Tue, 25 Jan 2005 02:30:49 +0100 (CET)
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	Cantor.suse.de (Postfix) with ESMTP id 7B75213A0D1A for <agruen@suse.de>;
	Tue, 25 Jan 2005 02:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S261634AbVAYBYP (ORCPT <rfc822;agruen@suse.de>); Mon, 24 Jan 2005 20:24:15
	-0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVAYBXQ
	(ORCPT <rfc822;linux-kernel-outgoing>); Mon, 24 Jan 2005 20:23:16 -0500
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8]) (using
	TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits)) (No client
	certificate requested) by Cantor.suse.de (Postfix) with ESMTP id
	5FCE713A11C6; Tue, 25 Jan 2005 02:20:43 +0100 (CET)
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>, Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [patch 12/13] ACL umask handling workaround in nfs client
Date: Tue, 25 Jan 2005 02:20:41 +0100
User-Agent: KMail/1.7.1
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>, Buck Huppmann <buchk@pobox.com>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203620.108564000@blunzn.suse.de>
In-Reply-To: <20050122203620.108564000@blunzn.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200501250220.41618.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
X-Virus-Scanned: by amavisd-new at scanhost.suse.de
X-Spam-Status: No, hits=-5.9 tagged_above=-20.0 required=5.0
	tests=BAYES_00, MY_LINUX
X-Spam-Level: 
X-Evolution-Source: imap://agruen@imap.suse.de/
Content-Transfer-Encoding: 7bit

Hello,

this patch has an NFSv2 problem that I haven't tripped over until today. The 
fix is this:

------- 8< -------
Fix NFSv2 null pointer access

With NFSv2 we would try to follow a NULL getacl and setacl function
pointer here. Add the missing checks.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/nfs/dir.c
===================================================================
--- linux-2.6.10.orig/fs/nfs/dir.c
+++ linux-2.6.10/fs/nfs/dir.c
@@ -984,6 +984,9 @@ static int nfs_set_default_acl(struct in
 	struct posix_acl *dfacl, *acl;
 	int error = 0;
 
+	if (NFS_PROTO(inode)->version != 3 ||
+	    !NFS_PROTO(dir)->getacl || !NFS_PROTO(inode)->setacls)
+		return 0;
 	dfacl = NFS_PROTO(dir)->getacl(dir, ACL_TYPE_DEFAULT);
 	if (IS_ERR(dfacl)) {
 		error = PTR_ERR(dfacl);


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-JuKV9Hs5LadLzOGk7CMe--

