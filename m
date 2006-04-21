Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWDUJv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWDUJv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 05:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWDUJv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 05:51:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34657 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751308AbWDUJv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 05:51:28 -0400
Date: Fri, 21 Apr 2006 11:52:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, davem@davemloft.net
Subject: Re: [PATCH] sys_vmsplice
Message-ID: <20060421095201.GA4762@suse.de>
References: <20060421080239.GC4717@suse.de> <20060421021702.20049dcd.akpm@osdl.org> <20060421092158.GE4717@suse.de> <20060421022555.2d460805.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421022555.2d460805.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> >  > long spu_sys_callback(struct spu_syscall_block *s)
> >  > {
> >  > 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
> >  > 
> >  > 	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);
> > 
> >  I'll leave the ppc syscall update out of it.
> 
> It might be better to just stick the new entry into the spufs table, make
> sure that the powerpc guys see it go in.  That way, ppc64 people (Linus,
> maybe you?) can test it.

No ppc64 here unfortunately, and my ppc box (powerbook) has since moved
on to more relaxing pastures (my wife inherited it). But certainly, I'll
update it then.

> I guess mapping it onto sys_ni_syscall would be safest.
> 
> (It's been broken since sys_tee went in, btw).

Noted.

-- 
Jens Axboe

