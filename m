Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUGNWBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUGNWBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 18:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUGNWBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 18:01:53 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34520 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S264936AbUGNWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 18:01:51 -0400
Date: Wed, 14 Jul 2004 15:01:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-mm7
Message-ID: <20040714220150.GM21856@smtp.west.cox.net>
References: <20040708235025.5f8436b7.akpm@osdl.org> <20040709203852.GA1997@samarkand.rivenstone.net> <20040709141103.592c4655.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709141103.592c4655.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:11:03PM -0700, Andrew Morton wrote:

> 
> jhf@rivenstone.net (Joseph Fannin) wrote:
> >
> > On Thu, Jul 08, 2004 at 11:50:25PM -0700, Andrew Morton wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> >
> > > +detect-too-early-schedule-attempts.patch
> > >
> > >  Catch attempts to call the scheduler before it is ready to go.
> >
> >     With this patch, my Powermac (ppc32) spews 711 (I think)
> > warning messages during bootup.
> 
> hm, OK.  It could be that the debug patch is a bit too aggressive, or that
> ppc got lucky and happens to always be in state TASK_RUNNING when these
> calls to schedule() occur.
> 
> Maybe this task incorrectly has _TIF_NEED_RESCHED set?
> 
> Anyway, ppc guys: please take a look at the results from
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken-out/detect-too-early-schedule-attempts.patch
> and check that the kernel really should be calling schedule() at this time
> and place, let us know?

Now that kallsyms data is OK, I took a quick look.. and all of this
comes from generic code, at least on the machine I tried.  So if the
code shouldn't be calling schedule() then, it's a more generic problem..

... or I'm not following.

-- 
Tom Rini
http://gate.crashing.org/~trini/
