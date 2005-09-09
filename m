Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVIIRTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVIIRTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVIIRTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:19:41 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:61601 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1030275AbVIIRTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:19:40 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Fri, 9 Sep 2005 19:19:29 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Message-ID: <20050909171929.GA4155@localhost.localdomain>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <4321749202000078000248C5@emea1-mh.id2.novell.com> <Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com> <200509091258.13300.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509091258.13300.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 12:58:12PM +0200 Andi Kleen wrote:

> On Friday 09 September 2005 12:45, Hugh Dickins wrote:
> > On Fri, 9 Sep 2005, Jan Beulich wrote:
> > > > But why would anyone want frame pointers on x86-64?
> > >
> > > I'd put the question differently: Why should x86-64 not allow what
> > > other architectures do?
> > >
> > > But of course, I'm not insisting on this patch to get in, it just
> > > seemed an obvious inconsistency...
> >
> > I'm with Jan on this.  I use a similar patch for frame pointers on
> > x86_64 most of the time, in the hope of getting more accurate backtraces.
> 
> It won't give more accurate backtraces, not even on i386 because show_stack
> doesn't have any code to follow frame pointers.
> 

Huh? print_context_stack follows frame pointers which is called from
show_stack
