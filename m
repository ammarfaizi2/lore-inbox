Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVHBHUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVHBHUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVHBHUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:20:03 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:53149 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261403AbVHBHSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:18:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: dynamic ticks for 2.6.13-rc4 & bad gzip
Date: Tue, 2 Aug 2005 17:21:21 +1000
User-Agent: KMail/1.8.1
Cc: tony@muru.com, linux-kernel@vger.kernel.org
References: <200508021124.15670.kernel@kolivas.org> <20050802071035.GF15903@atomide.com>
In-Reply-To: <20050802071035.GF15903@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508021721.21232.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 05:10 pm, Tony Lindgren wrote:
> * Con Kolivas <kernel@kolivas.org> [050801 18:24]:
> > Hi Tony, LKML
> >
> > Since there appears to be renewed interest of late in dynamic ticks...
> >
> > You didn't respond with my last patch for dynamic ticks so I assume
> > that's because you threw up when you saw what a mess it is. Anyway I'm
> > sorry for sending you that naive mess the first time around.
>
> Hehe, my strategy of lame response and sloppy patches seems to be working
> then! :)

Yes you must have learnt from akpm :P He's a master of that game. Thanks for 
replying :)

> > Here is a full patch for 2.6.13-rc4 pushing code out of common paths and
> > into dyn-tick.h where possible that builds on any config I can throw on
> > it so far. I'm having trouble with "bad gzip magic" on boot with this one
> > so I'm not really sure what's going on. Perhaps someone on the mailing
> > list can shed some light on it.
>
> Thanks a lot, I really appreciate help on getting this thing cleaned up for
> x86 + PPC. The ARM version is already merged to mainline, but that's did
> not have all the legacy issues, and ARM has nice sys_timer...

You're welcome, but I'm no coding expert and just applying a few styling 
issues as I see them.

> I'll try out your patch today at some point, and will post a merged patches
> that also integrate the PPC support.

> I don't understand the "bad gzip magic", that happens while uncompressing
> before kernel boots, right?

Yeah, bzImage has some convoluted way of storing the gunzip code in the header 
and then it decompresses the image. This error implies something went 
horribly wrong but I have seen it before occasionally with gcc 4.0.1 - it 
usually goes away with reconfigure/rebuilding but this one didn't. Probably 
not important for this code per se.

Cheers,
Con
