Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbUDASYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUDASYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:24:34 -0500
Received: from gprs212-143.eurotel.cz ([160.218.212.143]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263030AbUDASYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:24:30 -0500
Date: Thu, 1 Apr 2004 20:24:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, Tjeerd.Mulder@fujitsu-siemens.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: via82xx cmd line parsing is evil [was Re: Sound on newer arima notebook...]
Message-ID: <20040401182417.GA216@elf.ucw.cz>
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

ac97_quirk=1 helps (*) here. dxs_support=1 makes it sounds worse than
usual.
									Pavel

(*): Vol + PCM now controls output to headphones. Thats certainly better
than output controlled by PCM + PCM2. I *still* can't make it play on
internal speakers...
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
