Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268168AbSISNXc>; Thu, 19 Sep 2002 09:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268349AbSISNXb>; Thu, 19 Sep 2002 09:23:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14471 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268168AbSISNXT>;
	Thu, 19 Sep 2002 09:23:19 -0400
Date: Thu, 19 Sep 2002 15:27:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Altaparmakov <aia21@cantab.net>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
Message-ID: <20020919132724.GS31033@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk> <20020919094520.GB31033@suse.de> <20020919100831.GC31033@suse.de> <1032433110.26669.30.camel@irongate.swansea.linux.org.uk> <20020919111422.GD31033@suse.de> <1032442139.26712.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032442139.26712.34.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19 2002, Alan Cox wrote:
> On Thu, 2002-09-19 at 12:14, Jens Axboe wrote:
> > 2.5 is reorged big time it seems, pci_register_driver() ->
> > drier_attach() -> do_driver_attach() -> found_match() calls ->probe()
> > unconditionally...
> 
> That would appear to be a bug in the 2.5 driver layer then. I'd suggest
> fixing it there. Attempting to probe a device that already has a driver
> attached to it doesn't seem to make sense.

Agree. Pat?

-- 
Jens Axboe

