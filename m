Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWHNWtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWHNWtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWHNWtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:49:40 -0400
Received: from pat.uio.no ([129.240.10.4]:37008 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932740AbWHNWtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:49:39 -0400
Subject: Re: 2.6.18-rc4-mm1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Ian Kent <raven@themaw.net>
In-Reply-To: <20060813133935.b0c728ec.akpm@osdl.org>
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060813133935.b0c728ec.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 18:49:27 -0400
Message-Id: <1155595768.5656.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.793, required 12,
	autolearn=disabled, AWL 0.70, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-13 at 13:39 -0700, Andrew Morton wrote:
> On Sun, 13 Aug 2006 01:24:54 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> This kernel breaks autofs /net handling.  Bisection shows that the bug is
> introduced by git-nfs.patch.

Could you try pulling afresh from the NFS git tree? I've fixed up a
couple of issues in which rpc_pipefs was corrupting the dcache, as well
as a few dentry leaks that were introduced by David's
nfs_alloc_client().

Cheers,
  Trond

