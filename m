Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUDAKne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbUDAKmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:42:37 -0500
Received: from gprs212-36.eurotel.cz ([160.218.212.36]:34946 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262840AbUDAKmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:42:15 -0500
Date: Thu, 1 Apr 2004 12:41:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, Tjeerd.Mulder@fujitsu-siemens.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: via82xx cmd line parsing is evil [was Re: Sound on newer arima notebook...]
Message-ID: <20040401104157.GA6049@elf.ucw.cz>
References: <20040331145206.GA384@elf.ucw.cz> <s5h7jx1xdel.wl@alsa2.suse.de> <20040401080954.GA464@elf.ucw.cz> <s5hr7v8w1gr.wl@alsa2.suse.de> <20040401082905.GE224@elf.ucw.cz> <s5hptasw0t8.wl@alsa2.suse.de> <20040401090452.GF224@elf.ucw.cz> <s5hlllgvz2s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlllgvz2s.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > snd-via82xx=enable:1 syntax is ugly, too, and we have better syntax
> > > > already. via82xx.enable=1 via82xx.ac97_quirk=2 should be possible with
> > > > new param handling code.
> > > 
> > > oh that's good to know.
> > 
> > And here's a patch. It compiles.
> 
> heh, we're crossfiring :)
> 
> > @@ -82,33 +81,36 @@
> >  static int joystick[SNDRV_CARDS];
> >  #endif
> >  static int ac97_clock[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 48000};
> > -static int ac97_quirk[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = AC97_TUNE_DEFAULT};
> > -static int dxs_support[SNDRV_CARDS];
> > +static int ac97_quirk[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
> > +static int dxs_support[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
> 
> i suppose that ac97_quirk=1 and dxs_support=1 work fine with your
> machine?
> (i don't want to change defaults for all devices yet :)

Oops, sorry, I was not able to test it yet.
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
