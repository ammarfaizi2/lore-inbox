Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUATPVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbUATPVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:21:01 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:9113 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S265564AbUATPU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:20:58 -0500
Date: Tue, 20 Jan 2004 16:19:29 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Mark Borgerding <mark@borgerding.net>, linux-kernel@vger.kernel.org
Subject: Re: ALSA vs. OSS
In-Reply-To: <200401201513.45564.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.58.0401201615480.2010@pnote.perex-int.cz>
References: <1074532714.16759.4.camel@midux> <200401201046.24172.hus@design-d.de>
 <400D2AB2.7030400@borgerding.net> <200401201513.45564.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, Alistair John Strachan wrote:

> On Tuesday 20 January 2004 13:18, Mark Borgerding wrote:
> > Me too.  I cannot get ALSA working on my SB Live.
> >
> > If I may be so bold as to make a suggestion: Maybe the developer in
> > charge of ALSA's e-mu driver could work with us poor unfortunates.
> > There may be some commonality between our systems that causes this
> > (besides the sound blaster live).
> >
> > My system:
> > Sound: SBLive Value
> > Redhat 7.3 (w/ piecemeal recompiles & upgrades)
> > Kernel: 2.6.1
> > CPU: Athlon XP 2100+
> > Mobo: ASUS (I think it's A7V333. I can confirm this later.)
> >
> 
> ALSA works fine with my EMU10K1; you might find you've selected the "Virtual 
> MIDI" device in the kernel config -- for some strange reason if you build 
> ALSA into the kernel, this always gets device #0, and it breaks stuff that's 
> looking for /dev/dsp (not /dev/dsp1).

You may try to append 'snd-virmidi=1,1' (first 1 means enable and second 
index starting with 0, so virmidi will be the second card in your system).

> However, "fine" from the above paragraph is fairly subjective. The ALSA driver 
> is noticably inferior to the OSS driver in that the ALSA developers, despite 
> multiple bug reports and complaints, still persist to use the most horrible 
> software tone controls. Enabling them is an utter waste of time, as putting 
> them above 60 causes clipping and artifacts.

It's not a priority for us. I ported this code from OSS driver at some 
time, but I probably did some mistake.

> The OSS userspace utilities, however, program the EMU10k1 dsp with a very nice 
> tone control patch that produces a very high quality control with no 
> clipping.
> 
> If ALSA does or could support working with the programmable dsp, I'd be happy 
> to switch to it. Right now my "deprecated" SBLive! OSS drivers output higher 
> quality audio.

We don't have user space tools to update DSP code although our emu10k1
driver is capable to do it. Sure, we are doing things differently than OSS
driver so you cannot simply use the OSS utilities.

Perhaps, time to help us?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
