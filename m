Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSKRU4z>; Mon, 18 Nov 2002 15:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264808AbSKRU4z>; Mon, 18 Nov 2002 15:56:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62733 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264806AbSKRU4x>; Mon, 18 Nov 2002 15:56:53 -0500
Date: Mon, 18 Nov 2002 16:02:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dan Kegel <dank@kegel.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
In-Reply-To: <3DD6DE32.60503@kegel.com>
Message-ID: <Pine.LNX.3.96.1021118155234.27535C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002, Dan Kegel wrote:

> Alan Cox wrote:
> >>>Em Sat, Nov 16, 2002 at 04:04:05PM -0500, Jeff Garzik escreveu:
> >>>
> >>>>About the only thing WRT menuconfig I would be ok with is commenting out 
> >>>>majorly broken drivers until they are fixed...
> > 
> > Thats basically what "OBSOLETE" is
> 
> So how 'bout this:
> 
> * mark all drivers that don't compile OBSOLETE.  That keeps us from
>    trying to fix drivers without having hardware to test them.
>    Anyone with proper hardware is invited to fix the drivers and then
>    mark them non-OBSOLETE.

I would suggest that we not cause kconfig to attach a new, possibly
misleading, meaning to the terms OBSOLETE and BROKEN. Therefore I would
offer this nomenclature instead.

OBSOLETE - the code in question provides either support for a no longer
easily available hardware, or better software to support the hardware (or
feature) is available. It does not mean that the feature is known not to
work, just that there are alternatives.

BROKEN - the code in question is known not to work, may not compile. It
can be read as FIXME invitation.

Lots of people would immediately reject the idea of writing a driver from
scratch (including me, unless paid to do so), but at least some of those
who need working code might be willing to take the time to fix an existing
driver (or feature).

Two different concepts, and probably a good way to provide a quick "things
to do" list every time someone configures a kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

