Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVC2Gk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVC2Gk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVC2Gk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:40:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50411 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262446AbVC2GhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:37:25 -0500
Date: Tue, 29 Mar 2005 16:30:44 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ali Akcaagac <aliakc@web.de>, Chris Wright <chrisw@osdl.org>, hch@lst.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel OOOPS in 2.6.11.6
Message-ID: <20050329063044.GB17541@frodo>
References: <1112008141.17962.1.camel@localhost> <20050328224430.GO28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328224430.GO28536@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 02:44:30PM -0800, Chris Wright wrote:
> * Ali Akcaagac (aliakc@web.de) wrote:
> > And happy easter to you all. Just got this while trying to delete some
> > files on my system.
> ...
> > : EIP is at linvfs_open+0x59/0xa0
> ...
> Nothing in the -stable series has changed either XFS or the core vfs
> path on during file open.  Without a chance of reproducing or any more
> information, it'll be tough to make much progress here.

*nod*.

Your full .config would be useful too, Ali, thanks.

> with eax == 00000000.  This corresponds to a vp->v_fops (or rather
> vp->v_bh.bh_first->bd_ops) deref.  So, looks like the vnode has a
> NULL v_bh.bh_first (which looks like it's meant to be used to mean
> uninitialized).  May check with XFS folks if they've seen this type
> of bug.

Its not currently known.  Looks like a possible iget-related race;
does this one ring any bells, Christoph?

cheers.

-- 
Nathan
