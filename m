Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTA1Woy>; Tue, 28 Jan 2003 17:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTA1Woy>; Tue, 28 Jan 2003 17:44:54 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:12435 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261615AbTA1Wox>; Tue, 28 Jan 2003 17:44:53 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 28 Jan 2003 15:00:01 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
In-Reply-To: <20030128223909.GA16611@wotan.suse.de>
Message-ID: <Pine.LNX.4.50.0301281459060.2085-100000@blue1.dev.mcafeelabs.com>
References: <20030122080322.GB3466@bjl1.asuk.net.suse.lists.linux.kernel>
 <Pine.LNX.4.33L2.0301281139570.30636-100000@dragon.pdx.osdl.net.suse.lists.linux.kernel>
 <20030128213621.GA29036@bjl1.asuk.net.suse.lists.linux.kernel>
 <p73hebtym5d.fsf@oldwotan.suse.de> <Pine.LNX.4.50.0301281421520.2085-100000@blue1.dev.mcafeelabs.com>
 <20030128223909.GA16611@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Andi Kleen wrote:

> On Tue, Jan 28, 2003 at 02:24:52PM -0800, Davide Libenzi wrote:
> > On Tue, 28 Jan 2003, Andi Kleen wrote:
> >
> > > Jamie Lokier <jamie@shareable.org> writes:
> > > >
> > > > Which suggests that all the architectures are fine with all these
> > > > "int" returns, except IA64.
> > >
> > > x86-64 needs long returns too.
> > >
> > > I think I fixed all of them, if you noticed any missing please let me now.
> >
> > #define __NR_epoll_create       ???
> > #define __NR_epoll_ctl          ???
> > #define __NR_epoll_wait         ???
> >
> > That in 2.5.59 return "int". I posted the patch to make them return
> > "long" to Linus ( Andrew got it ) this weekend.
>
> Sorry I meant I fixed all x86-64 specific syscalls returning int.

I know Andi, I was trying to make you notice that those are missing from
the x86-64 arch :)



- Davide

