Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVCJIRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVCJIRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVCJIRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:17:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:51903 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262420AbVCJIQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:16:58 -0500
Subject: Re: [patch 11/16] Solaris nfsacl workaround
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1110412619.10804.51.camel@lade.trondhjem.org>
References: <20050227152243.083308000@blunzn.suse.de>
	 <20050227152353.510432000@blunzn.suse.de>
	 <1110412619.10804.51.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1110442616.25570.2.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Mar 2005 09:16:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 00:56, Trond Myklebust wrote:
> su den 27.02.2005 Klokka 16:22 (+0100) skreiv Andreas Gruenbacher:
> > vanlig tekstdokument vedlegg (nfsacl-solaris-nfsacl-workaround.patch)
> > If the nfs_acl program is available, Solaris clients expect both version
> > 2 and version 3 to be available; RPC_PROG_MISMATCH leads to a mount
> > failure.  Fake RPC_PROG_UNAVAIL when asked for nfs_acl version 2.
> > 
> > Trond has rejected this patch. I'm not sure how to deal with it in a
> > truly clean way, so probably I won't care and still use this as a vendor
> > patch.
> 
> So I've talked to the Solaris implementors about this issue. They said
> that the above behaviour on their clients was a bug that they've
> corrected in Solaris 10.

Thanks for gathering this piece of information.

> Given that very few people are going to be using Solaris clients with
> NFSv2 against a Linux server, and given that there is always the option
> of compiling the server without NFSACL support for those few who need to
> do this, I suggest we just drop this patch.

It's NFSv3 clients that exhibit the strange behavior; else I never would
have run into this bug. For me it's okay to leave out this patch; we'll
still carry it around in our vendor tree for a while though.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

