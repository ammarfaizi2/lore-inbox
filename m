Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbULUTVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbULUTVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbULUTVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:21:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:38863 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261355AbULUTVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:21:49 -0500
Date: Tue, 21 Dec 2004 11:20:45 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Scheduling while atomic (2.6.10-rc3-bk13)
Message-ID: <20041221192044.GC9093@kroah.com>
References: <20041219231015.GB4166@mail.muni.cz> <20041220184814.GA21215@kroah.com> <200412201152.16329.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412201152.16329.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 11:52:16AM -0800, David Brownell wrote:
> On Monday 20 December 2004 10:48 am, Greg KH wrote:
> 
> > 
> > David, it looks like you grab a spinlock, and then call msleep(20);
> > which causes this warning.
> > 
> > Care to fix it?
> 
> How bizarre ... I must have been tested that without spinlock
> debugging, for some reason.  Grr.  I usually leave that on,
> just to prevent stuff like this.
> 
> Here's a quick'n'dirty patch, msleep --> mdelay.  I'd rather
> not mdelay for that long, but this late in 2.6.10 it's safer.
> (And this is also what OHCI does in that same code path.)

Applied, thanks.

greg k-h
