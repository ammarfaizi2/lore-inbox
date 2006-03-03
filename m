Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWCCD1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWCCD1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 22:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWCCD1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 22:27:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751658AbWCCD1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 22:27:49 -0500
Date: Thu, 2 Mar 2006 19:22:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] NFS: Unify NFS superblocks per-protocol per-server
 [try #3]
Message-Id: <20060302192258.37588b5c.akpm@osdl.org>
In-Reply-To: <20060302213409.7282.29767.stgit@warthog.cambridge.redhat.com>
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com>
	<20060302213409.7282.29767.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> ..
>
>  fs/namei.c                |    2 
>  fs/namespace.c            |    4 +
>  fs/nfs/Makefile           |    4 -
>  fs/nfs/dir.c              |   65 +++++++++++
>  fs/nfs/inode.c            |  265 ++++++++++++++++++++++++---------------------
>  fs/nfs/nfs3proc.c         |    2 
>  fs/nfs/nfs4proc.c         |   59 +---------
>  fs/nfs/nfs4state.c        |    2 
>  include/linux/nfs_fs_sb.h |    2 
>  9 files changed, 218 insertions(+), 187 deletions(-)
> 
> ...
>
> -nfs-y 			:= dir.o file.o inode.o nfs2xdr.o pagelist.o \
> -			   proc.o read.o symlink.o unlink.o write.o
> +nfs-y 			:= dir.o file.o getroot.o inode.o nfs2xdr.o \
> +			   pagelist.o proc.o read.o symlink.o unlink.o write.o

We're missing getroot.c and internal.h.  I stole those from your #2 series,
and it compiles and links, fwiw.
