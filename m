Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTIRLWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbTIRLWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:22:16 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:6076 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261153AbTIRLWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:22:15 -0400
X-Sender-Authentication: net64
Date: Thu, 18 Sep 2003 13:22:12 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jens Axboe <axboe@suse.de>
Cc: marcelo.tosatti@cyclades.com.br, alan@lxorguk.ukuu.org.uk,
       galibert@limsi.fr, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030918132212.4b639f6c.skraw@ithnet.com>
In-Reply-To: <20030918071249.GT906@suse.de>
References: <20030917191946.GQ906@suse.de>
	<Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet>
	<20030918070845.GS906@suse.de>
	<20030918071249.GT906@suse.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003 09:12:49 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Thu, Sep 18 2003, Jens Axboe wrote:
> > On Wed, Sep 17 2003, Marcelo Tosatti wrote:
> > > 
> > > 
> > > On Wed, 17 Sep 2003, Jens Axboe wrote:
> > > 
> > > > On Wed, Sep 17 2003, Alan Cox wrote:
> > > > > On Maw, 2003-09-16 at 20:58, Olivier Galibert wrote:
> > > > > > On Tue, Sep 16, 2003 at 04:29:02PM +0100, Alan Cox wrote:
> > > > > > > The kernel has no idea what you will do with given ram. It does
> > > > > > > try to make some guesses but you are basically trying to paper
> > > > > > > over hardware limits.
> > > > > > 
> > > > > > Is there a way to specifically turn that ram into a tmpfs though?
> > > > > 
> > > > > 
> > > > > Something like z2ram copied and hacked a little to kmap the blocks it
> > > > > wants would give you a block device you could use for swap or for
> > > > > /tmp. Im not sure tmpfs would work here
> > > > 
> > > > Aditionally, you need GFP_DMA32 or similar. Would also alleviate the
> > > > nasty pressure on ZONE_NORMAL which is often quite stressed.
> > > 
> > > IMO such GFP_DMA32 flag is a bit intrusive for 2.4, isnt it?
> > 
> > Not really, it's just an extra zone. Maybe I can dig such a patch up, I
> > had one for 2.4.2-pre something...
> 
> This is the latest I had, for 2.4.5. Pretty simple and nonintrusive at
> that time.

>From a design point of view I would pretty much agree with your idea. In fact
there is a ram attribute (dma32) which currently is not reflected in the data
structures in a selectable way. I can see no good reason for this lack.

Regards,
Stephan

