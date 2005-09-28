Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVI1Jdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVI1Jdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVI1Jdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:33:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:8639 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030230AbVI1Jdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:33:35 -0400
Date: Wed, 28 Sep 2005 11:34:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT:  unwritten_done_lock to DEFINE_SPINLOCK
Message-ID: <20050928093424.GC30820@elte.hu>
References: <1127845928.4004.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127845928.4004.26.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Convert unwritten_done_lock xfs lock to the new syntax.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
> ===================================================================
> --- linux-2.6.13.orig/fs/xfs/linux-2.6/xfs_aops.c
> +++ linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
> @@ -192,7 +192,7 @@ linvfs_unwritten_done(
>  	int			uptodate)
>  {
>  	xfs_ioend_t		*ioend = bh->b_private;
> -	static spinlock_t	unwritten_done_lock = SPIN_LOCK_UNLOCKED;
> +	static DECLARE_SPINLOCK(unwritten_done_lock);

applied, with the additional detail that it's DEFINE, not DECLARE.

	Ingo
