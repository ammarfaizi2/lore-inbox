Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUBJMDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 07:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265844AbUBJMDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 07:03:44 -0500
Received: from math.ut.ee ([193.40.5.125]:43444 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265841AbUBJMDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 07:03:42 -0500
Date: Tue, 10 Feb 2004 14:03:40 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
In-Reply-To: <s5hn07r17ou.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0402101356380.13962-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > mplayer /usr/share/sounds/KDE_Startup.wav
> > gives the same very fast sound since it's a 22 KHz mono sample.
> >
> > mplayer -srate 48000 /usr/share/sounds/KDE_Startup.wav
> > works fine. Same applies to all files.
>
> then VRA of ac97 seems not working correctly.
> check /proc/asound/card0/codec97#0/* files for each case whether the
> DAC rate is set correctly.  (it must be tuned with the detected ac97
> clock, i.e. rate * clock / 48000).

PCM front DAC    : 41133Hz
PCM ADC          : 48000Hz

This is with "intel8x0: clocking to 41133" and playing with mplayer
-srate 48000 ...

PCM front DAC    : 18895Hz
PCM ADC          : 48000Hz

This is with mplayer with no options, it tells itself

Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 22050 Hz, 1 ch, 16 bit (0x10), ratio: 44100->44100 (352,8 kbit)
Selected audio codec: [pcm] afm:pcm (Uncompressed PCM)
==========================================================================
Checking audio filter chain for 22050Hz/1ch/16bit -> 22050Hz/2ch/16bit...
AF_pre: af format: 2 bps, 1 ch, 22050 hz, little endian signed int
AF_pre: 22050Hz 1ch Signed 16-bit (Little-Endian)
SDL: Samplerate: 22050Hz Channels: Stereo Format Signed 16-bit (Little-Endian)
AO: [sdl] 22050Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 22050Hz/1ch/16bit -> 22050Hz/2ch/16bit...

-- 
Meelis Roos (mroos@linux.ee)

