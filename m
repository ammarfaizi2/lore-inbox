Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270456AbTGMX4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270460AbTGMX4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:56:30 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:51145 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S270456AbTGMX43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:56:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Phillips <phillips@arcor.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Mon, 14 Jul 2003 10:13:12 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307112053.55880.kernel@kolivas.org> <20030712154924.GC15452@holomorphy.com> <200307132203.55414.phillips@arcor.de>
In-Reply-To: <200307132203.55414.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141013.12202.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 06:03, Daniel Phillips wrote:
> On Saturday 12 July 2003 17:49, William Lee Irwin III wrote:
> > On Fri, Jul 11, 2003 at 08:53:38PM +1000, Con Kolivas wrote:
> > > Wli coined the term "isochronous" (greek for same time) for a real time
> > > task that was limited in it's timeslice but still guaranteed to run.
> > > I've decided to abuse this term and use it to name this new policy in
> > > this patch. This is neither real time, nor guaranteed.
> >
> > I didn't coin it; I know of it from elsewhere.
>
> Right, for example, USB has an isochronous transfer facility intended to
> support media applications, e.g., cameras, that require realtime
> bandwidth/latency guarantees.  The thing is, such guarantees have to be
> end-to-end in the media pipeline.  Sound is just one of the applications
> that needs the kind of realtime support we (or more properly, Davide) just
> proposed.

I'm not looking at creating a true realtime policy of any sort. Mine is more a 
dynamic policy change to an interactive state that is sustained, which gives 
no more capabilities to a normal user process than they can currently get on 
SCHED_NORMAL tasks. Audio will definitely get priority... along with any 
other interactive task, but not in a real time fashion. Basically they 
effectively get a nice -5 unless they do the wrong thing.

Con

