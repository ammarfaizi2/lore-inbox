Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSHDWgz>; Sun, 4 Aug 2002 18:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318254AbSHDWgz>; Sun, 4 Aug 2002 18:36:55 -0400
Received: from dsl-213-023-061-042.arcor-ip.net ([213.23.61.42]:18441 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S318253AbSHDWgy>;
	Sun, 4 Aug 2002 18:36:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Feiler <kiza@gmx.net>
To: Brad Hards <bhards@bigpond.net.au>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Mon, 5 Aug 2002 00:41:32 +0200
User-Agent: KMail/1.4.1
References: <fa.egf7e0v.kk5a2@ifi.uio.no> <200208041746.56274.kiza@gmxpro.net> <200208050751.40894.bhards@bigpond.net.au>
In-Reply-To: <200208050751.40894.bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208050041.33742.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 23:51, you wrote:
>
> What other USB options do you have turned on?

Here's everything either modules or compiled in. Currently with the hid/mouse 
stuff compiled in:
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_VISOR=m

This patch is applied:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101735261202744

>
> What modules do you have loaded?

Mainly alsa, bttv and lm_sensors. I know, I know NVdriver. But it doesn't make 
any difference without loading it.

tvmixer                 3712   0
tuner                   8356   1 (autoclean)
tvaudio                11200   0 (autoclean) (unused)
msp3400                14480   1 (autoclean)
bttv                   67488   0
videodev                5664   3 [bttv]
i2c-algo-bit            7180   1 [bttv]
snd-mixer-oss           9152   0
snd-pcm-oss            36004   1
snd-emu10k1            56228   3
snd-pcm                49472   0 [snd-pcm-oss snd-emu10k1]
snd-timer              10432   0 [snd-pcm]
snd-hwdep               3712   0 [snd-emu10k1]
snd-rawmidi            12864   1 [snd-emu10k1]
snd-seq-device          3920   0 [snd-emu10k1 snd-rawmidi]
snd-util-mem            1232   0 [snd-emu10k1]
snd-ac97-codec         23236   0 [snd-emu10k1]
snd                    25704   1 [snd-mixer-oss snd-pcm-oss snd-emu10k1 
snd-pcm snd-timer snd-hwdep snd-rawmidi snd-seq-device snd-util-mem 
snd-ac97-codec]
soundcore               3684   7 [tvmixer snd]
NVdriver              989184  10
usb-storage            20988   0 (unused)
analog                  7488   0 (unused)
emu10k1-gp              1248   0 (unused)
gameport                1548   0 [analog emu10k1-gp]
via686a                 7812   0 (unused)
i2c-proc                6368   0 [via686a]
i2c-isa                 1220   0 (unused)
i2c-viapro              3848   0 (unused)
i2c-core               12960   0 [tvmixer tuner tvaudio msp3400 bttv 
i2c-algo-bit via686a i2c-proc i2c-isa i2c-viapro]
nls_iso8859-1           2848   2 (autoclean)
nls_cp437               4384   2 (autoclean)
vfat                    9532   2 (autoclean)
fat                    29816   0 (autoclean) [vfat]


-- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/

