Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRHaPoy>; Fri, 31 Aug 2001 11:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbRHaPon>; Fri, 31 Aug 2001 11:44:43 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:9385 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S266864AbRHaPoc>;
	Fri, 31 Aug 2001 11:44:32 -0400
Date: Fri, 31 Aug 2001 17:43:55 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andreas Dilger <adilger@turbolabs.com>
cc: "Kevin P. Fleming" <kevin@labsysgrp.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable
In-Reply-To: <20010831093109.R541@turbolinux.com>
Message-ID: <Pine.LNX.4.21.0108311742410.20914-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001, Andreas Dilger wrote:

> On Aug 30, 2001  21:23 -0700, Kevin P. Fleming wrote:
> > OK, I see that now... and it looks like the risks associated with setting
> > the unmaskirq flags on my drives (none of the four drives have it set now)
> > are too great to be worth playing with it. I'll just not use my PPP
> > connection during these particularly heavy disk activity moments. Thanks for
> > the quick response.
> 
> There was a kernel patch (or possibly a user-space tool) which allowed
> one to change the "priority" of IRQs and their handlers.  This was back
> in the 1.2 or 2.0 days, when _any_ disk or other interrupt activity might
> be enough to cause problems for serial connections (especially if you
> only had a 16450 UART (1 byte buffer) instead of a 16550 (16 byte buffer).
> You could make your serial interrupt (handler) take priority over disk
> interrupts.
> 
> Maybe Ted Ts'o or other long-time Linux folks will know what was actually
> called, and whether it is still applicable to modern hardware/kernel.

It was called irqtune, http://www.best.com/~cae/irqtune/
But I don't know if it still works with newer hardware/kernel

/Martin

