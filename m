Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVKEUU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVKEUU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKEUU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 15:20:56 -0500
Received: from styx.suse.cz ([82.119.242.94]:41893 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932317AbVKEUUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 15:20:55 -0500
Date: Sat, 5 Nov 2005 21:20:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] drivers/input/: possible cleanups
Message-ID: <20051105202018.GC23614@midnight.suse.cz>
References: <20051104123541.GC5587@stusta.de> <20051104124207.GA4937@ucw.cz> <20051104125742.GE5587@stusta.de> <20051104131228.GA5208@ucw.cz> <20051105150959.GG5368@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105150959.GG5368@stusta.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 04:09:59PM +0100, Adrian Bunk wrote:
> On Fri, Nov 04, 2005 at 02:12:28PM +0100, Vojtech Pavlik wrote:
> > On Fri, Nov 04, 2005 at 01:57:42PM +0100, Adrian Bunk wrote:
> > 
> > > On Fri, Nov 04, 2005 at 01:42:07PM +0100, Vojtech Pavlik wrote:
> > > > On Fri, Nov 04, 2005 at 01:35:41PM +0100, Adrian Bunk wrote:
> > > > > This patch contains the following possible cleanups:
> > > > > - make needlessly glbal code static
> > > > 
> > > > Agreed.
> > > > 
> > > > > - gameport/gameport: #if 0 the unused global function gameport_reconnect
> > > > 
> > > > That one should be an EXPORT_SYMBOL() API. If the export is missing,
> > > > then that's the bug that needs to be fixed.
> > > >...
> > > 
> > > There isn't even a header providing a function prototype which is quite 
> > > strange for a part of an API.
> >  
> > It's a planned API (a mirror of what the serio abstraction does), the
> > drivers don't use it yet.
> 
> Can you either apply my patch to #if 0 it, or (if usage is planned very 
> soon) add a function prototype to a header file?

I'll add the prototype.

> 
> In both cases, we get rid of a warning both by sparse and with the gcc 
> -Wmissing-prototypes flag.
> 
> > Vojtech Pavlik
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
