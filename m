Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265145AbSJPQDY>; Wed, 16 Oct 2002 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265148AbSJPQDY>; Wed, 16 Oct 2002 12:03:24 -0400
Received: from ns.suse.de ([213.95.15.193]:10770 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265145AbSJPQDV> convert rfc822-to-8bit;
	Wed, 16 Oct 2002 12:03:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH 1/5] Add POSIX Access Control Lists to ext2/3
Date: Wed, 16 Oct 2002 18:09:16 +0200
User-Agent: KMail/1.4.3
References: <E181a3b-0006Nu-00@snap.thunk.org> <20021016141103.A8393@infradead.org> <20021016155012.GA8210@think.thunk.org>
In-Reply-To: <20021016155012.GA8210@think.thunk.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210161809.17015.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 17:50, Theodore Ts'o wrote:
> On Wed, Oct 16, 2002 at 02:11:04PM +0100, Christoph Hellwig wrote:
> > Ted, please either go _always_ through the {get,set}_posix_acl methods
> > or never.  Currently XFS doesn't know and doesn't want to know
> > about the so called "egenric ACL representation" used by ext2/ext3.  With
> > theses methods we'd have to add it to XFS which is fine for me as long as
> > it the representation generally used for working with ACLs.  That would
> > mean we'd have to add new syscall or at least VFS-level hooks to the
> > xattr code.
>
> Fine.  I'll just yank the {get,set}_posix_acl methods for now.  The
> inode methods were only needed for the NFS code (see Andreas' comments
> about the xattr interfaces being problematical for VFS support).
>
> However, the reality is that at this point, we probably won't have
> time to get support in for the NFS server ACL before feature freeze,
> and changing the interface to ACL's (never mind the headaches of
> trying to agree to a new syscall interface at this late date), given
> the deployed userspace tools, just doesn't seem to be realistic.

The pain of not having the NFS ACL hack is only moderate; it only affects 
interoperability of older systems with a feature that wasn't there before, 
and even then the effects aren't dramatic. We could live without it for a 
while, but I'll see if I code that up in time too.

--Andreas.
