Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVHDPH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVHDPH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVHDPEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:04:48 -0400
Received: from styx.suse.cz ([82.119.242.94]:14482 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262561AbVHDPDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:03:47 -0400
Date: Thu, 4 Aug 2005 17:03:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050804150341.GA10282@ucw.cz>
References: <200508031559.24704.kernel@kolivas.org> <200508031354.52972.lkml@kcore.org> <200508032214.45451.kernel@kolivas.org> <200508031624.00319.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508031624.00319.lkml@kcore.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 04:23:59PM +0200, Jan De Luyck wrote:
> On Wednesday 03 August 2005 14:14, Con Kolivas wrote:
> > On Wed, 3 Aug 2005 21:54, Jan De Luyck wrote:
> > > On Wednesday 03 August 2005 07:59, Con Kolivas wrote:
> > > > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > > > <tony@atomide.com> and Tuukka Tikkanen
> > > > <tuukka.tikkanen@elektrobit.com>. Patch for 2.6.13-rc5
> > >
> > > Compiles and runs ok here.
> > >
> > > Is there actually any timer frequency that's advisable to set as maximum?
> > > (in the kernel config)
> >
> > I'd recommend 1000.
> 
> Thanks. Currently the system - under X, KDE, no artsd, bottoms at around 
> 300HZ. In total single mode with every module unloaded that I can unload it 
> stops around 22HZ.
> 
> I guess I'll have to go hunting whatever thing is causing the pollings. no 
> timertop yet, I guess? :P

i8042 runs a steady periodic 20Hz timer. You can make it slower to get
even the total low lower, and it will not affect performance under
normal (sane hardware) circumstances. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
