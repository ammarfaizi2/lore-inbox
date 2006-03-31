Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWCaVGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWCaVGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWCaVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:06:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:59273 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932248AbWCaVGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:06:43 -0500
X-Authenticated: #271361
Date: Fri, 31 Mar 2006 23:06:35 +0200
From: Edgar Toernig <froese@gmx.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Bodo Eggert <7eggert@gmx.de>, Joseph Fannin <jfannin@gmail.com>,
       Stas Sergeev <stsp@aknet.ru>, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Message-Id: <20060331230635.4a11e618.froese@gmx.de>
In-Reply-To: <20060331074605.GC5871@suse.cz>
References: <5TCqf-E6-51@gated-at.bofh.it>
	<5TCqf-E6-53@gated-at.bofh.it>
	<5TCqg-E6-55@gated-at.bofh.it>
	<5TCqf-E6-47@gated-at.bofh.it>
	<E1FMv1A-0000fN-Lp@be1.lrz>
	<44266472.5080309@aknet.ru>
	<20060328183140.GA21446@nineveh.rivenstone.net>
	<Pine.LNX.4.58.0603282040480.2538@be1.lrz>
	<20060328185147.GA6475@suse.cz>
	<20060331010734.32e0a5fb.froese@gmx.de>
	<20060331074605.GC5871@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
>
> On Fri, Mar 31, 2006 at 01:07:34AM +0200, Edgar Toernig wrote:
> >
> > Latency is no problem.  I'm using a userspace daemon to emulate
> > the console beeper for about 6 months now and it work's very well.
> > 
> > The daemon listens on /dev/input/eventX and when receiving a
> 
> It needs to use /dev/input/uinput, not eventX. SND_TONE events are not
> sent to the event devices.

Well, I get them - stock 2.6.16.


> > Latency isn't noticable and memory footprint is small.
> 
> It needs to have the sample ready in memory and not swapped out. Then
> the latency will be OK, but if it needs to read it in from the disk, it
> may be very noticeable.

Yeah, if one ever cares one could mlock the samples, or (as I do) run
without swap.  Fixing the 'air' latency of 3ms/m is harder though *g*

Ciao, ET.
