Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWCHWtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWCHWtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWCHWtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:49:06 -0500
Received: from pat.uio.no ([129.240.130.16]:27779 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932256AbWCHWtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:49:04 -0500
Subject: Re: [PATCH 5/6] NFS: Unify NFS superblocks per-protocol per-server
	[try #7]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060308203028.25493.84121.stgit@warthog.cambridge.redhat.com>
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com>
	 <20060308203028.25493.84121.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 17:48:42 -0500
Message-Id: <1141858122.11378.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.127, required 12,
	autolearn=disabled, AWL 1.74, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 20:30 +0000, David Howells wrote:
> The attached patch makes NFS share superblocks between mounts from the same
> server over the same protocol.

We want to make NFS share superblocks on a per-filesystem basis, rather
than forcing it into a per-server basis. Cachefs may like the latter,
but POSIX does not like a filesystem where inode numbers are not
guaranteed to be unique.
A unique per-server superblock also makes it hard to support features
like failover onto replicated filesystems and/or migration of individual
filesystems onto another server.

Cheers,
  Trond

