Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWDAGLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDAGLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 01:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWDAGLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 01:11:37 -0500
Received: from styx.suse.cz ([82.119.242.94]:64417 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750709AbWDAGLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 01:11:37 -0500
Date: Sat, 1 Apr 2006 08:11:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Edgar Toernig <froese@gmx.de>
Cc: Bodo Eggert <7eggert@gmx.de>, Joseph Fannin <jfannin@gmail.com>,
       Stas Sergeev <stsp@aknet.ru>, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Message-ID: <20060401061142.GC7751@suse.cz>
References: <5TCqg-E6-55@gated-at.bofh.it> <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru> <20060328183140.GA21446@nineveh.rivenstone.net> <Pine.LNX.4.58.0603282040480.2538@be1.lrz> <20060328185147.GA6475@suse.cz> <20060331010734.32e0a5fb.froese@gmx.de> <20060331074605.GC5871@suse.cz> <20060331230635.4a11e618.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331230635.4a11e618.froese@gmx.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 11:06:35PM +0200, Edgar Toernig wrote:
> Vojtech Pavlik wrote:
> >
> > On Fri, Mar 31, 2006 at 01:07:34AM +0200, Edgar Toernig wrote:
> > >
> > > Latency is no problem.  I'm using a userspace daemon to emulate
> > > the console beeper for about 6 months now and it work's very well.
> > > 
> > > The daemon listens on /dev/input/eventX and when receiving a
> > 
> > It needs to use /dev/input/uinput, not eventX. SND_TONE events are not
> > sent to the event devices.
> 
> Well, I get them - stock 2.6.16.

Oh, yes, you're right. But still, this will only work if a speaker
device is present, so uinput is the right way to do it.

> > > Latency isn't noticable and memory footprint is small.
> > 
> > It needs to have the sample ready in memory and not swapped out. Then
> > the latency will be OK, but if it needs to read it in from the disk, it
> > may be very noticeable.
> 
> Yeah, if one ever cares one could mlock the samples, or (as I do) run
> without swap.  Fixing the 'air' latency of 3ms/m is harder though *g*

-- 
Vojtech Pavlik
Director SuSE Labs
