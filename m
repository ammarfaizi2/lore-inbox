Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbVIJFOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVIJFOA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 01:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbVIJFOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 01:14:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030398AbVIJFOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 01:14:00 -0400
Date: Fri, 9 Sep 2005 22:13:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: ak@suse.de, hugh@veritas.com, JBeulich@novell.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Message-Id: <20050909221320.6b53a030.akpm@osdl.org>
In-Reply-To: <20050909171929.GA4155@localhost.localdomain>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com>
	<4321749202000078000248C5@emea1-mh.id2.novell.com>
	<Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com>
	<200509091258.13300.ak@suse.de>
	<20050909171929.GA4155@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> On Fri, Sep 09, 2005 at 12:58:12PM +0200 Andi Kleen wrote:
> 
> > On Friday 09 September 2005 12:45, Hugh Dickins wrote:
> > > On Fri, 9 Sep 2005, Jan Beulich wrote:
> > > > > But why would anyone want frame pointers on x86-64?
> > > >
> > > > I'd put the question differently: Why should x86-64 not allow what
> > > > other architectures do?
> > > >
> > > > But of course, I'm not insisting on this patch to get in, it just
> > > > seemed an obvious inconsistency...
> > >
> > > I'm with Jan on this.  I use a similar patch for frame pointers on
> > > x86_64 most of the time, in the hope of getting more accurate backtraces.
> > 
> > It won't give more accurate backtraces, not even on i386 because show_stack
> > doesn't have any code to follow frame pointers.
> > 
> 
> Huh? print_context_stack follows frame pointers which is called from
> show_stack

show_trace() uses print_context_stack(), but show_stack() just does a
dump-everything.  I wondered why the CONFIG_FRAME_POINTER oops traces were
still so crappy.   TIA ;)
