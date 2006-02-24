Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWBXT3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWBXT3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBXT3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:29:48 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:45070 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932435AbWBXT3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:29:47 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64 stack trace cleanup
Date: Fri, 24 Feb 2006 19:25:17 +0000
User-Agent: KMail/1.9.1
Cc: Andres Salomon <dilinger@debian.org>, linux-kernel@vger.kernel.org
References: <1140777679.5073.17.camel@localhost.localdomain> <1140780552.5073.26.camel@localhost.localdomain> <200602241322.28389.ak@suse.de>
In-Reply-To: <200602241322.28389.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241925.17997.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 12:22, Andi Kleen wrote:
> On Friday 24 February 2006 12:29, Andres Salomon wrote:
> > That would be nice.  Unfortunately, I'm trying to figure out why my dual
> > opteron box likes to push the load up to 15 and then hang while doing
> > i/o to the 3ware 9500S-8 card.  Looks like the load/d-state processes
> > are caused by a whole lot (well, MAX_PDFLUSH_THREADS) of pdflush
> > processes spinning on base->lock in lock_timer_base(); not sure if
> > that's intentional or not, but it seems rather odd.  Whether the hanging
> > is related to the high load remains to be seen.
>
> Sounds like some timer handler is broken. You have to find out which
> one it is.
>
> > I don't see why this is a problem.  Other architectures have done this
> > for ages, without problems.  I suspect most people get their backtraces
> > from either serial console or logs, as copying them down from the screen
> > or taking a picture of the panic is a rather large pain.  It seems like
> > you're penalizing everyone for a few select use cases.
>
> People submitting jpegs of photographed oopses or even badly scribbled
> down oopses is quite common. Serial consoles are only used by a small
> elite.

I agree, I've had to report using a JPEG file on multiple occasions, because 
my mainboard has no serial ports. However, if you're using a 1280x1024 
vesafb, which is supported by most systems, you can get a lot of lines on 
screen at once..

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
