Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284175AbRLPA4V>; Sat, 15 Dec 2001 19:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284171AbRLPA4M>; Sat, 15 Dec 2001 19:56:12 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16296 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284175AbRLPAz7>; Sat, 15 Dec 2001 19:55:59 -0500
Date: Sat, 15 Dec 2001 17:56:31 -0700
Message-Id: <200112160056.fBG0uVW21900@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: es1371 damaged after 2.2.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've finally sat down and looked at a problem that's been
annoying me for a long time: the es1371 driver in 2.4.x does not allow
me to set the mic recording gain as high as the 2.2.x driver does.

With 2.2.20, the mixer channels SOUND_MIXER_MIC (7) and
SOUND_MIXER_RECLEV (11) can both be adjusted to control the recoding
level. The default levels are sufficient for my needs, and I can
adjust them to a much higher level.

With 2.4.17-rc1, I can only control the recording level with
SOUND_MIXER_IGAIN (12), and even setting it to the maximum 0x6464
value does not yield a satisfactory recording level. Changing
SOUND_MIXER_MIC (7) does not affect the recording level (unlike
2.2.x). Further, SOUND_MIXER_RECLEV (11) is not available for reading
or writing.

My guess is that the change in 2.3.x to use the ac97_codec driver for
es1371 is the cause of this damage. Under 2.4.x, the maximum available
recording level is barely usable for my application. Does anyone have
a fix for this?

Note that when I say "recording level", I do mean recording. For later
processing. I don't mean "gain from mic to headphones".

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
