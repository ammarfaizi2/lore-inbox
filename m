Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbSISNWQ>; Thu, 19 Sep 2002 09:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268110AbSISNWQ>; Thu, 19 Sep 2002 09:22:16 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:45556
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267271AbSISNWP>; Thu, 19 Sep 2002 09:22:15 -0400
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Anton Altaparmakov <aia21@cantab.net>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020919111422.GD31033@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
	<E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
	<5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk>
	<20020919094520.GB31033@suse.de> <20020919100831.GC31033@suse.de>
	<1032433110.26669.30.camel@irongate.swansea.linux.org.uk> 
	<20020919111422.GD31033@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 14:28:59 +0100
Message-Id: <1032442139.26712.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 12:14, Jens Axboe wrote:
> 2.5 is reorged big time it seems, pci_register_driver() ->
> drier_attach() -> do_driver_attach() -> found_match() calls ->probe()
> unconditionally...

That would appear to be a bug in the 2.5 driver layer then. I'd suggest
fixing it there. Attempting to probe a device that already has a driver
attached to it doesn't seem to make sense.

