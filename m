Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbSJOLMc>; Tue, 15 Oct 2002 07:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbSJOLMc>; Tue, 15 Oct 2002 07:12:32 -0400
Received: from thunk.org ([140.239.227.29]:38349 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262368AbSJOLMc>;
	Tue, 15 Oct 2002 07:12:32 -0400
Date: Tue, 15 Oct 2002 07:18:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ext2-devel@lists.sourceforge.net,
       Matt Reppert <arashi@arashi.yi.org>
Subject: Re: [Ext2-devel] [PATCH] Compile without xattrs
Message-ID: <20021015111808.GA29988@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <agruen@suse.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ext2-devel@lists.sourceforge.net,
	Matt Reppert <arashi@arashi.yi.org>
References: <3DABA351.7E9C1CFB@digeo.com> <20021015005733.3bbde222.arashi@arashi.yi.org> <200210151211.19353.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210151211.19353.agruen@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:11:19PM +0200, Andreas Gruenbacher wrote:
> On Tuesday 15 October 2002 07:57, Matt Reppert wrote:
> > On Mon, 14 Oct 2002 22:10:41 -0700
> >
> > Andrew Morton <akpm@digeo.com> wrote:
> > > - merge up the ext2/3 extended attribute code, convert that to use
> > >   the slab shrinking API in Linus's current tree.
> >
> > Trivial patch for the "too chicken to enable xattrs for now" case, but I
> > need this to compile:
> 
> Please add this to include/linux/errno.h instead:
> 
> #define ENOTSUP EOPNOTSUPP      /* Operation not supported */
> 
> ENOTSUPP is distinct from (EOPNOTSUPP = ENOTSUP)

Actually, what I've been doing is just using EOPNOTSUPP directly in
the patches; I just missed those error returns in ext[23]_xattr.h.

							- Ted
