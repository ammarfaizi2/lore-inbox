Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWHNXwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWHNXwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWHNXwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:52:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932739AbWHNXwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:52:14 -0400
Date: Mon, 14 Aug 2006 16:51:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060814165156.e0838a19.akpm@osdl.org>
In-Reply-To: <1155595768.5656.26.camel@localhost>
References: <20060813012454.f1d52189.akpm@osdl.org>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<1155595768.5656.26.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 18:49:27 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Sun, 2006-08-13 at 13:39 -0700, Andrew Morton wrote:
> > On Sun, 13 Aug 2006 01:24:54 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > 
> > This kernel breaks autofs /net handling.  Bisection shows that the bug is
> > introduced by git-nfs.patch.
> 
> Could you try pulling afresh from the NFS git tree?

Did that - there is no change.

> I've fixed up a
> couple of issues in which rpc_pipefs was corrupting the dcache, as well
> as a few dentry leaks that were introduced by David's
> nfs_alloc_client().

I tested just bare 2.6.18-rc4+git-nfs.patch to eliminate any -mm unknowns. 
The problem remains.
