Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTIQT3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbTIQT3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:29:50 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:20755 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262572AbTIQT3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:29:49 -0400
Date: Wed, 17 Sep 2003 16:30:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Olivier Galibert <galibert@limsi.fr>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
In-Reply-To: <20030917191946.GQ906@suse.de>
Message-ID: <Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Sep 2003, Jens Axboe wrote:

> On Wed, Sep 17 2003, Alan Cox wrote:
> > On Maw, 2003-09-16 at 20:58, Olivier Galibert wrote:
> > > On Tue, Sep 16, 2003 at 04:29:02PM +0100, Alan Cox wrote:
> > > > The kernel has no idea what you will do with given ram. It does try to
> > > > make some guesses but you are basically trying to paper over hardware
> > > > limits.
> > > 
> > > Is there a way to specifically turn that ram into a tmpfs though?
> > 
> > 
> > Something like z2ram copied and hacked a little to kmap the blocks it
> > wants would give you a block device you could use for swap or for /tmp.
> > Im not sure tmpfs would work here
> 
> Aditionally, you need GFP_DMA32 or similar. Would also alleviate the
> nasty pressure on ZONE_NORMAL which is often quite stressed.

IMO such GFP_DMA32 flag is a bit intrusive for 2.4, isnt it?

What has been done in 2.6 in respect to the excessive normal zone 
pressure and bounce buffering problems? 

Thanks 

