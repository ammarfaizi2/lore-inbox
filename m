Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRKLQhl>; Mon, 12 Nov 2001 11:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280837AbRKLQhc>; Mon, 12 Nov 2001 11:37:32 -0500
Received: from m91-mp1-cvx1c.lee.ntl.com ([62.252.236.91]:9857 "EHLO
	box.penguin.power") by vger.kernel.org with ESMTP
	id <S280836AbRKLQhU>; Mon, 12 Nov 2001 11:37:20 -0500
Date: Mon, 12 Nov 2001 16:36:04 +0000
From: Gavin Baker <gavbaker@ntlworld.com>
To: Stuart Young <sgy@amc.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SiS630 and 5591/5592 AGP
Message-ID: <20011112163604.A5384@box.penguin.power>
In-Reply-To: <20011111185930.A2700@box.penguin.power> <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet>; from sgy@amc.com.au on Mon, Nov 12, 2001 at 10:26:28AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >My new laptop has this combination and the sis framebuffer driver
> >mangles the display. The sis X driver produces a nice lavalamp style
> >pattern that fades to white, the kernel stays alive but the machine
> >needs a reboot to fix the display in both cases.
> >
> >Im guessing the lack of 5591/5592 AGP support is the problem, and I
> >was just wondering if anyone is working on this or should i go bug SiS?
> 
> You've got the same problem I have. There is something weird with the way 
> some laptops (and LCD based desktops) handle this display, and the only way 
> I've gotten around it is to use the VesaFB driver (which is heaps slower 
> than the accelerated driver), and then either use the FB driver for X 
> (which is buggy IMHO, crashes if it gets too much to do buffered up), or 
> disable the mode changes and use the SiS accelerated X driver.

Im currently using vesa for X, I would like to get some kind of acceleration
to play DVD's etc. I've tried the sis_drv in X 4.1 with the lavalamp
style effect i mentioned, the sis driver in X3.x gets the screen offset
totally wrong, ie the center of the screen is on the far right of the
physical screen, but this is a problem i can direct to the X lists.
 
> Alan has new drivers in his ac tree. but I've tried them, and no luck. Give 
> them a shot and see how you go. You might be lucky.

This is on 2.4.13-ac8, sisfb also messes up the screen offset,
CONFIG_AGP_SIS is turned off as Configure.help mentions it doesn't
support the 5591/5592.

> Out of interest, what model/manufacturer is the notebook? The machines I'm 
> having problems with are Clevo LP200S's, which is an upright LCD machine, 
> with the h/drive and power supply down in the stand/foot.

This is an "Advent 5490", which i think is Pc-World(tm)'s own brand name
they've applied to an oem laptop made by someone else, but i could have
this the wrong way around/totally wrong. It's a 900mhz celeron (coppermine), 
SiS everything.

Im sure other laptops with different badges on them will have the same
internals.

> Once we get everything working with Linux, they'll suit the application we 
> have for them rather nicely. *sigh*

I've mailed SiS asking them if they have any support planned, no reply
as yet, heres to hoping...

> Q: Slightly related, have you gotten the sound to work? Driver loads, I get 
> "Unknown Codec" and an empty codec value. Reloading the driver makes no 
> difference (even numerous times). Wondering if your system is the same...

Everything else (except the software modem, which i have no use for)
worked straight out of the tin with RedHat 7.2's vanilla kernel. Im
current using Alans 2.4.13-ac8:

/sbin/modprobe trident

Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version
0.14.9d,
23:06:41 Nov 11 2001
PCI: Found IRQ 11 for device 00:01.4
PCI: Sharing IRQ 11 with 00:03.0
trident: SiS 7018 PCI Audio found at IO 0xd400, IRQ 11
ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
ac97_codec: AC97 Modem codec, id: 0x5349:0x4c22 (Silicon Laboratory
Si3036)

It works perfectly, as does the NIC.

Cheers, Gavin Baker
