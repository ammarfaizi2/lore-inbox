Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVKEPKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVKEPKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVKEPKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:10:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932073AbVKEPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:10:01 -0500
Date: Sat, 5 Nov 2005 16:09:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] drivers/input/: possible cleanups
Message-ID: <20051105150959.GG5368@stusta.de>
References: <20051104123541.GC5587@stusta.de> <20051104124207.GA4937@ucw.cz> <20051104125742.GE5587@stusta.de> <20051104131228.GA5208@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104131228.GA5208@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 02:12:28PM +0100, Vojtech Pavlik wrote:
> On Fri, Nov 04, 2005 at 01:57:42PM +0100, Adrian Bunk wrote:
> 
> > On Fri, Nov 04, 2005 at 01:42:07PM +0100, Vojtech Pavlik wrote:
> > > On Fri, Nov 04, 2005 at 01:35:41PM +0100, Adrian Bunk wrote:
> > > > This patch contains the following possible cleanups:
> > > > - make needlessly glbal code static
> > > 
> > > Agreed.
> > > 
> > > > - gameport/gameport: #if 0 the unused global function gameport_reconnect
> > > 
> > > That one should be an EXPORT_SYMBOL() API. If the export is missing,
> > > then that's the bug that needs to be fixed.
> > >...
> > 
> > There isn't even a header providing a function prototype which is quite 
> > strange for a part of an API.
>  
> It's a planned API (a mirror of what the serio abstraction does), the
> drivers don't use it yet.

Can you either apply my patch to #if 0 it, or (if usage is planned very 
soon) add a function prototype to a header file?

In both cases, we get rid of a warning both by sparse and with the gcc 
-Wmissing-prototypes flag.

> Vojtech Pavlik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

