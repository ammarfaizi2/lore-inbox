Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVCZAsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVCZAsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVCZAsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:48:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56963 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261897AbVCZAsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:48:07 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Lee Revell <rlrevell@joe-job.com>
To: Julien Wajsberg <julien.wajsberg@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2a0fbc590503251638420f2f08@mail.gmail.com>
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <1111792462.23430.25.camel@mindpipe>
	 <2a0fbc590503251638420f2f08@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 19:48:06 -0500
Message-Id: <1111798086.24049.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 01:38 +0100, Julien Wajsberg wrote:
> On Fri, 25 Mar 2005 18:14:22 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > > - audio works too. The only problem is that two applications can't
> > > open /dev/dsp in the same time.
> > 
> > Not a problem.  ALSA does software mixing for chipsets that can't do it
> > in hardware.  Google for dmix.
> > 
> > However this doesn't (and can't be made to) work with the in-kernel OSS
> > emulation (it works fine with the alsa-lib/libaoss emulation).  So you
> > are technically correct in that two OSS apps can't open /dev/dsp at the
> > same time, but there is no problem with multiple apps sharing the sound
> > device, as long as they use the ALSA API (which they should be using
> > anyway).
> 
> Okay, good to know. Then I'll have to find out why beep-media-player
> doesn't work with alsa :-)
> 

Without knowing anything about it, I'm willing to guess "programmer
laziness/lack of time" (depending on your perspective).  As long as ALSA
continues to provide OSS emulation, lazy developers will not update
their apps to the (superior) ALSA API.

I just upgraded all my home machines to a Gnome 2.10 based distro and
way shocked to find that it still uses esd via OSS emulation for system
sounds.  So the endless user complaints about "wtf, esd is blocking my
sound device, on windows my apps can share it" will not be going away in
the forseeable future.

Ugh.  dmix has only been available for, oh, 18 months, and the apps
still have not caught up.

Lee

