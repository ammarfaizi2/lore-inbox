Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264636AbSJOKs4>; Tue, 15 Oct 2002 06:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbSJOKs4>; Tue, 15 Oct 2002 06:48:56 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:11012 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264636AbSJOKsz>; Tue, 15 Oct 2002 06:48:55 -0400
Date: Tue, 15 Oct 2002 11:54:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ext2-devel@lists.sourceforge.net, tytso@mit.edu,
       Matt Reppert <arashi@arashi.yi.org>
Subject: Re: [Ext2-devel] [PATCH] Compile without xattrs
Message-ID: <20021015115446.A21776@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ext2-devel@lists.sourceforge.net, tytso@mit.edu,
	Matt Reppert <arashi@arashi.yi.org>
References: <3DABA351.7E9C1CFB@digeo.com> <20021015005733.3bbde222.arashi@arashi.yi.org> <200210151211.19353.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210151211.19353.agruen@suse.de>; from agruen@suse.de on Tue, Oct 15, 2002 at 12:11:19PM +0200
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
> 
> (Yes, it's a mess.)

You explained some time ago that it is not posix-compliant to have
two errnos with the same numerical value.  So please do it right..

