Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbTIQWSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTIQWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:18:44 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:15503 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262910AbTIQWSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:18:42 -0400
X-Sender-Authentication: net64
Date: Thu, 18 Sep 2003 00:18:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: axboe@suse.de, alan@lxorguk.ukuu.org.uk, galibert@limsi.fr,
       marcelo.tosatti@cyclades.com.br, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030918001840.44b83c80.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet>
References: <20030917191946.GQ906@suse.de>
	<Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003 16:30:45 -0300 (BRT)
Marcelo Tosatti <marcelo.tosatti@cyclades.com.br> wrote:

> 
> 
> On Wed, 17 Sep 2003, Jens Axboe wrote:
> 
> > On Wed, Sep 17 2003, Alan Cox wrote:
> > > On Maw, 2003-09-16 at 20:58, Olivier Galibert wrote:
> > > > On Tue, Sep 16, 2003 at 04:29:02PM +0100, Alan Cox wrote:
> > > > > The kernel has no idea what you will do with given ram. It does try
> > > > > to make some guesses but you are basically trying to paper over
> > > > > hardware limits.
> > > > 
> > > > Is there a way to specifically turn that ram into a tmpfs though?
> > > 
> > > 
> > > Something like z2ram copied and hacked a little to kmap the blocks it
> > > wants would give you a block device you could use for swap or for /tmp.
> > > Im not sure tmpfs would work here
> > 
> > Aditionally, you need GFP_DMA32 or similar. Would also alleviate the
> > nasty pressure on ZONE_NORMAL which is often quite stressed.
> 
> IMO such GFP_DMA32 flag is a bit intrusive for 2.4, isnt it?
> 
> What has been done in 2.6 in respect to the excessive normal zone 
> pressure and bounce buffering problems? 
> 
> Thanks 

Before running too far in this direction I would suggest to solve Oliviers'
problem with the aic driver. I really would like to know if he sees the same
positive effects in pre4 like me. It seems Andreas' vm patches have a very
positive influence on the issue. At least I cannot see the "crawling effect" up
to now with 6GB and pre4 compared to 2.4.22. It would surely be of interest
if Oliviers' 8 GB variant improves, too.
May well be that the bouncing is not that bad compared to other corner effects
of the vm in this special situation.
Interactivity during load and especially network seems far better in pre4. For
sure it is not as speedy as a 4GB setup, but it works pretty well (up to now).

Regards,
Stephan

