Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSA1LYy>; Mon, 28 Jan 2002 06:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287111AbSA1LYo>; Mon, 28 Jan 2002 06:24:44 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:59378 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S287003AbSA1LYf>; Mon, 28 Jan 2002 06:24:35 -0500
Date: Mon, 28 Jan 2002 12:24:29 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: Disconnect <lkml@sigkill.net>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [right one][patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011977347.1788.5.camel@oscar>
Message-ID: <Pine.LNX.4.40.0201281219460.21970-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2002, Disconnect wrote:

> On suggestions from a few people, I tried underclocking the system to
> 1200 mhz (x12 instead of x13) and most of the problems went away.

 hmmm ... interesting ... maybe it has to do with the errata 11 bug ...

> The usb keyboard problems went away (that could relate to other things
> I've been messing with - X seems happier w/ 2 usb keyboards than with
> just 1 for some reason.)

good :)

>
> Testing sound and such, no skips or other issues from xmms, even when
> top reports 70-80% idle.
>
> CPU states:  22.2% user,  10.9% system,  24.7% nice,  42.2% idle
> CPU Temp: +35.8 C     (limit = +51 C,  hysteresis = +49 C)
>
> So I'm about 10C lower than before. Yay :)
>
> Any way to selectively enable/disable this from userspace? (Such that,
> eg, when I'm not watching tv I can enable, when I fire up xawtv and/or
> high-load apps I can disable..)

hmmm .. .someone said it before: you could do this with the setpci
command. i tested it this morning:

kt133/133a and kx133:

enable: setpci -v -H1 -s 0:0.0 52=EB
disable: setpci -v -H1 -s 0:0.0 52=6B

kt266/266a:

enable: setpci -v -H1 -s 0:0.0 92=EB
disable: setpci -v -H1 -s 0:0.0 92=6B

remember: this is without my patch ... if my patch is compiled in and
active, the first "enable" is allready done at startup :)

> Maybe (eventually) base it off load average..? (So load >.8 its
> disabled, below that its selectively enabled - daemon to handle it could
> be taught to check process lists, etc..)

maybee ... i will think about it ...

daniel



# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

