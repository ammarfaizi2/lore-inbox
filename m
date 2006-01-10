Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWAJJnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWAJJnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAJJnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:43:47 -0500
Received: from gate.perex.cz ([85.132.177.35]:51347 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1750753AbWAJJnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:43:46 -0500
Date: Tue, 10 Jan 2006 10:43:44 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Hannu Savolainen <hannu@opensound.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi>
Message-ID: <Pine.LNX.4.61.0601101040430.10330@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>  <20060103193736.GG3831@stusta.de>
  <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> 
 <mailman.1136368805.14661.linux-kernel2news@redhat.com> 
 <20060104030034.6b780485.zaitcev@redhat.com>  <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
  <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> 
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> 
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>  <s5hmziaird8.wl%tiwai@suse.de>
  <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504460.847.91.camel@mindpipe>
 <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Hannu Savolainen wrote:

> On Thu, 5 Jan 2006, Lee Revell wrote:
> 
> > On Fri, 2006-01-06 at 01:06 +0200, Hannu Savolainen wrote:
> > > We have not received any single bug report that is caused 
> > > by the concept of kernel mixing.
> > > Kernel mixing is not rocket science. All you need to do is picking a 
> > > sample from the output buffers of each of the applications, sum them 
> > > together (with some volume scaling) and feed the result to the
> > > physical 
> > > device. 
> > 
> > Hey, interesting, this is exactly what dmix does in userspace.  And we
> > have not seen any bug reports caused by the concept of userspace mixing
> > (just implementation bugs like any piece of software).
> Having dmix working in user space doesn't prove that kernel level mixing 
> is evil. This was the original topic.

Overloading interrupt handlers with extra things is evil (and I bet you're 
mixing samples in the interrupt handler). Even the network stack uses 
interrupts only for DMA management and not for any extra operations.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
