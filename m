Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUDMWwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 18:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUDMWwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 18:52:19 -0400
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:15382
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S263799AbUDMWwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 18:52:16 -0400
Subject: Re: Does OSS sound work in 2.6 or not?
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <c5h6d2$fuu$1@gatekeeper.tmr.com>
References: <4075BDE0.6050302@tmr.com> <4075D155.2030603@tomt.net>
	 <c5h6d2$fuu$1@gatekeeper.tmr.com>
Content-Type: text/plain
Message-Id: <1081896719.4245.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Tue, 13 Apr 2004 18:51:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-13 at 13:04, Bill Davidsen wrote: 
> Let me provide a bit more detail. I have machines with "Vortex 
> boomerang" sound cards. I have a 2.4 driver for same, for OSS, under 
> NDA. In 2.6 those cards appear to be supported in ALSA, but using the 
> OSS emulation everything seems to work except there isn't any sound.

OK, Got it.  Are you sure the volume is turned up, and more specifically
'unmuted' (a seperate function on some cards).  Do you have an ALSA
utility to use to at least test that the ALSA drivers are working? 
Obviouslly ALSA's OSS emulation won't work if you ALSA drivers aren't
working.

> I've had several people tell me that they are using OSS/2.6 without the 
> ALSA utilities. I just want to know if that's possible or not, the 
> people with the machines don't want ALSA for reasons I would call 
> pigheaded stupidity if they weren't paying me to say "personal 
> preference" ;-)
> 
> In any case, that's the question, can I get there from here? I can't use 
> just OSS, the Vortex drivers are in ALSA.

So the question is, "Can I use the ALSA+OSS emulation kernel drivers but
continue to use OSS userspace programs?"  Right?

The answer to that question is almost always yes.  The OSS emulation is
quite complete and includes mixer, dsp, and sequencer support.

The only exception to this that I have run into is that the ALSA mixer
is sometimes required to access "extra" mixer channels.  For example on
my Dell D800 laptop with i810 audio the OSS mixer can control the
master, speaker, and pcm volume, however, the laptop supports a seperate
volume control for the headphone jack and only an ALSA mixer seems to be
able to control that option.

Other than that one minor 'gotcha' everything else I use is OSS only.

Later,
Tom


