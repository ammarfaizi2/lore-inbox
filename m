Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUIJXkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUIJXkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUIJXkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:40:47 -0400
Received: from [69.28.190.101] ([69.28.190.101]:53457 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268029AbUIJXkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:40:46 -0400
Date: Fri, 10 Sep 2004 19:40:44 -0400
From: David Eger <eger@havoc.gtf.org>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Message-ID: <20040910234044.GA30180@havoc.gtf.org>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com> <20040910175202.GA11054@havoc.gtf.org> <200409110527.05516.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409110527.05516.adaplas@hotpop.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 05:27:05AM +0800, Antonino A. Daplas wrote:
> On Saturday 11 September 2004 01:52, David Eger wrote:
> > On Fri, Sep 10, 2004 at 01:28:57PM +0800, Antonino A. Daplas wrote:
> > > On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> > > > Recent changes upstream are breaking fbdev on pmacs.
> > > >
> > > > From what I see, it seems that offb is kicking in by default, reserves
> > > > the mmio regions, and then whatever chip driver loads can't access
> > > > them.
> > > >
> > > > offb is supposed to be a "fallback" driver in case no fbdev is taking
> > > > over, it should also be "forced" in with video=ofonly kernel command
> > > > line. This logic has been broken.
> >
> > I *hope* this is what I'm seeing with recent kernels, though I
> > have my doubts....  What I *do* know is that with recent bk snapshots
> > (post bk-1.2115) I have the following:  radeonfb seems to load, but when I
> > try to load X, my y-resolution seems to be half of what it ought to be...
> 
> X-fbdev, or X + native radeon driver?  Do still get a framebuffer console?
> Any other fb apps you have that's also broken?

Hold my tongue: BenH's latest patch (already in mainline) fixes it for me.

-David
