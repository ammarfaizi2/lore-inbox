Return-Path: <linux-kernel-owner+w=401wt.eu-S1423075AbWLUU2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423075AbWLUU2Q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423077AbWLUU2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:28:16 -0500
Received: from smtp3.nextra.sk ([195.168.1.142]:3917 "EHLO mailhub3.nextra.sk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423075AbWLUU2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:28:16 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 15:28:15 EST
From: Ondrej Zary <linux@rainbow-software.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] sound/isa/cmi8330.c: dead ENABLE_SB_MIXER code
Date: Thu, 21 Dec 2006 21:22:05 +0100
User-Agent: KMail/1.9.4
Cc: Adrian Bunk <bunk@stusta.de>, George Talusan <gstalusan@uwaterloo.ca>,
       perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
References: <20061204160434.GF30290@stusta.de> <s5hac1kfbpo.wl%tiwai@suse.de>
In-Reply-To: <s5hac1kfbpo.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612212122.06376.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 10:59, you wrote:
> At Mon, 4 Dec 2006 17:04:34 +0100,
>
> Adrian Bunk wrote:
> > In sound/isa/cmi8330.c, the ENABLE_SB_MIXER code is currently never
> > used.
> >
> > What's the story behind this?
> > Should ENABLE_SB_MIXER be enabled?
> > Or the code be removed?
>
> CMI8330 has a dual interface for SB and Adlib modes.  The mixer can
> also behave differently according to the mode.  The current code has
> mixer elements corresponding to both modes.

CMI8330 (and also CMI8329) appears like SB16 and WSS

> However, these mixer elements _seem_ to interactive with each other,
> and cannot be controlled individually.  That's why ENABLE_SB_MIXER is
> disabled.  I cannot check this issue any longer since the test board
> got broken long time ago...

The mixer is a bit weird - and probably different between CMI8329 and CMI8330. 
At least on my CMI8329A, the master volume does not work. And there are also 
some problems with PCM volume - I can decrease it in alsamixer but not 
increase - but it works both ways in XMMS...
I have also some boards with integrated CMI8330 - so I might test it 
sometimes.

> I don't think we would get many gain by changing this old code.
> (and the relevant part isn't so big.)
> Let's keep as it is.
>
>
> Takashi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ondrej Zary
