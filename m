Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265332AbUEUHqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUEUHqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265419AbUEUHqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:46:42 -0400
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:705 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265332AbUEUHqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:46:40 -0400
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
From: FabF <Fabian.Frederick@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: axboe@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40ADB20C.8090204@yahoo.com.au>
References: <1085124268.8064.15.camel@bluerhyme.real3>
	 <40ADB20C.8090204@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1085125564.8071.23.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 May 2004 09:46:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-21 at 09:38, Nick Piggin wrote:
> FabF wrote:
> > Jens,
> > 
> > 	Here's ff1 patchset to have generic I/O context.
> > ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
> > ff2 : Make io_context generic plateform by importing IO stuff from
> > as_io.
> > 
> 
> Can I just ask why you want as_io_context in generic code?
> It is currently nicely hidden away in as-iosched.c where
> nobody else needs to ever see it.
I do want I/O context to be generic not the whole as_io.
That export should bring:
	-All elevators to use io_context
	-source tree to be more self-explanatory
	-have a stronger elevator interface

> 
> > 	AFAICS, cfq_queue for instance could disappear when using io_context
> > but I think elv_data should remain elevator side....
> > I don't want to go in the wild here so if you've got suggestions, don't
> > hesitate ;)
> > 
> 
> cfq_queue is per-queue-per-process. io_context is just
> per-process, so it isn't a trivial replacement.
But I guess we can merge that stuff to have "a one way, one place" code
rather than repeat code in all elv.

Regards,
FabF

