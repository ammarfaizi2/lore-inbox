Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbTA0SYB>; Mon, 27 Jan 2003 13:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbTA0SYB>; Mon, 27 Jan 2003 13:24:01 -0500
Received: from gate.perex.cz ([194.212.165.105]:4618 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267270AbTA0SX7>;
	Mon, 27 Jan 2003 13:23:59 -0500
Date: Mon, 27 Jan 2003 19:33:07 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [ALSA] opl3sa2 silence
In-Reply-To: <200301271854.58093.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.44.0301271930020.1279-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Daniel Ritz wrote:

> jup, switching mute on/off did the trick. (and i switched to self-compiled
> alsa-utils since the last mail, not those binaries)
> however the sound quality is miserable when PCM volume is more than 90%...
> but what do i care? anyway thanx for the help.
> 
> now the question: is it possible to convert the driver to normal pnp, ie. no
> pnp cards? (forcing the resources by hand is working but using pnp would be
> much nicer, and since pnpc_ doesn't work for me...)

Yes, this driver might be converted to pnp_device, but I don't like that 
and I won't do that. I'm actually trying to make some consensus with Adam 
to remove the whole broken pnpc stuff, because the current model is simply 
bad and reintroduce something like enhanced pnp_device model when more pnp 
devices can be probed and grabbed at once. When things are settled down, 
I'll convert all ALSA drivers to new PnP interface immediately.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

