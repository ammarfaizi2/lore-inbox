Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbSKFQ1x>; Wed, 6 Nov 2002 11:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265785AbSKFQ1w>; Wed, 6 Nov 2002 11:27:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46346 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265777AbSKFQ1v>; Wed, 6 Nov 2002 11:27:51 -0500
Date: Wed, 6 Nov 2002 11:33:15 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 build failed with ACPI turned on 
In-Reply-To: <26783.1036595322@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.3.96.1021106112323.24531A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, David Woodhouse wrote:

> 
> davidsen@tmr.com said:
> >  More to the point, define CONFIG_PM as ( CONFIG_APM | CONFIG_ACPI )
> > and be able to easily handle any new PM method on whatever hardware.
> > PM is not limited to Intel hardware. Make a new HAS_PM if reusing
> > CONFIG_PM creates problems.

Isn't this what I said?
> 
> Er, there's no reason why PM even on Intel hardware should be restricted to
> ACPI and APM.

That's what I proposed. Define CONFIG_PM as what we have now, or define a
new HAS_PM define to indicate that PM is present in some form, and be able
to add other schemes when/if they happen ("easily handle any new PM
method").
Ex:
 #define HAS_PM ( CONFIG_ACPI | CONFIG_APM | CONFIG_IMTU )
One master symbol to indicate that PM is present in any form.

>           With appropriate chipset documentation there's nothing to stop
> people from writing proper driver code to enter sleep states, etc. for i386 
> chipsets just as we have for other architectures.

Which could be handled by HAS_PM_SLEEP, HAS_PM_SUSPEND, HAS_PM_POWEROFF
and the like, if that seems desirable.

I can't see this being totally non-messy, but the config could probably be
clever and grey out anything which can't be done at all for the hardware
selected.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

