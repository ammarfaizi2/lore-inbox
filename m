Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUD2DNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUD2DNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUD2DMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:12:09 -0400
Received: from florence.buici.com ([206.124.142.26]:40838 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263020AbUD2DLB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:11:01 -0400
Date: Wed, 28 Apr 2004 20:10:59 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429031059.GA26060@buici.com>
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428193541.1e2cf489.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 07:35:41PM -0700, Andrew Morton wrote:
> Marc Singer <elf@buici.com> wrote:
> >
> > On Wed, Apr 28, 2004 at 06:57:20PM -0700, Andrew Morton wrote:
> > > Rik van Riel <riel@redhat.com> wrote:
> > > >
> > > >  IMHO, the VM on a desktop system really should be optimised to
> > > >  have the best interactive behaviour, meaning decent latency
> > > >  when switching applications.
> > > 
> > > I'm gonna stick my fingers in my ears and sing "la la la" until people tell
> > > me "I set swappiness to zero and it didn't do what I wanted it to do".
> > 
> > It does, but it's a bit too coarse of a solution.  It just means that
> > the page cache always loses.
> 
> That's what people have been asking for.  What are you suggesting should
> happen instead?

I'm thinking that the problem is that the page cache is greedier that
most people expect.  For example, if I could hold the page cache to be
under a specific size, then I could do some performance measurements.
E.g, compile kernel with a 768K page cache, 512K, 256K and 128K.  On a
machine with loads of RAM, where's the optimal page cache size?

