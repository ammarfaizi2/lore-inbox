Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbTAMRtI>; Mon, 13 Jan 2003 12:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267884AbTAMRtI>; Mon, 13 Jan 2003 12:49:08 -0500
Received: from atlas.inria.fr ([138.96.66.22]:47287 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S267852AbTAMRtH>;
	Mon, 13 Jan 2003 12:49:07 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Organization: SEMIR - INRIA Sophia Antipolis
To: linux-kernel@vger.kernel.org
Subject: Bug report : i810_audio, compaq evo 410c, 2.4.20
Date: Mon, 13 Jan 2003 18:57:56 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301131857.57093.Nicolas.Turro@sophia.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I have laptops here (compaq evo 410c) that freeze completely while playing 
sound (using mpg123, for example). The crash is random, it may freeze as soon
as playback start of after a few minutes.

lspci :

00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 
02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
02:02.0 USB Controller: NEC Corporation USB (rev 41)
02:02.1 USB Controller: NEC Corporation USB (rev 41)
02:02.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
02:03.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 02)
02:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 09)
02:04.1 Serial controller: Lucent Microelectronics: Unknown device 045c

tail of /var/log/messages after modprobing i810_audio :

Jan 13 18:49:39 sirius kernel: i810: Intel ICH3 found at IO 0x4400 and 0x4000, 
IRQ 5
Jan 13 18:49:39 sirius kernel: i810_audio: Audio Controller supports 6 
channels.
Jan 13 18:49:39 sirius kernel: ac97_codec: AC97 Audio codec, id: ADS99(Analog 
Devices AD1886A)
Jan 13 18:49:39 sirius kernel: i810_audio: AC'97 codec 0 Unable to map 
surround DAC's (or DAC's not present), total channels = 2
Jan 13 18:49:39 sirius kernel: i810_audio: setting clocking to 41319

kernel 2.4.20 + minor patch in ac97_codec.c (    { 0x41445363 ,"Analog Devices 
AD1886A", &null_ops },  added to   ac97_codec_ids ).


any help ?

N. Turro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+Iv4kty/HpgyBIboRAoeXAKCITzfNHrluCeSHwX0pLWLxGRCYlgCbBiIu
leDU2N4tq6+LY4cvg2bj0xk=
=Wm73
-----END PGP SIGNATURE-----
