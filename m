Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264062AbRFFTBE>; Wed, 6 Jun 2001 15:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRFFTAy>; Wed, 6 Jun 2001 15:00:54 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:45328 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264093AbRFFTAk>; Wed, 6 Jun 2001 15:00:40 -0400
Date: Wed, 6 Jun 2001 20:59:51 +0200
From: Tomas Telensky <ttel5535@artax.karlin.mff.cuni.cz>
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010606205951.A21519@artax.karlin.mff.cuni.cz>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <20010606200933.B16802@artax.karlin.mff.cuni.cz> <20010606152245.F14579@corellia.laforge.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010606152245.F14579@corellia.laforge.distro.conectiva>; from laforge@gnumonks.org on Wed, Jun 06, 2001 at 03:22:45PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 06, 2001 at 08:09:33PM +0200, Tomas Telensky wrote:
> > > Hi!
> > > 
> > > Is there any way to read out the compile-time HZ value of the kernel?
> > 
> > Why simply #include <asm/param.h>?
> 
> because the include file doesn't say anything about the HZ value of 
> the currently running kernel, but only about some kernel source somewhere
> on your harddrive?

This _SHOULD_ correspond on each linux instalation. But if you would
distribute a binary to other people it's a problem.

(note that I'm running an rc script, which sets the symlink /usr/src/linux
properly at boottime ... this should be everywhere)

There is also one way how to guess HZ - calibrate :-)))
Recently I've done more difficult thing - I not only guess the HZ value, I
also guess the time when the tick comes. But it uses a bit of statistics and 
may be inaccurate on loaded systems. And you need TSC :-)

	Tomas

