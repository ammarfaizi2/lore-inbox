Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTIZUZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTIZUZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:25:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22185
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261623AbTIZUZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:25:20 -0400
Date: Fri, 26 Sep 2003 22:26:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: marcelo@parcelfarce.linux.theplanet.co.uk
Cc: Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030926202644.GI9953@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <Pine.LNX.4.44.0309251436320.30864-100000@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309251436320.30864-100000@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 02:40:15PM +0100, marcelo@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, 22 Sep 2003, Andrea Arcangeli wrote:
> 
> > Hi,
> > 
> > I'm rejecting on the log-buf-len feature in 2.4.23pre5, the code in
> > mainline is worthless for any distributor, shipping another rpm package
> > just for the bufsize would be way overkill.
> 
> Andrea,
> 
> As Willy stated previously this is useful for people who want to change 
> the log buf size without having to change the code manually, and I think 
> this is a useful and non intrusive change.
> 
> Do you see any problem with this? 

as wrote in a later email, technically the dynamic solution obsoletes
the static one, but only as far as the kernel is concerned.

It happens that to enable the dynamic solution you've to change 1 line
to lilo.conf/grub.lst. since 2.4 is already being used in production
distributed scenarios, there is at least a psycology value in providing
a static solution that doesn't involve lilo.conf changes, so people can
deploy the feature without having to edit conf files at all (with grub
they don't need to run lilo either).

So I will rewrite my patch in a way that doesn't reject the static
setting for next -aa (together with some other tons of pending things,
but the vm merge is already completed on my tree, so I'm in sync again
with pre5 on that side and that was top priority to fixup to be sure
nothing was missing, thanks for merging the watermarks already btw ;).

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
