Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbTBUXpx>; Fri, 21 Feb 2003 18:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTBUXpx>; Fri, 21 Feb 2003 18:45:53 -0500
Received: from rth.ninka.net ([216.101.162.244]:30635 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267672AbTBUXpw>;
	Fri, 21 Feb 2003 18:45:52 -0500
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing
	system to a crawl]
From: "David S. Miller" <davem@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <20030221094133.GH31480@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
	<200302191742.02275.m.c.p@wolk-project.de>
	<20030219174940.GJ14633@x30.suse.de>
	<200302201629.51374.m.c.p@wolk-project.de>
	<20030220103543.7c2d250c.akpm@digeo.com>
	<20030220215457.GV31480@x30.school.suse.de>
	<shs1y22zhm9.fsf@charged.uio.no> <20030220230430.GX9800@gtf.org>
	<15957.24787.735814.496471@charged.uio.no> 
	<20030221094133.GH31480@x30.school.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 16:40:41 -0800
Message-Id: <1045874441.25412.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 01:41, Andrea Arcangeli wrote:
> On Fri, Feb 21, 2003 at 12:12:19AM +0100, Trond Myklebust wrote:
> > >>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:
> > 
> >      > One should also consider kmap_atomic...  (bcrl suggest)
> > 
> > The problem is that sendmsg() can sleep. kmap_atomic() isn't really
> > appropriate here.
> 
> 100% correct.

It actually depends upon whether you have sk->priority set
to GFP_ATOMIC or GFP_KERNEL.

