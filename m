Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTA1W3t>; Tue, 28 Jan 2003 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTA1W3t>; Tue, 28 Jan 2003 17:29:49 -0500
Received: from ns.suse.de ([213.95.15.193]:14098 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261451AbTA1W3s>;
	Tue, 28 Jan 2003 17:29:48 -0500
Date: Tue, 28 Jan 2003 23:39:09 +0100
From: Andi Kleen <ak@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030128223909.GA16611@wotan.suse.de>
References: <20030122080322.GB3466@bjl1.asuk.net.suse.lists.linux.kernel> <Pine.LNX.4.33L2.0301281139570.30636-100000@dragon.pdx.osdl.net.suse.lists.linux.kernel> <20030128213621.GA29036@bjl1.asuk.net.suse.lists.linux.kernel> <p73hebtym5d.fsf@oldwotan.suse.de> <Pine.LNX.4.50.0301281421520.2085-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0301281421520.2085-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 02:24:52PM -0800, Davide Libenzi wrote:
> On Tue, 28 Jan 2003, Andi Kleen wrote:
> 
> > Jamie Lokier <jamie@shareable.org> writes:
> > >
> > > Which suggests that all the architectures are fine with all these
> > > "int" returns, except IA64.
> >
> > x86-64 needs long returns too.
> >
> > I think I fixed all of them, if you noticed any missing please let me now.
> 
> #define __NR_epoll_create       ???
> #define __NR_epoll_ctl          ???
> #define __NR_epoll_wait         ???
> 
> That in 2.5.59 return "int". I posted the patch to make them return
> "long" to Linus ( Andrew got it ) this weekend.

Sorry I meant I fixed all x86-64 specific syscalls returning int.

-Andi
