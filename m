Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261428AbSJHSdB>; Tue, 8 Oct 2002 14:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJHSdB>; Tue, 8 Oct 2002 14:33:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:58852 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261426AbSJHSc4>;
	Tue, 8 Oct 2002 14:32:56 -0400
Message-ID: <3DA32623.C1126CF1@digeo.com>
Date: Tue, 08 Oct 2002 11:38:27 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/4] Add extended attributes to ext2/3
References: <E17yymB-00021j-00@think.thunk.org> <20021008191900.A12912@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 18:38:27.0591 (UTC) FILETIME=[E44C4170:01C26EF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Tue, Oct 08, 2002 at 02:08:11PM -0400, tytso@mit.edu wrote:
> >
> > This is the first of four patches which add extended attribute support
> > to the ext2 and ext3 filesystems.  It is a port of Andreas Gruenbacher's
> > patches, which have been well tested and in a number of distributions
> > (including RH 8, if I'm not mistaken) already.
> 
> RH backed it out after the second or third beta due to bugginess..
> 
> > This first patch creates a generic interface for registering caches with
> > the VM subsystem so that they can react appropriately to memory
> > pressure.
> 
> I'd suggest Ed Tomlinson's much saner interface that adds a third callbackj
> to kmem_cache_t (similar to the Solaris implementation) instead.
> 
> Doing this outside slab is not a good idea (and XFS currently does
> it too - in it's own code which should be replaced with Ed's one)

Yup, although that's a fairly minor point in this context..

The shrinker callback code is not actually in Linus's kernel
at present.  I'm kind of sitting on it until I've had time
to ponder the dirty great lock which Ed added ;)
