Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSJHSnU>; Tue, 8 Oct 2002 14:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSJHSm1>; Tue, 8 Oct 2002 14:42:27 -0400
Received: from ns.suse.de ([213.95.15.193]:12298 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261455AbSJHSlY> convert rfc822-to-8bit;
	Tue, 8 Oct 2002 14:41:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/4] Add extended attributes to ext2/3
Date: Tue, 8 Oct 2002 20:47:04 +0200
User-Agent: KMail/1.4.3
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Ed Tomlinson <tomlins@cam.org>
References: <E17yymB-00021j-00@think.thunk.org> <20021008191900.A12912@infradead.org> <3DA32623.C1126CF1@digeo.com>
In-Reply-To: <3DA32623.C1126CF1@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210082047.04594.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 20:38, Andrew Morton wrote:
> [...]
> > > This first patch creates a generic interface for registering caches
> > > with the VM subsystem so that they can react appropriately to memory
> > > pressure.
> >
> > I'd suggest Ed Tomlinson's much saner interface that adds a third
> > callbackj to kmem_cache_t (similar to the Solaris implementation)
> > instead.
> >
> > Doing this outside slab is not a good idea (and XFS currently does
> > it too - in it's own code which should be replaced with Ed's one)
>
> Yup, although that's a fairly minor point in this context..
>
> The shrinker callback code is not actually in Linus's kernel
> at present.  I'm kind of sitting on it until I've had time
> to ponder the dirty great lock which Ed added ;)

Switching to Ed's code once it's in the kernel may be worthwhile; until then 
the dumb shrinking approaah doesn't to do much harm IMHO.

--Andreas.

