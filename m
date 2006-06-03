Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWFCTLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWFCTLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 15:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWFCTLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 15:11:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:36482 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751786AbWFCTLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 15:11:36 -0400
Message-Id: <200606031852.k53IqgtG012318@laptop11.inf.utfsm.cl>
To: Lee Revell <rlrevell@joe-job.com>
cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, ck list <ck@vds.kolivas.org>
Subject: Re: [patch] cfq: ioprio inherit rt class 
In-Reply-To: Message from Lee Revell <rlrevell@joe-job.com> 
   of "Sat, 03 Jun 2006 13:40:28 -0400." <1149356428.28744.27.camel@mindpipe> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sat, 03 Jun 2006 14:52:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:18:23 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 15:11:34 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
> On Sat, 2006-06-03 at 10:10 +1000, Con Kolivas wrote:
> > On Saturday 03 June 2006 03:12, Jens Axboe wrote:
> > > Not sure. RT io needs to be considered carefully, but I guess so does RT
> > > CPU scheduling. For now I'd prefer to play it a little safer, and only
> > > inheric the priority value and not the class.

> > The problem I envisioned with that was that realtime tasks, if they
> > don't specify an io priority (as most current code doesn't), would
> > basically get io priority 4 and have the same proportion as any nice 0
> > SCHED_NORMAL task whereas -nice tasks automatically are getting better
> > io priority. How about givent them normal class but best priority so
> > they are at least getting the same as nice -20?

> Have you seen RT threads trying to disk IO 'in the wild'

I'd be surprised, to be sure.

>                                                          or is this a
> theoretical concern?  I don't know of any such apps.

Is it hard to do? If not, as this isn't forbidden as such, it makes sense
IMVHO.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
