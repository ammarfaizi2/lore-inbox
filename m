Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284948AbRLQBDW>; Sun, 16 Dec 2001 20:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284951AbRLQBDN>; Sun, 16 Dec 2001 20:03:13 -0500
Received: from verdi.et.tudelft.nl ([130.161.38.158]:36741 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S284952AbRLQBCz>; Sun, 16 Dec 2001 20:02:55 -0500
Message-Id: <200112170102.fBH12sV28094@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: linux-kernel@vger.kernel.org
Subject: Re: es1371 damaged after 2.2.x 
In-Reply-To: Your message of "Sat, 15 Dec 2001 17:56:31 MST."
             <200112160056.fBG0uVW21900@vindaloo.ras.ucalgary.ca> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 17 Dec 2001 02:02:54 +0100
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

No fix, but behaviour confirmed ..

	greetings,
	Rob van Nieuwkerk

>   Hi, all. I've finally sat down and looked at a problem that's been
> annoying me for a long time: the es1371 driver in 2.4.x does not allow
> me to set the mic recording gain as high as the 2.2.x driver does.
> 
> With 2.2.20, the mixer channels SOUND_MIXER_MIC (7) and
> SOUND_MIXER_RECLEV (11) can both be adjusted to control the recoding
> level. The default levels are sufficient for my needs, and I can
> adjust them to a much higher level.
> 
> With 2.4.17-rc1, I can only control the recording level with
> SOUND_MIXER_IGAIN (12), and even setting it to the maximum 0x6464
> value does not yield a satisfactory recording level. Changing
> SOUND_MIXER_MIC (7) does not affect the recording level (unlike
> 2.2.x). Further, SOUND_MIXER_RECLEV (11) is not available for reading
> or writing.
> 
> My guess is that the change in 2.3.x to use the ac97_codec driver for
> es1371 is the cause of this damage. Under 2.4.x, the maximum available
> recording level is barely usable for my application. Does anyone have
> a fix for this?
> 
> Note that when I say "recording level", I do mean recording. For later
> processing. I don't mean "gain from mic to headphones".
> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


