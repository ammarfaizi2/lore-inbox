Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUALVNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUALVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:13:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30599 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265658AbUALVNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:13:01 -0500
Date: Mon, 12 Jan 2004 22:12:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Doug Ledford <dledford@redhat.com>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Peter Yao <peter@exavio.com.cn>,
       linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112211249.GB3543@suse.de>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com> <20040112151230.GB5844@devserv.devel.redhat.com> <20040112194829.A7078@infradead.org> <1073937102.3114.300.camel@compaq.xsintricity.com> <20040112200351.A7409@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112200351.A7409@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12 2004, Christoph Hellwig wrote:
> On Mon, Jan 12, 2004 at 02:51:42PM -0500, Doug Ledford wrote:
> > More or less.  But part of it also is that a lot of the patches I've
> > written are on top of other patches that people don't want (aka, the
> > iorl patch).
> 
> I'm wondering whether we want it now that 2.4 is basically frozen, but
> I don't think there was a strong case against it say 4 or 5 month ago.
> OTOH given that success (or lack thereof) I had pushing core changes
> through Marcelo the chances it had even if scsi folks ACKed wouldn't
> have been too high.

That's the key point, is it appropriate to merge now...

But I can completely back Doug on the point he made wrt pusing stuff
back to mainline - it was hard, because we deviated too much. And that
is also what I stressed would be the most important argument for merging
the iorl + scsi core changes.

> > I've got a mlqueue patch that actually *really* should go
> > into mainline because it solves a slew of various problems in one go,
> > but the current version of the patch depends on some semantic changes
> > made by the iorl patch.  So, sorting things out can sometimes be
> > difficult.  But, I've been told to go ahead and do what I can as far as
> > getting the stuff out, so I'm taking some time to try and get a bk tree
> > out there so people can see what I'm talking about.  Once I've got the
> > full tree out there, then it might be possible to start picking and
> > choosing which things to port against mainline so that they don't depend
> > on patches like the iorl patch.
> 
> I personally just don't care enough about 2.4 anymore, so I don't think
> I'll invest major amounts of time into it.  Even though the scsi changes
> you've done are fairly huge I'm wondering whether we should just throw
> it all in anyway - given that you said you'll have to care for the 2.4
> scsi stack for a longer time for RH and no one else seems to be interested
> doing maintaince.

Ditto.

-- 
Jens Axboe

