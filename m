Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUIIOhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUIIOhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUIIOhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:37:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29910 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264984AbUIIOfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:35:52 -0400
Date: Thu, 9 Sep 2004 16:34:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in md write barrier support?
Message-ID: <20040909143434.GA1737@suse.de>
References: <20040904082121.GB2343@suse.de> <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de> <1094650500.11723.32.camel@localhost.localdomain> <20040908154608.GN2258@suse.de> <1094682098.12280.19.camel@localhost.localdomain> <20040909080612.GJ1737@suse.de> <1094718179.2801.3.camel@laptop.fenrus.com> <20040909082922.GN1737@suse.de> <1094734272.14623.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094734272.14623.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2004, Alan Cox wrote:
> On Iau, 2004-09-09 at 09:29, Jens Axboe wrote:
> > > why does this seem broken? semantics of "cache flush guarantees that all
> > > io submitted prior to it hits the spindle" are quite sane imo; no
> > > guarantee of later submitted IO.. compare the unix "sync" command; same
> > > level of semantics.
> > 
> > Depends on your angle, I think it breaks the principle of least
> > surprise.
> 
> As far as I can ascertain raid controllers in general follow this set of
> semantics. Its less of an issue for many of them with battery backup
> obviously.
> 
> It also makes a lot of sense at the hardware level for performance
> especially when dealing with raid.

Yes. As long as the required semantics aren't explicitly guaranteed in
the specification, we should not rely on it.

-- 
Jens Axboe

