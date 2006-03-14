Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWCNR3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWCNR3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWCNR3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:29:38 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43204
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751506AbWCNR3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:29:37 -0500
Date: Tue, 14 Mar 2006 09:29:33 -0800
From: Greg KH <gregkh@suse.de>
To: Christoph Hellwig <hch@infradead.org>, "Moore, Eric" <Eric.Moore@lsil.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, hch@lst.de
Subject: Re: [PATCH ] drivers/base/bus.c - export reprobe
Message-ID: <20060314172933.GA24619@suse.de>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D829@NAMAIL2.ad.lsil.com> <20060314153455.GA8071@suse.de> <20060314170855.GA18342@infradead.org> <20060314171951.GA22678@suse.de> <20060314172543.GA20331@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314172543.GA20331@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 05:25:43PM +0000, Christoph Hellwig wrote:
> On Tue, Mar 14, 2006 at 09:19:51AM -0800, Greg KH wrote:
> > I saw the:
> > 
> > +       if (dev->driver) {^M
> > +               if (dev->parent)        /* Needed for USB */^M
> > +                       down(&dev->parent->sem);^M
> > 
> > portion and thought it came from USB core code somewhere.  Or are you
> > referring to the need for USB-storage here?
> 
> It's copied from a runtime close to this one in the driver core.
> Unfortunately it's not easily sharable so I duplicated those few lines.

Ah, ok, that makes more sense.

Eric, care to resend without the mime crud so I can apply it?

thanks,

greg k-h
