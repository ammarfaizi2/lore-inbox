Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVCJADc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVCJADc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVCJAAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:00:08 -0500
Received: from pat.uio.no ([129.240.130.16]:52353 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262214AbVCIX5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:57:11 -0500
Subject: Re: [patch 11/16] Solaris nfsacl workaround
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050227152353.510432000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
	 <20050227152353.510432000@blunzn.suse.de>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 18:56:59 -0500
Message-Id: <1110412619.10804.51.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.345, required 12,
	autolearn=disabled, AWL 1.66, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 27.02.2005 Klokka 16:22 (+0100) skreiv Andreas Gruenbacher:
> vanlig tekstdokument vedlegg (nfsacl-solaris-nfsacl-workaround.patch)
> If the nfs_acl program is available, Solaris clients expect both version
> 2 and version 3 to be available; RPC_PROG_MISMATCH leads to a mount
> failure.  Fake RPC_PROG_UNAVAIL when asked for nfs_acl version 2.
> 
> Trond has rejected this patch. I'm not sure how to deal with it in a
> truly clean way, so probably I won't care and still use this as a vendor
> patch.

So I've talked to the Solaris implementors about this issue. They said
that the above behaviour on their clients was a bug that they've
corrected in Solaris 10.

Given that very few people are going to be using Solaris clients with
NFSv2 against a Linux server, and given that there is always the option
of compiling the server without NFSACL support for those few who need to
do this, I suggest we just drop this patch.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

