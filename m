Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTIQTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTIQTU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:20:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2454 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262882AbTIQTUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:20:25 -0400
Date: Wed, 17 Sep 2003 21:19:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Olivier Galibert <galibert@limsi.fr>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030917191946.GQ906@suse.de>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030916172057.148a5741.skraw@ithnet.com> <1063726141.10036.130.camel@dhcp23.swansea.linux.org.uk> <20030916195858.GC68728@dspnet.fr.eu.org> <1063811445.12648.69.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063811445.12648.69.camel@dhcp23.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17 2003, Alan Cox wrote:
> On Maw, 2003-09-16 at 20:58, Olivier Galibert wrote:
> > On Tue, Sep 16, 2003 at 04:29:02PM +0100, Alan Cox wrote:
> > > The kernel has no idea what you will do with given ram. It does try to
> > > make some guesses but you are basically trying to paper over hardware
> > > limits.
> > 
> > Is there a way to specifically turn that ram into a tmpfs though?
> 
> 
> Something like z2ram copied and hacked a little to kmap the blocks it
> wants would give you a block device you could use for swap or for /tmp.
> Im not sure tmpfs would work here

Aditionally, you need GFP_DMA32 or similar. Would also alleviate the
nasty pressure on ZONE_NORMAL which is often quite stressed.

-- 
Jens Axboe

