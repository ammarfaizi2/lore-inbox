Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSLCADn>; Mon, 2 Dec 2002 19:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLCADn>; Mon, 2 Dec 2002 19:03:43 -0500
Received: from guru.webcon.net ([66.11.168.140]:61327 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S265816AbSLCADk>;
	Mon, 2 Dec 2002 19:03:40 -0500
Date: Mon, 2 Dec 2002 19:10:02 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Asus P4PE onboard AD1980 sound?
In-Reply-To: <Pine.LNX.3.96.1021202162225.1236C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.50.0212021904030.2814-100000@light.webcon.net>
References: <Pine.LNX.3.96.1021202162225.1236C-100000@gatekeeper.tmr.com>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Bill Davidsen wrote:

> On Wed, 27 Nov 2002, Ian Morgan wrote:
> 
> > Analog Devices 1980, onboard Asus P4PE (845PE/ICH4).
> > 
> > I've tried a number of patches based on my google-based research (2.5.x ALSA
> > patches and the like), but no matter what I do, I can't get any sound out of
> > this thing. Yes, I've tried the obvious things (headphones). Everything
> > about it _appears_ to work (from the application POV), just no sound.
> > 
> > I have tried kernel 2.4.19 - 2.4.20-rc2-ac3. Anybody know how to get this
> > thing working?
> 
> Did you get a fix? I just dropped another sound card in mine, I didn't
> have time to fight and I did have a few extra cards sitting on a shelf.

Yup (sorta). I found that ALSA 0.9.0pre6 works nicely.

I didn't think it was working at first, because ALSA defaults to having all
channels muted when the drivers are loaded. It _does_ warn about this, but I
thought just raising the volume would be enough. Turns out that ALSA controls
_hardware-based_ muting. The OSS-emulation layer is not enough to turn off
the muting, you need a native ALSA-aware mixer. "Mute" is OSS just means
"volume=0", but in ALSA muting really does mute the output, no matter what
the volume is set to.

Beware, that is you download the (newly available) ALSA drivers from ASUS's
download site, it includes ONLY the drivers, and your OSS-based mixer will
not be able to unmute the channels. You will need to download the ALSA-libs,
and ALSA-tools to be able to do anything useful.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------
