Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264761AbTBTWya>; Thu, 20 Feb 2003 17:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264773AbTBTWya>; Thu, 20 Feb 2003 17:54:30 -0500
Received: from havoc.daloft.com ([64.213.145.173]:42397 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S264761AbTBTWy3>;
	Thu, 20 Feb 2003 17:54:29 -0500
Date: Thu, 20 Feb 2003 18:04:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030220230430.GX9800@gtf.org>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de> <shs1y22zhm9.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs1y22zhm9.fsf@charged.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:56:14PM +0100, Trond Myklebust wrote:
> >>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:
> 
>      > 2.5.62 has the very same deadlock condition in xdr triggered by
>      >        nfs too.
>      > Andrew, if you're forward porting it yourself like with the
>      > filebacked vma merging feature just let me know so we make sure
>      > not to duplicate effort.
> 
> For 2.5.x we should rather fix MSG_MORE so that it actually works
> instead of messing with hacks to kmap().
> 
> For 2.4.x, Hirokazu Takahashi had a patch which allowed for a safe
> kmap of > 1 page in one call. Appended here as an attachment FYI
> (Marcelo do *not* apply!).


One should also consider kmap_atomic...  (bcrl suggest)

	Jeff



