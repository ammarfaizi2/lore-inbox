Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTFKCgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTFKCgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:36:42 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:20526 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264029AbTFKCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:36:41 -0400
Date: Tue, 10 Jun 2003 19:50:05 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030610195005.C18623@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <16102.36078.894833.262461@charged.uio.no> <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk> <20030610194333.B18623@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030610194333.B18623@google.com>; from fcusack@fcusack.com on Tue, Jun 10, 2003 at 07:43:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 07:43:33PM -0700, Frank Cusack wrote:
> On Wed, Jun 11, 2003 at 03:27:54AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> >  The real problem is different: what happens if I take
> > silly-renamed file and rename it away?  You suddenly get ->dir and
> > ->dentry if your nfs_unlinkdata having nothing to do with each other.

Wow, it's clear to me now :-) that this is another place I'm seeing NFS
problems.

> You could disallow rename if DCACHE_NFSFS_RENAMED is set.  That would
...

> OK, where else besides rename would the dentry change?

I can answer this myself: link.  (Is that correct?)  Anywhere else?

/fc
