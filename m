Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264682AbUDVVVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbUDVVVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUDVVVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:21:02 -0400
Received: from everest.2mbit.com ([24.123.221.2]:17639 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S264682AbUDVVUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:20:53 -0400
From: Andrew D Kirch <trelane@trelane.net>
Reply-To: trelane@trelane.net
To: evolution@lists.ximian.com, linux-kernel@vger.kernel.org
Organization: Summit Open Source Development Group
Message-Id: <1082668904.16612.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 16:21:44 -0500
X-Scan-Signature: 8f3afb52ccb27b67846dd34d6f140aed
X-SA-Exim-Connect-IP: 24.123.221.4
X-SA-Exim-Mail-From: trelane@trelane.net
Subject: sync'ing evolution with 2.6/udev
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hEH8tVKs6dPjjOgx8QYO"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 14:56:42 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hEH8tVKs6dPjjOgx8QYO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is a bit of an odd cross post, but please stick with me if you
will...

I am attempting to add a USB cradle (Visor Prism if anyone cares) with
Evolution.  /var/log/messages gives me the following output:

Apr 22 16:01:36 localhost kernel: usb 2-2: new full speed USB device
using address 10
Apr 22 16:01:37 localhost usb.agent[29165]: ... no modules for USB
product 82d/100/100
Apr 22 16:01:42 localhost kernel: usb 2-2: USB disconnect, address 10

I'm not seeing a device mapped to /dev (watch 'ls -aslR | wc -l') during
a sync doesn't show a change in total files.  This means I've not got a
device to bind the cradle to ie /dev/ttyUSBN.
My hardware follows:
Athlon 64 3200+
Gigabyte G7VNXP=20
1024mb PC-3200ddr
Nvidia GeForce FX 5700

running:
Linux gentoo64 2.6.5 #1 Wed Apr 21 10:56:50 EST 2004 x86_64 4  GNU/Linux

/proc/modules:
ohci_hcd 17348 0 - Live 0xffffffffa037b000
uhci_hcd 29088 0 - Live 0xffffffffa0372000
via_rhine 18888 0 - Live 0xffffffffa036c000
mii 4544 1 via_rhine, Live 0xffffffffa0369000
r8169 10692 0 - Live 0xffffffffa0365000
parport_pc 36672 0 - Live 0xffffffffa035b000
parport 37708 1 parport_pc, Live 0xffffffffa0350000
nvidia 2564596 0 - Live 0xffffffffa00dc000
ide_scsi 14724 0 - Live 0xffffffffa00d7000
i2c_viapro 6732 0 - Live 0xffffffffa00d4000
i2c_isa 2432 0 - Live 0xffffffffa00d2000
adm1021 12168 0 - Live 0xffffffffa00ce000
eeprom 7048 0 - Live 0xffffffffa00cb000
it87 21580 0 - Live 0xffffffffa00c4000
i2c_sensor 2688 3 adm1021,eeprom,it87, Live 0xffffffffa00c2000
snd_emu10k1_synth 7040 0 - Live 0xffffffffa00bf000
snd_emu10k1 85924 1 snd_emu10k1_synth, Live 0xffffffffa00a9000
snd_ac97_codec 64196 1 snd_emu10k1, Live 0xffffffffa0098000
snd_emux_synth 36736 1 snd_emu10k1_synth, Live 0xffffffffa008e000
snd_seq_virmidi 6208 1 snd_emux_synth, Live 0xffffffffa008b000
snd_seq_midi_emul 8576 1 snd_emux_synth, Live 0xffffffffa0087000
snd_hwdep 7944 2 snd_emu10k1,snd_emux_synth, Live 0xffffffffa0084000
snd_util_mem 3968 2 snd_emu10k1,snd_emux_synth, Live 0xffffffffa0082000
snd_seq_midi 7104 0 - Live 0xffffffffa007f000
snd_rawmidi 20896 3 snd_emu10k1,snd_seq_virmidi,snd_seq_midi, Live
0xffffffffa0078000
ide_tape 34272 0 - Live 0xffffffffa006e000
st 37476 0 - Live 0xffffffffa0063000
sbp2 21960 0 - Live 0xffffffffa005c000
ohci1394 30404 0 - Live 0xffffffffa0053000
ieee1394 98264 2 sbp2,ohci1394, Live 0xffffffffa003a000
usb_storage 67328 0 - Live 0xffffffffa0028000
hid 23808 0 - Live 0xffffffffa0021000
ehci_hcd 24836 0 - Live 0xffffffffa0019000
usbcore 95856 7 ohci_hcd,uhci_hcd,usb_storage,hid,ehci_hcd, Live
0xffffffffa0000000

Let me know if more detail will help, or if further crossposting is
unwanted (apologies)


--=-hEH8tVKs6dPjjOgx8QYO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAiDdoFtaZXQJvIM8RArTfAJ4135XdmTeM6tLTRgCi/wVpyD5HawCfSwDO
365ctvf7s/n+h+77IDz2i9s=
=rGBe
-----END PGP SIGNATURE-----

--=-hEH8tVKs6dPjjOgx8QYO--

