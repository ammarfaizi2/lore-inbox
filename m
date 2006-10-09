Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWJIF6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWJIF6c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 01:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWJIF6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 01:58:31 -0400
Received: from brick.kernel.dk ([62.242.22.158]:22598 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932248AbWJIF6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 01:58:31 -0400
Date: Mon, 9 Oct 2006 07:58:25 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Christian <christiand59@web.de>, linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20061009055825.GC8814@kernel.dk>
References: <200608061200.37701.mlkernel@mortal-soul.de> <200608131815.12873.mlkernel@mortal-soul.de> <20061006175833.4ef08f06@localhost> <200610081628.55012.christiand59@web.de> <20061008170538.GZ8814@kernel.dk> <9a8748490610081650q26511b89s4e694f841803cda1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490610081650q26511b89s4e694f841803cda1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09 2006, Jesper Juhl wrote:
> On 08/10/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> >On Sun, Oct 08 2006, Christian wrote:
> >> Am Freitag, 6. Oktober 2006 17:58 schrieb Paolo Ornati:
> >> > On Sun, 13 Aug 2006 18:15:12 +0200
> >> >
> >> > Matthias Dahl <mlkernel@mortal-soul.de> wrote:
> >> > > Just let me know once you got them, so I can safely delete them 
> >again.
> >> > >
> >> > > At the moment, I am trying without preemption but for example doing a
> >> > > untar kernel sources still results in sluggish system 
> >responsiveness. :-(
> >> >
> >> > I used to have this type of problem and 2.6.19-rc1 looks much better
> >> > than 2.6.18.
> >> >
> >> > I'm using CONFIG_PREEMPT + CONFIG_PREEMPT_BKL, CFQ i/o scheduler
> >> > and /proc/sys/vm/swappiness = 20.
> >>
> >>
> >> Which change in the new kernel has made it better? I was following the 
> >lkml
> >> very close and didn't see any change that could have fixed that problem.
> >
> >There is a substantial CFQ update, so it could be that. Or it could be
> >something unrelated of course, I didn't check if eg the cpu scheduler
> >changed much. Or vm :-)
> >
> >--
> >Jens Axboe
> >
> I want to chime in here and let you know that I've experienced
> something similar.
> 
> I'm using CFQ as my default I/O schedular.
> Since 2.6.18-git<something_I'm_not_sure_of> I've experienced that when
> doing heavy (or even not so heave) disk I/O my system gets very
> sluggish. Observable by the fact that my mouse pointer in X "jumps"
> which it never did before, and switching windows I can see the new
> window repaint slowly whereas earlier it would just snap onto the
> screen.

You should verify that this is CFQ related by booting into the same
kernel with elevator=deadline (or anticipatory) and attempt to reproduce
it, then reboot with CFQ and make sure it reproduces again.

Having profiles of the sluggish period would also be very interesting,
regardless of the outcome of the above test.

-- 
Jens Axboe

