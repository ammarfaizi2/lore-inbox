Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTE2Mzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTE2Mzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:55:53 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46760
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262037AbTE2Mzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:55:50 -0400
Date: Thu, 29 May 2003 15:09:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Elladan <elladan@eskimo.com>, Jens Axboe <axboe@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529130933.GI1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <20030528125312.GV845@suse.de> <20030528184737.GA2726@eskimo.com> <200305290903.42996.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305290903.42996.kernel@kolivas.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 09:03:42AM +1000, Con Kolivas wrote:
> On Thu, 29 May 2003 04:47, Elladan wrote:
> > On Wed, May 28, 2003 at 02:53:12PM +0200, Jens Axboe wrote:
> > > On Wed, May 28 2003, Marc-Christian Petersen wrote:
> > > > On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
> > > >
> > > > Hi Akpm,
> > > >
> > > > > > Does the attached one make sense?
> > > > >
> > > > > Nope.
> > > >
> > > > nm.
> > > >
> > > > > Guys, you're the ones who can reproduce this.  Please spend more time
> > > > > working out which chunk (or combination thereof) actually fixes the
> > > > > problem.  If indeed any of them do.
> > > >
> > > > As I said, I will test it this evening. ATM I don't have time to
> > > > recompile and reboot. This evening I will test extensively, even on
> > > > SMP, SCSI, IDE and so on.
> > >
> > > May I ask how you are reproducing the bad results? I'm trying in vain
> > > here...
> >
> > It might be useful to check what video hardware and X servers people are
> > using here.  If the behavior is just mouse freezups, the "silken mouse"
> > feature of XFree might have some effect, since it involves XFree binding
> > a signal to mouse device events.
> 
> Xfree 3.3.6, 4.2,4.3
> Drivers nvidia, nv, sis, sisfb, vesa, vesafb
> 
> are the drivers on the machines where I've seen it happen so far - ie without 
> discrimination.

what about the window manager? do you use focus follow mouse? Just
trying to find a pattern. For the record KDE 3.1 + focus follow mouse
and X 4.3.0 here, I guess Jens uses the same software combination. the
mouse for me is always perfectly fluid no matter how fast and how long I
write, no matter if I don't touch the mouse for minutes, ALT+TAB as
well. I definitely can't reproduce in any way the mouse stalls (I'm
using cp /dev/zero .  on a ext3 fs in ordered mode). hardware is 1G of
ram smp IDE single spindle primary master matrox GS450. I almost
couldn't notice the background write flood if I only would increase the
xmms buffer (infact I thought it stopped writing for a dozen seconds out
of space, and instead it was still writing).  (kernel is 2.4.21rc4aa1 of
course)

Andrea
