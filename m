Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTJKRAa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbTJKRAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:00:30 -0400
Received: from ns.tasking.nl ([195.193.207.2]:44815 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S263351AbTJKRAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:00:25 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: 2.6.0-test7: change in color depth of /dev/video0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <2fde.3f8836ec.6380d@altium.nl>
Date: Sat, 11 Oct 2003 16:59:24 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since linux-2.6.0-test7, xawtv complains about a color depth mismatch,
and gives me a black screen:

$ xawtv               
This is xawtv-3.72, running on Linux/i686 (2.6.0-test7)
WARNING: v4l and x11 disagree about the color depth
WARNING: fbuf.depth=24, x11 depth=16
WARNING: Is v4l-conf installed correctly?
WARNING: overlay mode disabled

With linux-2.6.0-test6 and earlier kernel, xawtv used to work just fine.
The output of v4l-conf has not changed:

$ v4l-conf
v4l-conf: using X11 display :0.0
dga: version 2.0
mode: 1280x1024, depth=16, bpp=16, bpl=2560, base=0xe8041000
/dev/video0 [v4l2]: ioctl VIDIOC_QUERYCAP: Invalid argument
/dev/video0 [v4l]: configuration done

Here are the boot messages:

Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 0000:00:10.0, irq: 10, latency: 32, mmio: 0xec100000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: enabling ETBF (430FX/VP3 compatibilty)
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=61344, tuner=Philips FM1216 (5), radio=yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
msp34xx: init: chip=MSP3415D-A2 +nicam +simple
msp3410: daemon started
registering 0-0040
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8
SAA5249 driver (SAA5249 interface) for VideoText version 1.7
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
registering 0-0061

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

