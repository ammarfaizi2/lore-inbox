Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbSL3HLe>; Mon, 30 Dec 2002 02:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSL3HLe>; Mon, 30 Dec 2002 02:11:34 -0500
Received: from mail2.scram.de ([195.226.127.112]:48134 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id <S266736AbSL3HLd>;
	Mon, 30 Dec 2002 02:11:33 -0500
Date: Mon, 30 Dec 2002 08:19:26 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Markus Pfeiffer <profmakx@profmakx.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alpha port still maintained in 2.5
In-Reply-To: <200212291657.16326.profmakx@profmakx.org>
Message-ID: <Pine.LNX.4.44.0212300815001.9119-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

> I just tried compiling the current 2.5.53 kernel on alpha, and it's obviously
> broken. Before I start tracking down everything, I'd like to know if somebody
> already started working on the new module code and if patches exist, any
> pointers etc. greatly appreciated

The patches at http://www.kernel.org/pub/linux/kernel/people/rusty work OK
for me (I used the "Alpha support for modules" one plus all required
dependencies)...

# uname -a
Linux ayse 2.5.53bk3 #1 Sun Dec 29 11:01:17 CET 2002 alpha unknown unknown
GNU/Linux
# lsmod
Module                  Size  Used by
parport_pc             46600  0 [unsafe]
parport                41064  1 parport_pc [unsafe]
netlink_dev             2816  0
nfsd                  168560  8 [unsafe]
exportfs                4424  1 nfsd
lockd                  80512  2 nfsd [unsafe]
sunrpc                130624  3 nfsd lockd [unsafe]
mct_u232                9636  0
af_packet              19544  1 [unsafe]
usbserial              38296  1 mct_u232
usb_storage           135692  0
snd_usb_audio          60408  0
ov511                  99096  0
snd_rawmidi            20512  1 snd_usb_audio
snd_seq_device          7068  1 snd_rawmidi
snd_pcm                89304  1 snd_usb_audio
snd_timer              16656  1 snd_pcm
snd                    52696  5 snd_usb_audio snd_rawmidi snd_seq_device snd_pcm snd_timer
hid                    73536  0
audio                  58264  0
soundcore               5824  2 snd audio
videodev                9704  1 ov511
mousedev                8072  0
ohci_hcd               28968  0
ehci_hcd               40168  0
usbcore               115768  11 mct_u232 usbserial usb_storage snd_usb_audio ov511 hid audio ohci_hcd ehci_hcd
tmsisa                  6364  1
tms380tr               54320  1 tmsisa
ipv6                  236944  11 [unsafe]
rtc                     8912  0

--jochen

