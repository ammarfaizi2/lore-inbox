Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUALPNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUALPMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:12:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266144AbUALPMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:12:32 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Martin Peschke3 <MPESCHKE@de.ibm.com>,
       Arjan Van de Ven <arjanv@redhat.com>, Peter Yao <peter@exavio.com.cn>,
       linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <20040112141330.GH24638@suse.de>
References: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
	 <20040112141330.GH24638@suse.de>
Content-Type: text/plain
Message-Id: <1073920110.3114.268.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 12 Jan 2004 10:08:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 09:13, Jens Axboe wrote:
> On Mon, Jan 12 2004, Martin Peschke3 wrote:
> > Hi,
> > 
> > is there a way to merge all (or at least the common denominator) of
> > Redhat's and SuSE's changes into the vanilla 2.4 SCSI stack?
> > The SCSI part of Marcelo's kernel seems to be rather backlevel,
> > considering all those fixes and enhancements added by the mentioned
> > distributors and their SCSI experts. As this discussion underlines,
> > there are a lot of common problems and sometimes even common
> > approaches.  I am convinced that a number of patches ought to be
> > incorporated into the mainline kernel. Though, I must admit
> > that I am at a loss with how this could be achieved given the
> > unresolved question of 2.4 SCSI maintenance
> > (which has certainly played a part in building up those piles
> > of SCSI patches).
> 
> I have mixed feelings about that. One on side, I'd love to merge the
> scalability patches in mainline. We've had a significant number of bugs
> in this area in the past, and it seems a shame that we all have to fix
> them independently because we deviate from mainline.

Agreed (I've had to fix the iorl patch 3 or 4 times for things that
weren't bugs in the iorl patch until mainline got updated with a new
lock somewhere or things like that).

>  On the other hand,
> 2.4 is pretty much closed. There wont be a big number of new distro 2.4
> kernels.
> 
> Had you asked me 6 months ago I probably would have advocated merging
> them, but right now I think it's a waste of time.

>From my standpoint, we are going to be maintaining our 2.4 kernel RPMs
for a long time, so my preference is to have it in mainline.  On top of
the performance stuff I have also been building some actual bug fix
patches.  They depend on the behavior of the patched kernels, and in
some cases would be difficult to put on top of a non-iorl patched scsi
stack.  In any case, my current plans include putting my 2.4 scsi stack
stuff up for perusal on linux-scsi.bkbits.net/scsi-dledford-2.4 as soon
as I can sort through the patches and break them into small pieces.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


