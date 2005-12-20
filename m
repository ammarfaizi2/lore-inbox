Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVLTTHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVLTTHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVLTTHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:07:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:336 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751029AbVLTTHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:07:00 -0500
Date: Tue, 20 Dec 2005 20:08:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
Message-ID: <20051220190836.GR3734@suse.de>
References: <20051219195014.GA13578@swissdisk.com> <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org> <20051220174948.GP3734@suse.de> <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org> <20051220183857.GQ3734@suse.de> <Pine.LNX.4.64.0512201049270.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201049270.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2005, Linus Torvalds wrote:
> 
> 
> On Tue, 20 Dec 2005, Jens Axboe wrote:
> > 
> > There _was_ a bug in the SCSI layer, because it had logic like this:
> > 
> >         if (rq_data_dir(req) == WRITE)
> >                 DMA_TO_DEVICE
> >         else if (req->data_len)
> >                 DMA_FROM_DEVICE
> >         else
> >                 DMA_NONE
> > 
> > which was buggy, because for it to transfer data to the device, both the
> > direction bit _and_ a data length must be set.
> 
> So this is fixed? Is that the iPod panic fix, or something else?

Yes it's fixed, James merged the fix(es) with you last week.

> If so, I'll drop that patch (although the "allow_removal" part of it 
> sounds sane to me still.. comments?)

I guess that's fine with me, the only thing I reject to is the 0x01 bit.

-- 
Jens Axboe

