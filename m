Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265465AbRFVQjC>; Fri, 22 Jun 2001 12:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265467AbRFVQiw>; Fri, 22 Jun 2001 12:38:52 -0400
Received: from smarty.smart.net ([207.176.80.102]:25608 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S265465AbRFVQip>;
	Fri, 22 Jun 2001 12:38:45 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200106221649.MAA11881@smarty.smart.net>
Subject: Re: mktime in include/linux
To: jlundell@pobox.com (Jonathan Lundell)
Date: Fri, 22 Jun 2001 12:49:19 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p05100301b759107790aa@[207.213.214.37]> from "Jonathan Lundell" at Jun 22, 2001 08:16:19 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> At 1:43 PM +0200 2001-06-22, Erik Mouw wrote:
> >On Thu, Jun 21, 2001 at 10:30:40PM -0400, Rick Hohensee wrote:
> >>  Why does Linux have a mktime routine fully coded in linux/time.h that
> >>  conflicts directly with the ANSI C standard library routine of the same
> >>  name? It breaks a couple things against libc5, including gcc 3.0. OK, you
> >>  don't care about libc5. It's still pretty weird. Wierd? Weird.
> >
> >This has been brought up many times on this list: you are not supposed
> >to include kernel headers in userland.
> 
> That's not the problem, I think. Most of time.h, including the 
> definition of mktime, is #ifdef __KERNEL__, so it shouldn't be 
> breaking anything in userland even if you do include it. And you 
> might, in order to obtain the interface definition of struct 
> timespec. What's weird is: why is __KERNEL__ getting #defined in 
> Rick's userland?
> 
> There can't, of course, be any blanket prohibition against using 
> kernel headers in userland. Think about ioctl.h, for example.

Sounds like a clue. Thanks.

Rick

> -- 
> /Jonathan Lundell.
> 

