Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWGCREd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWGCREd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWGCREd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:04:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61083 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751009AbWGCREc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:04:32 -0400
Date: Mon, 3 Jul 2006 10:00:40 -0700
From: Greg KH <gregkh@suse.de>
To: Andy Gay <andy@andynet.net>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, Ken Brush <kbrush@gmail.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO transfers
Message-ID: <20060703170040.GA15315@suse.de>
References: <1151646482.3285.410.camel@tahini.andynet.net> <adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151872141.3285.486.camel@tahini.andynet.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 04:29:01PM -0400, Andy Gay wrote:
> On Sun, 2006-07-02 at 11:48 -0700, Roland Dreier wrote:
> > this works well on my kyocera kpc650 -- throughput is up to about 1
> > mbit/sec vs. ~250 kbit/sec with the stock airprime driver.
> > -
> Thanks for the feedback.
> 
> I'm working on fixing the concerns Andrew Morton expressed regarding
> memory leaks in the open function. I'll send an updated driver soon.
> 
> BTW - Jeremy suggested that the number of EPs to configure should be
> determined from the device ID. Makes sense to me, but then many users
> may have no use for the additional EPs. Alternatively, Greg suggested
> that maybe this should split into 2 drivers. Any preferences, anyone?

Yes, this driver is already split into 2 different ones (look in the
recent -mm releases).  Sierra wants to have their devices be in their
own driver, as the chip is a little different from the other ones.  This
means that those devices are now controlled by a driver called "sierra"
and the other devices still are working with the airprime driver.

This should hopefully fix the different endpoint issue, and allow new
devices to be supported properly, as Sierra Wireless is now maintaining
that driver.

Hope this helps,

greg k-h
