Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUATPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265560AbUATPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:11:58 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:42454 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S265558AbUATPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:11:56 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Mark Borgerding <mark@borgerding.net>
Subject: Re: ALSA vs. OSS
Date: Tue, 20 Jan 2004 15:13:45 +0000
User-Agent: KMail/1.5.94
References: <1074532714.16759.4.camel@midux> <200401201046.24172.hus@design-d.de> <400D2AB2.7030400@borgerding.net>
In-Reply-To: <400D2AB2.7030400@borgerding.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401201513.45564.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 January 2004 13:18, Mark Borgerding wrote:
> Me too.  I cannot get ALSA working on my SB Live.
>
> If I may be so bold as to make a suggestion: Maybe the developer in
> charge of ALSA's e-mu driver could work with us poor unfortunates.
> There may be some commonality between our systems that causes this
> (besides the sound blaster live).
>
> My system:
> Sound: SBLive Value
> Redhat 7.3 (w/ piecemeal recompiles & upgrades)
> Kernel: 2.6.1
> CPU: Athlon XP 2100+
> Mobo: ASUS (I think it's A7V333. I can confirm this later.)
>

ALSA works fine with my EMU10K1; you might find you've selected the "Virtual 
MIDI" device in the kernel config -- for some strange reason if you build 
ALSA into the kernel, this always gets device #0, and it breaks stuff that's 
looking for /dev/dsp (not /dev/dsp1).

However, "fine" from the above paragraph is fairly subjective. The ALSA driver 
is noticably inferior to the OSS driver in that the ALSA developers, despite 
multiple bug reports and complaints, still persist to use the most horrible 
software tone controls. Enabling them is an utter waste of time, as putting 
them above 60 causes clipping and artifacts.

The OSS userspace utilities, however, program the EMU10k1 dsp with a very nice 
tone control patch that produces a very high quality control with no 
clipping.

If ALSA does or could support working with the programmable dsp, I'd be happy 
to switch to it. Right now my "deprecated" SBLive! OSS drivers output higher 
quality audio.

This is all getting a little OT, because it seems the problems most people 
have with ALSA are userspace concerns, not a problem with the kernel 
architecture. Certainly in my case, this is true.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
