Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUBISfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBISfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:35:32 -0500
Received: from math.ut.ee ([193.40.5.125]:33504 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265332AbUBISfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:35:16 -0500
Date: Mon, 9 Feb 2004 20:35:12 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
In-Reply-To: <s5hn07s2jtc.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0402092029270.11426-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today mplayer was OK when I tested, didn't retry KDE login. But the
kernel is the same, I have not rebooted inbetween.

> which ac97 codec chip?  check /proc/asound/card0/codec97#0/* files.

i810_audio that I have currently loaded tells it's
ac97_codec: AC97 Audio codec, id: ADS96 (Analog Devices AD1885)

ALSA loaded, from /proc/asound/card0/codec97#0/ac97#0-0

0-0/0: Analog Devices AD1885

Capabilities     : -headphone out-
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : Analog Devices Phat Stereo

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz



AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000


And +regs:

0:00 = 0410
0:02 = bf3f
0:04 = bf3f
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 9f1f
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0001
0:2a = 0001
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 2000
0:72 = 0300
0:74 = 1000
0:76 = 0404
0:78 = bb80
0:7a = bb80
0:7c = 4144
0:7e = 5360

> also, you must have seen a kernel message like
> 	intel8x0: clocking to 48000

Did try twice:

intel8x0_measure_ac97_clock: measured 50040 usecs
intel8x0: clocking to 41146

intel8x0_measure_ac97_clock: measured 49395 usecs
intel8x0: clocking to 41145


-- 
Meelis Roos (mroos@linux.ee)

