Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVIIOxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVIIOxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVIIOxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:53:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55262 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751411AbVIIOxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:53:22 -0400
Date: Fri, 9 Sep 2005 15:53:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc() in ntfs_malloc_nofs() and add _nofail() version.
Message-ID: <20050909145318.GA7061@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk> <52ek7yi9as.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ek7yi9as.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 07:51:23AM -0700, Roland Dreier wrote:
>     Anton> fs/ntfs/malloc.h::ntfs_malloc_nofs() to do the kmalloc()
>     Anton> based allocations with __GFP_HIGHMEM, analogous to how the
>     Anton> vmalloc() based allocations are done.
> 
> Does it make sense to pass __GFP_HIGHMEM to kmalloc()?

Not at all (as you indicated below..)

> kmalloc() has
> to return memory from lowmem, since it gives you an address from the
> direct-mapped kernel area, so at best kmalloc() ignores this flag.

