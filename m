Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWAEOYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWAEOYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWAEOYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:24:21 -0500
Received: from gate.perex.cz ([85.132.177.35]:12210 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751331AbWAEOYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:24:20 -0500
Date: Thu, 5 Jan 2006 15:24:18 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Heikki Orsila <shd@modeemi.cs.tut.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
Message-ID: <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Heikki Orsila wrote:

> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Tuesday 03 January 2006 23:10, Tomasz K?oczko wrote:
> > 2) ALSA API is to complicated: most applications opens single sound
> >    stream.
> 
> > FUD and nonsense. I've written many DSP applications and very often I can
> > recycle the same code for use in them.
> 
> I've long ago stopped using ALSA API because it is broken. But if you 
> wanted to make ALSA usable by real people you might considering adding 3 
> functions (there are ~300 already so not much loss):

This sentence makes this in my mind: real people = lazy people. The error 
codes are documented well. Also, aplay in the alsa-utils package has
good error recovery code including test pcm.c utility in alsa-lib.

> 	err = alsa_simple_pcm_open(nchannels, sampleformat, samplingrate, frames_in_period /* 0 for automated default */ );
> 	err = alsa_simple_writei(); /* handless signal brokeness automagically */
> 	alsa_simple_close();

Well, it's better to create only "fast parameter setup" and "default error 
recovery" functions.

> Basically ogg123/mpg123 like applications would only need 3 alsa calls. 
> Now everyone reimplementing their own buggy versions of simple mechanisms.

While "official" examples exists for a long time. Also, we already noted 
that we are not best documentation writers, but everytime when we ask for 
help we hear nothing from other people.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
