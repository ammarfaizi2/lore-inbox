Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbTA0Rpr>; Mon, 27 Jan 2003 12:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTA0Rpr>; Mon, 27 Jan 2003 12:45:47 -0500
Received: from exzh001.alcatel.ch ([212.243.156.171]:22020 "HELO
	exzh001.alcatel.ch") by vger.kernel.org with SMTP
	id <S267259AbTA0Rpp> convert rfc822-to-8bit; Mon, 27 Jan 2003 12:45:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [ALSA] opl3sa2 silence
Date: Mon, 27 Jan 2003 18:54:58 +0100
User-Agent: KMail/1.4.3
Cc: Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200301262350.51389.daniel.ritz@gmx.ch> <200301271552.25173.daniel.ritz@gmx.ch> <s5h1y2yobve.wl@alsa2.suse.de>
In-Reply-To: <s5h1y2yobve.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301271854.58093.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jup, switching mute on/off did the trick. (and i switched to self-compiled
alsa-utils since the last mail, not those binaries)
however the sound quality is miserable when PCM volume is more than 90%...
but what do i care? anyway thanx for the help.

now the question: is it possible to convert the driver to normal pnp, ie. no
pnp cards? (forcing the resources by hand is working but using pnp would be
much nicer, and since pnpc_ doesn't work for me...)

-daniel


On Monday 27 January 2003 16:23, Takashi Iwai wrote:
> At Mon, 27 Jan 2003 15:52:25 +0100,
>
> Daniel Ritz wrote:
> > ok, i tried that. unfortunately no results. what would you like me to do?
> > where to start debugging?
>
> hmm, are all the mixers configured properly, i.e. volume adjusted
> _and_ unmuted?   you need to set up at least "Master" and "PCM"
> volumes...
>
>
> ciao,
>
> Takashi
>
> > -daniel
> >
> > On Monday 27 January 2003 13:00, Takashi Iwai wrote:
> > > At Sun, 26 Jan 2003 23:50:51 +0100,
> > >
> > > Daniel Ritz wrote:
> > > > hi
> > > >
> > > > my toshiba tecra 8000 doesn't make a single beep when using the alsa
> > > > opl3sa2 driver.  the resources are forced by hand (since pnpc_
> > > > doesn't work here), i also tried a quick pnp (no cards) hack, the
> > > > chip is detected correctly, but still doesn't make sound. the card
> > > > shows up in /proc/asound/. when 'playing' sound,
> > > > /proc/asound/card0/pcm0p/sub0/status shows nice values. i used
> > > > alsamixer to give full volume to all channels, still no results...
> > >
> > > please try to touch the PCM volume after playing the sound again.
> > > it seems that there is a bug hidden in alsa opl3sa2 driver, occuring
> > > on some notebooks.  unfortunately, i cannot debug this due to lack of
> > > hardware...
> > >
> > >
> > > Takashi

