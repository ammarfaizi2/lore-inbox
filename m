Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTJaMzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTJaMzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:55:09 -0500
Received: from aeimail.aei.ca ([206.123.6.14]:3796 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263269AbTJaMzF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:55:05 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Fri, 31 Oct 2003 07:55:36 -0500
User-Agent: KMail/1.5.9
References: <200310292230.12304.chris@cvine.freeserve.co.uk> <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <20031031112615.GA10530@k3.hellgate.ch>
In-Reply-To: <20031031112615.GA10530@k3.hellgate.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200310310755.36224.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 31, 2003 06:26 am, Roger Luethi wrote:
> On Thu, 30 Oct 2003 22:57:23 -0500, Rik van Riel wrote:
>
> > On Wed, 29 Oct 2003, Chris Vine wrote:
> > 
> >
> > > However, on a low end machine (200MHz Pentium MMX uniprocessor with
> > > only 32MB  of RAM and 70MB of swap) I get poor performance once
> > > extensive use is made of the swap space.
> >
> > 
> > Could you try the patch Con Kolivas posted on the 25th ?
> > 
> > Subject: [PATCH] Autoregulate vm swappiness cleanup
>
> 
> I suppose it will show some improvement but fail to get performance
> anywhere near 2.4 -- at least that's what my own tests found. I've been
> working on a break-down of where we're losing it.
> Bottom line: It's not simply a price we pay for feature X or Y. It's
> all over the map, and thus no single patch can possibly fix it.

With 2.6 its possible to tell the kernel how much to swap.  Con's patch
tries to keep applications in memory.  You can also play with 
/proc/sys/vm/swappiness which is what Con's patch tries to replace.

Ed Tomlinson
