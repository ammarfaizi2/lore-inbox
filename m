Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265731AbTFSQgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbTFSQgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:36:03 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:720 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265731AbTFSQgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:36:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Boman <aboman@midgaard.us>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Fri, 20 Jun 2003 02:50:01 +1000
User-Agent: KMail/1.5.2
Cc: Mike Galbraith <efault@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net> <200306200206.00548.kernel@kolivas.org> <1056040950.702.10.camel@asgaard.midgaard.us>
In-Reply-To: <1056040950.702.10.camel@asgaard.midgaard.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306200250.01865.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003 02:42, Andreas Boman wrote:
> On Thu, 2003-06-19 at 12:06, Con Kolivas wrote:
> > On Fri, 20 Jun 2003 02:02, Con Kolivas wrote:
> > > On Fri, 20 Jun 2003 01:47, Mike Galbraith wrote:
> > > > At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:
> > > > >Testers required. A version for -ck will be created soon.
> > > >
> > > > That idea definitely needs some refinement.
> > >
> > > Actually no it needs a bugfix even more than a refinement!
> > >
> > > The best_sleep_decay should be 60, NOT 60*Hz
> >
> > Here's a fixed patch.
>
> Ok, that doesnt really seem to change behavior much (from just a little
> testing). I can still easily starve xmms by moving a window around over
> mozilla or evolution (I suspect for thoose that use nautilus to draw the
> desktop that would happen on an 'empty' desktop too..).
>
> With 2.5.72-mm1, HZ 1000 and MAX_SLEEP_AVG 2 that does *not* happen,
> even with a cpu hog running (mpeg2enc) or during make -j20. However with
> this kernel, after having moved a window around madly for a while the
> mouse pointer is very laggy/jerky for atleast 30 sec after i release the
> window (not so with your patch).
>
> I'm not hitting swap at all, so thats not a factor here.

Ok well next thing to try is max_sleep_avg 2*HZ with my patch, possibly with 
best_sleep_decay 10

Con

