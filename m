Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbSJHSNW>; Tue, 8 Oct 2002 14:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSJHSNW>; Tue, 8 Oct 2002 14:13:22 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:41225 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261336AbSJHSNV>; Tue, 8 Oct 2002 14:13:21 -0400
Date: Tue, 8 Oct 2002 19:19:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Ed Tomlinson <tomlins@cam.org>
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021008191900.A12912@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Ed Tomlinson <tomlins@cam.org>
References: <E17yymB-00021j-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17yymB-00021j-00@think.thunk.org>; from tytso@mit.edu on Tue, Oct 08, 2002 at 02:08:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 02:08:11PM -0400, tytso@mit.edu wrote:
> 
> This is the first of four patches which add extended attribute support
> to the ext2 and ext3 filesystems.  It is a port of Andreas Gruenbacher's
> patches, which have been well tested and in a number of distributions
> (including RH 8, if I'm not mistaken) already.

RH backed it out after the second or third beta due to bugginess..

> This first patch creates a generic interface for registering caches with
> the VM subsystem so that they can react appropriately to memory
> pressure.

I'd suggest Ed Tomlinson's much saner interface that adds a third callbackj
to kmem_cache_t (similar to the Solaris implementation) instead.

Doing this outside slab is not a good idea (and XFS currently does
it too - in it's own code which should be replaced with Ed's one)
