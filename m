Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWIANIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWIANIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWIANIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:08:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48302 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750967AbWIANIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:08:46 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060831102127.8fb9a24b.akpm@osdl.org> 
References: <20060831102127.8fb9a24b.akpm@osdl.org>  <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 01 Sep 2006 14:08:34 +0100
Message-ID: <9534.1157116114@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Your CONFIG_BLOCK patches did a decent job of trashing your
> fs-cache-make-kafs-* patches, btw.  What's up with that?  OK, it's sensible
> for people to work against mainline but the net effect of doing that is to
> create a mess for other people to clean up.

It seems the only problem in my patches is that the file address space
operations have had the sync_pages op removed in a patch in the
disable-block-layer patchset as it's no longer necessary.

However, as I suspect you're applying the block patches *before* the FS-Cache
patches, I can't give you an incremental patch that you can apply after the
other fs-cache-make-kafs-* patches, since you need to modify the first patch
(fs-cache-make-kafs-use-fs-cache.patch) to get it to apply at all now.

So, I could issue a revised AFS+FS-Cache patch, would that do?  Or would you
rather have a patch that you can apply to the one you already have directly
and modify it in place?

David
