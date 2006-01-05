Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWAEP1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWAEP1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWAEP1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:27:30 -0500
Received: from mail.cs.tut.fi ([130.230.4.42]:22201 "EHLO mail.cs.tut.fi")
	by vger.kernel.org with ESMTP id S932070AbWAEP13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:27:29 -0500
Date: Thu, 5 Jan 2006 17:27:25 +0200
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060105152725.GG757@jolt.modeemi.cs.tut.fi>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi> <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
User-Agent: Mutt/1.5.9i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 03:24:18PM +0100, Jaroslav Kysela wrote:
> On Thu, 5 Jan 2006, Heikki Orsila wrote:
> > 	err = alsa_simple_pcm_open(nchannels, sampleformat, samplingrate, frames_in_period /* 0 for automated default */ );
> 
> Well, it's better to create only "fast parameter setup" and "default error 
> recovery" functions.

And what would it look like? I would prefer all functions being 
alsa_simple_* because a user could read interface documentation 
alphabetically and see all the relevant functions as they are adjacent.

I would correct my earlier 'frames_in_period' to 'latency_in_frames' because
most users are not interested in period size. Latency on the other hand 
matters. 10ms latency would just be samplingrate / 100 and the ALSA lib 
would choose good approximate period/buffer sizes internally. Those who 
need something better should just use the old way.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
