Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVARJvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVARJvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 04:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVARJvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 04:51:13 -0500
Received: from colin2.muc.de ([193.149.48.15]:34063 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261211AbVARJvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 04:51:10 -0500
Date: 18 Jan 2005 10:51:09 +0100
Date: Tue, 18 Jan 2005 10:51:09 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Support compat_ioctl for block devices
Message-ID: <20050118095109.GA22705@muc.de>
References: <20050118075602.GD76018@muc.de> <20050118091927.GA24768@infradead.org> <20050118093158.GB20002@muc.de> <20050118093645.GA24935@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118093645.GA24935@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 09:36:45AM +0000, Christoph Hellwig wrote:
> On Tue, Jan 18, 2005 at 10:31:58AM +0100, Andi Kleen wrote:
> > >  - please don't introduce a new API with the BKL held.
> > 
> > Nope, I'm not going to audit zillions of low level functions for this.
> 
> So just stick a lock_kernel() unlock_kernel() into the handler, it's
> not like there's more than a handfull of them.

Hmm, possible, although it tends to be quite ugly (requiring
either gotos or wrappers). But ok.

> 
> > >  - prototype isn't nice.  just passing the gendisk for block_device
> > >    should be enough.
> > 
> > No, it isn't, the compat handler needs cmd and arg, and file is useful
> > when you pass it to an existing ioctl handler.
> 
> cmd/arg is needed, file shouldn't.  If you care for the underlying handler
> add a version that doesn't take the file * either.

Sorry, that didn't make any sense.  

-Andi
