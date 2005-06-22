Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVFVJV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVFVJV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVFVHm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:42:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64198 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262829AbVFVFhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:37:01 -0400
Date: Wed, 22 Jun 2005 06:36:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Masover <ninja@slaphack.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050622053656.GB28228@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Masover <ninja@slaphack.com>, Jeff Garzik <jgarzik@pobox.com>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B8E834.5030809@slaphack.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 11:25:24PM -0500, David Masover wrote:
> > You're basically implementing another VFS layer inside of reiser4, which
> > is a big layering violation.
> 
> There's been sloppy code in the kernel before.  I remember one bit in
> particular which was commented "Fuck me gently with a chainsaw."  If I
> remember correctly, this had all of the PCI ids and the names and
> manufacturers of the corresponding devices -- in a data structure -- in
> C source code.  It was something like one massive array definition, or
> maybe it was a structure.  I don't remember exactly, but...

Every device driver has a big array of corresponing device ids as an
array in C code - oh my god we're doomed  .. not.


> I agree there, too.  In fact, some people have suggested that all
> "legacy" (read: non-reiser) filesystems should be implemented as Reiser4
> plugins, effectively killing VFS.*
> 
> So, Reiser4 may eventually take over VFS and be the only Linux
> filesystem, but if so, it will have to do it much more slowly.  Take the
> good ideas -- things like plugins -- and make them at least look like
> incremental updates to the current VFS, and make them available to all
> filesystems.

And why exactly would we replace a stable, working abstraction with an unpoven
mess?

