Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265435AbUEUIGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbUEUIGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265456AbUEUIGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:06:11 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:33183 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265435AbUEUIGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:06:06 -0400
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
From: FabF <Fabian.Frederick@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40ADB671.8060904@yahoo.com.au>
References: <1085124268.8064.15.camel@bluerhyme.real3>
	 <40ADB20C.8090204@yahoo.com.au> <1085125564.8071.23.camel@bluerhyme.real3>
	 <40ADB671.8060904@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1085126738.8071.32.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 May 2004 10:05:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-21 at 09:57, Nick Piggin wrote:
> FabF wrote:
> > On Fri, 2004-05-21 at 09:38, Nick Piggin wrote:
> > 
> >>FabF wrote:
> >>
> >>>Jens,
> >>>
> >>>	Here's ff1 patchset to have generic I/O context.
> >>>ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
> >>>ff2 : Make io_context generic plateform by importing IO stuff from
> >>>as_io.
> >>>
> >>
> >>Can I just ask why you want as_io_context in generic code?
> >>It is currently nicely hidden away in as-iosched.c where
> >>nobody else needs to ever see it.
> > 
> > I do want I/O context to be generic not the whole as_io.
> > That export should bring:
> > 	-All elevators to use io_context
> > 	-source tree to be more self-explanatory
> > 	-have a stronger elevator interface
> > 
> 
> Sorry, my mistake. as_io_context is not nicely hidden away at
> the moment. I can't remember why, I think it is only needed
> for the declaration... I'll look into moving it into as-iosched.c
> 
> *But*, io_context is already exported to all elevators and generic
> code.

Well ff1 does that "concept split".We have
	-Elevator
	-Elevator interface
	-I/O context 
	-Block management

As none of you seems OK with further changes, I'll stop my effort right
here but keep thinking ff1 is good :)

Regards,
FabF

