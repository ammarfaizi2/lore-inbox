Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVCAKbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVCAKbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 05:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVCAKbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 05:31:05 -0500
Received: from gprs215-195.eurotel.cz ([160.218.215.195]:62160 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261853AbVCAKa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 05:30:56 -0500
Date: Tue, 1 Mar 2005 11:30:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: martin f krafft <madduck@madduck.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050301103043.GB1345@elf.ucw.cz>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050227174309.GA27265@piper.madduck.net> <20050228135604.GA6364@piper.madduck.net> <200502281533.01621.rjw@sisk.pl> <20050228144506.GA11125@piper.madduck.net> <20050301082254.GA4402@piper.madduck.net> <1109667621.4229.40.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109667621.4229.40.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Could you, please, verify that you don't need to load any
> > > > > modules from initrd for your swap partition to work?  It won't
> > > > > work if you do.
> > > > 
> > > > this makes perfect sense to me when you talk about resuming.
> > > > does it also apply to suspending?
> > > 
> > > As kernel is the same for suspend and resume... Yes, it seems it
> > > makes sense.
> > 
> > But before the suspend, the IDE modules are loaded, so the swap
> > drive is accessible, no? Or are IDE modules (yes, they are modules
> > here) unloaded just before writing to swap?
> 
> I think Pavel got a bit confused somewhere here! The IDE modules will
> always be loaded when you're doing the suspend, right to the very end.
> At resume time, they need to be loaded the swsusp attempts to parse the
> resume= parameter, so that it can actually succeed in doing that.
> Suspend2 works with IDE made as modules because it allows you to delay
> that parsing until after the modules are loaded (you put echo >
> /proc/software_suspend/do_resume in your initrd after modules are loaded
> but before you mount filesystems). Last time I looked, swsusp didn't
> have that capability and thus required IDE to be built in. Pavel, has
> that changed?

No, it has not changed for mainline.

SuSE has patch to allow resume from modular IDE.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
