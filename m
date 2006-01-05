Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWAEG4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWAEG4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWAEG4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:56:48 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:22745 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751913AbWAEG4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:56:47 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 17:55:53 +1100
User-Agent: KMail/1.9
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andi Kleen <ak@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
References: <200601041200.03593.kernel@kolivas.org> <p73y81vxyci.fsf@verdi.suse.de> <20060105064227.GA6120@corona.suse.cz>
In-Reply-To: <20060105064227.GA6120@corona.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051755.54577.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 17:42, Vojtech Pavlik wrote:
> On Thu, Jan 05, 2006 at 02:22:37AM +0100, Andi Kleen wrote:
> > Arjan van de Ven <arjan@infradead.org> writes:
> > > sounds like we need some sort of profiler or benchmarker or at least a
> > > tool that helps finding out which timers are regularly firing, with the
> > > aim at either grouping them or trying to reduce their disturbance in
> > > some form.
> >
> > I did one some time ago for my own noidletick patch. Can probably dig
> > it out again. It just profiled which timers interrupted idle.
> >
> > Executive summary for my laptop: worst was the keyboard driver (it ran
> > some polling driver to work around some hardware bug, but fired very
> > often) , followed by the KDE desktop (should be mostly
> > fixed now, I complained) and the X server and some random kernel
> > drivers.
> >
> > I haven't checked recently if keyboard has been fixed by now.
>
> It's not. At this moment it's impossible to remove without significant
> surgery to the driver, because it'd prevent hotplugging and many KVMs
> from working.
>
> I can rather easily make the timer frequency variable. Would be 1 second
> idle ticks OK?

Sure. The lower the better, and HZ with dynticks bottoms out at 14HZ.

Cheers,
Con
