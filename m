Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSKFAcJ>; Tue, 5 Nov 2002 19:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265459AbSKFAcJ>; Tue, 5 Nov 2002 19:32:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40713 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265457AbSKFAcG>; Tue, 5 Nov 2002 19:32:06 -0500
Date: Tue, 5 Nov 2002 19:38:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jos Hulzink <josh@stack.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 build failed with ACPI turned on
In-Reply-To: <200211022111.25198.josh@stack.nl>
Message-ID: <Pine.LNX.3.96.1021105193510.20035F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Jos Hulzink wrote:

> On Friday 01 November 2002 21:31, Dave Jones wrote:
> > On Fri, Nov 01, 2002 at 10:21:56PM +0100, Jos Hulzink wrote:
> >  > Other issue: Are ACPI and APM not mutually exclusive ? If so, I would
> >  > propose a selection box: <ACPI> <APM> <none> with related options shown
> >  > below. Hmzz.. there the issue of the fact that ACPI is more than power
> >  > management shows up again.
> >
> > Whilst they can't both run at the same time, it's perfectly possible
> > (and useful) to build a kernel with both included. ACPI will quit
> > if APM is already running, so booting with apm=off turns the same
> > kernel into 'ACPI mode'
 
> Hmzz.. in that case I vote for dropping CONFIG_PM in favour of
> CONFIG_APM || CONFIG_ACPI, even though it requires some more typing for
> the programmers. (I'm no ACPI programmer, so I don't care ;-) 

More to the point, define CONFIG_PM as ( CONFIG_APM | CONFIG_ACPI ) and be
able to easily handle any new PM method on whatever hardware. PM is not
limited to Intel hardware. Make a new HAS_PM if reusing CONFIG_PM creates
problems.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

