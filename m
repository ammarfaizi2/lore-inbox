Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWFDBiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWFDBiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 21:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWFDBiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 21:38:07 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:45984 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751113AbWFDBiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 21:38:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] cfq: ioprio inherit rt class
Date: Sun, 4 Jun 2006 11:37:45 +1000
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       ck list <ck@vds.kolivas.org>
References: <200605271150.41924.kernel@kolivas.org> <200606031010.08794.kernel@kolivas.org> <1149356428.28744.27.camel@mindpipe>
In-Reply-To: <1149356428.28744.27.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041137.46601.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 03:40, Lee Revell wrote:
> On Sat, 2006-06-03 at 10:10 +1000, Con Kolivas wrote:
> > On Saturday 03 June 2006 03:12, Jens Axboe wrote:
> > > Not sure. RT io needs to be considered carefully, but I guess so does
> > > RT CPU scheduling. For now I'd prefer to play it a little safer, and
> > > only inheric the priority value and not the class.
> >
> > The problem I envisioned with that was that realtime tasks, if they don't
> > specify an io priority (as most current code doesn't), would basically
> > get io priority 4 and have the same proportion as any nice 0 SCHED_NORMAL
> > task whereas -nice tasks automatically are getting better io priority.
> > How about givent them normal class but best priority so they are at least
> > getting the same as nice -20?
>
> Con,
>
> Have you seen RT threads trying to disk IO 'in the wild' or is this a
> theoretical concern?  I don't know of any such apps.
>

Yeah, cd burning software comes to mind.

-- 
-ck
