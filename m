Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275108AbTHLIvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 04:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275124AbTHLIvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 04:51:41 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:777 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S275108AbTHLIvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 04:51:39 -0400
Date: Tue, 12 Aug 2003 10:51:37 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops in sd_shutdown
Message-ID: <20030812085137.GA6168@win.tue.nl>
References: <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher> <20030812002844.B1353@pclin040.win.tue.nl> <20030812075353.A18547@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812075353.A18547@infradead.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 07:53:53AM +0100, Christoph Hellwig wrote:

> > I see an Oops in the SCSI code, caused by the fact that sdkp is NULL
> > in sd_shutdown. "How can that be?", you will ask - dev->driver_data was set
> > in sd_probe. But in my case sd_probe never finished. An insmod usb-storage
> > hangs forever, or at least for more than six hours, giving ample opportunity
> > to observe this race between sd_probe and sd_shutdown.
> > (Of course sd_probe hangs in sd_revalidate disk.)
> 
> Well, this same problem could show upb in any other driver.  Could
> you instead send a patch to Pat that the driver model never calls
> the shutdown method for a driver that hasn't finished ->probe?

Yes, that is the next stage. But it takes a few hours instead of a
few seconds.


