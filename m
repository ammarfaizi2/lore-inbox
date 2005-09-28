Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVI1PEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVI1PEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVI1PEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:04:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42737 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751034AbVI1PEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:04:47 -0400
Subject: Re: [PATCH] RT:  unwritten_done_lock to DEFINE_SPINLOCK
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050928093424.GC30820@elte.hu>
References: <1127845928.4004.26.camel@dhcp153.mvista.com>
	 <20050928093424.GC30820@elte.hu>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 08:04:02 -0700
Message-Id: <1127919842.8520.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 11:34 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Convert unwritten_done_lock xfs lock to the new syntax.
> > 
> > Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> > 
> > Index: linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
> > ===================================================================
> > --- linux-2.6.13.orig/fs/xfs/linux-2.6/xfs_aops.c
> > +++ linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
> > @@ -192,7 +192,7 @@ linvfs_unwritten_done(
> >  	int			uptodate)
> >  {
> >  	xfs_ioend_t		*ioend = bh->b_private;
> > -	static spinlock_t	unwritten_done_lock = SPIN_LOCK_UNLOCKED;
> > +	static DECLARE_SPINLOCK(unwritten_done_lock);
> 
> applied, with the additional detail that it's DEFINE, not DECLARE.

Yeah, thanks .

Daniel

