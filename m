Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVCHGiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVCHGiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVCHGgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:36:03 -0500
Received: from waste.org ([216.27.176.166]:51630 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261796AbVCHGfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:35:19 -0500
Date: Mon, 7 Mar 2005 22:35:04 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] unified device list allocator
Message-ID: <20050308063504.GN3120@waste.org>
References: <20050308051818.GI3120@waste.org> <20050307213302.560de053.akpm@osdl.org> <20050308054325.GA1262@infradead.org> <20050307215035.345c3f63.akpm@osdl.org> <20050308055627.GA1515@infradead.org> <20050308061155.GK3120@waste.org> <20050308063127.GA2475@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308063127.GA2475@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 06:31:27AM +0000, Christoph Hellwig wrote:
> On Mon, Mar 07, 2005 at 10:11:55PM -0800, Matt Mackall wrote:
> > >  - when called with the major argument as 0 it returns an unused major number
> > >    from the top of the old 255 entries major list.  This should be replaced
> > >    by a real dynamic dev_t allocator, similar to alloc_chrdev_region.
> > 
> > Umm, this replaces alloc_chrdev_region too. If instead you mean "let's
> > migrate all the users to a sensible interface", I agree. And that
> > means killing alloc_chrdev_region too. (baseminor makes no sense for
> > dynamic allocation - you either know your prefered major and minor or
> > you know neither.)
> 
> The thing is this blkdev_register useage should be replace by an API
> like alloc_chrdev_region.  I don't particularly care about the actual
> implementation.

Ok, I can work on a follow-up that does that.

-- 
Mathematics is the supreme nostalgia of our time.
