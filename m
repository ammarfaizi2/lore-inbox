Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUEUISh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUEUISh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265430AbUEUISg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:18:36 -0400
Received: from outmx011.isp.belgacom.be ([195.238.3.3]:738 "EHLO
	outmx011.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265410AbUEUISe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:18:34 -0400
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
From: FabF <Fabian.Frederick@skynet.be>
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040521075342.GP1952@suse.de>
References: <1085124268.8064.15.camel@bluerhyme.real3>
	 <40ADB20C.8090204@yahoo.com.au> <1085125564.8071.23.camel@bluerhyme.real3>
	 <20040521075342.GP1952@suse.de>
Content-Type: text/plain
Message-Id: <1085127480.8064.42.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 May 2004 10:18:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-21 at 09:53, Jens Axboe wrote:
> On Fri, May 21 2004, FabF wrote:
> > On Fri, 2004-05-21 at 09:38, Nick Piggin wrote:
> > > FabF wrote:
> > > > Jens,
> > > > 
> > > > 	Here's ff1 patchset to have generic I/O context.
> > > > ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
> > > > ff2 : Make io_context generic plateform by importing IO stuff from
> > > > as_io.
> > > > 
> > > 
> > > Can I just ask why you want as_io_context in generic code?
> > > It is currently nicely hidden away in as-iosched.c where
> > > nobody else needs to ever see it.
> > I do want I/O context to be generic not the whole as_io.
> > That export should bring:
> > 	-All elevators to use io_context
> 
> For?

Well I was completely wrong :( ll_rw_blk uses i/o context all over the
place so all elv do as well ... You're right Jens, the only good thing
to do there would be to extract anticipation.

Regards,
FabF


