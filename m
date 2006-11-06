Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753331AbWKFQFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbWKFQFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbWKFQFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:05:25 -0500
Received: from brick.kernel.dk ([62.242.22.158]:47460 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1753331AbWKFQFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:05:24 -0500
Date: Mon, 6 Nov 2006 17:07:31 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: SCSI over USB showstopper bug?
Message-ID: <20061106160731.GZ13555@kernel.dk>
References: <4547c966.8oyAB/pzCZ7bGUza%Joerg.Schilling@fokus.fraunhofer.de> <1162333090.3044.53.camel@laptopd505.fenrus.org> <4547e164.k3W0GpiCAd3p3Tkh%Joerg.Schilling@fokus.fraunhofer.de> <20061101153128.GM13555@kernel.dk> <4548e680.oVsI92sKYOz7VSzN%Joerg.Schilling@fokus.fraunhofer.de> <20061101183132.GO13555@kernel.dk> <454f5c12.CD9M9/FtHNVm1oDq%Joerg.Schilling@fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454f5c12.CD9M9/FtHNVm1oDq%Joerg.Schilling@fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06 2006, Joerg Schilling wrote:
> Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > > Then someone should change the source to match this statements.
> > > 
> > > From a report I have from the k3b Author, readcd and cdda2wav only work
> > > if you add a "ts=128k" option. 
> >
> > Then please file (or have him/her file) a proper bug report. It may be a
> > usb specific bug, or it may just be something else.
> 
> To me, it looks like a problem that happens with usb because there is 
> no proper interaction with SG_?ET_RESETVED_SIZE and the usb layer.

The limits are communicated from the usb layer to the block layer via
the SCSI layer, by setting proper limits in the scsi host adapter
template. SCSI then informs the block layer, by setting the appropriate
limits on the queue. Perhaps there's a usb-storage bug there, who knows,
so far there's been no real info posted.

> I am still in hope that someone will fix this soon.

Someone may very well fix it, but the odds of that happening when a real
bug report exists is a lot bigger. Who reported this issue to you? Get
him/her to file a proper bug report, as I wrote in my last mail as well.

-- 
Jens Axboe

