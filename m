Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTLGTGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 14:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTLGTGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 14:06:33 -0500
Received: from fmx5.freemail.hu ([195.228.242.225]:43930 "HELO
	fmx5.freemail.hu") by vger.kernel.org with SMTP id S264480AbTLGTGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 14:06:30 -0500
Date: Sun, 7 Dec 2003 20:06:29 +0100 (CET)
From: Max Payne <"max..payne"@freemail.hu>
Subject: [bttv] 2.6.0-testX pctv pro no stereo
To: linux-kernel@vger.kernel.org
Message-ID: <freemail.20031107200629.66614@fm9.freemail.hu>
X-Originating-IP: [81.182.115.12]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a Pinnacle Pctv Pro card. Card's all function working
properly under 2.6.0-testX kernels, except one. I have no
stereo sound. Bttv driver cannot found msp3400 chip. I'ts
weird, because earlier under 2.4 was working.  It's a bttv
bug or what?

insmod bttv.ko

[...]
Dec  7 19:58:05 sun kernel: bttv: driver version 0.9.12 loaded
Dec  7 19:58:05 sun kernel: bttv: using 8 buffers with 2080k
(520 pages) each for capture
Dec  7 19:58:05 sun kernel: bttv: Bt8xx card found (0).
Dec  7 19:58:05 sun kernel: bttv0: Bt878 (rev 17) at
0000:02:03.0, irq: 19, latency: 32, mmio: 0xdc2fd000
Dec  7 19:58:05 sun kernel: bttv0: detected: Pinnacle PCTV
[bswap] [card=39], PCI subsystem ID is bd11:1200
Dec  7 19:58:05 sun kernel: bttv0: using: Pinnacle PCTV
Studio/Rave [card=39,autodetected]
Dec  7 19:58:05 sun kernel: tuner: chip found @ 0xc2
Dec  7 19:58:05 sun kernel: registering 17-0061
Dec  7 19:58:05 sun kernel: bttv0: i2c: checking for MSP34xx
@ 0x80... not found
Dec  7 19:58:05 sun kernel: bttv0: miro: id=16 tuner=1
radio=fmtuner stereo=no
Dec  7 19:58:05 sun kernel: bttv0: using tuner=1
Dec  7 19:58:05 sun kernel: tuner: type set to 1 (Philips
PAL_I (FI1246 and compatibles))
Dec  7 19:58:05 sun kernel: bttv0: i2c: checking for MSP34xx
@ 0x80... not found
Dec  7 19:58:05 sun kernel: bttv0: i2c: checking for TDA9875
@ 0xb0... not found
Dec  7 19:58:05 sun kernel: bttv0: i2c: checking for TDA7432
@ 0x8a... not found
Dec  7 19:58:05 sun kernel: bttv0: registered device video0
Dec  7 19:58:05 sun kernel: bttv0: registered device vbi0
Dec  7 19:58:05 sun kernel: bttv0: registered device radio0
Dec  7 19:58:05 sun kernel: bttv0: PLL: 28636363 => 35468950
.. ok

lsmod

bttv                  121452  0
sch_tbf                 5504  1
md5                     3840  1
ipv6                  248768  14
uhci_hcd               30864  0
ehci_hcd               22020  0
ide_scsi               12548  0
sr_mod                 13220  0
sch_cbq                15104  0
tuner                  14604  0
tvaudio                20620  0
video_buf              17796  1 bttv
i2c_algo_bit            9480  1 bttv
btcx_risc               4104  1 bttv
v4l2_common             4224  1 bttv
videodev                7552  1 bttv
ppp_deflate             4992  0
zlib_deflate           21016  1 ppp_deflate
zlib_inflate           21120  1 ppp_deflate
bsd_comp                5632  0
ppp_async               9856  1
ppp_generic            23824  7 ppp_deflate,bsd_comp,ppp_async
slhc                    6400  1 ppp_generic
usb_storage            24192  0
scsi_mod               64804  3 ide_scsi,sr_mod,usb_storage
hid                    23424  0
ipt_state               1792  1
iptable_filter          2432  1
ipt_MASQUERADE          3456  1
iptable_nat            20516  2 ipt_MASQUERADE
ip_conntrack           27820  3
ipt_state,ipt_MASQUERADE,iptable_nat
ip_tables              16256  4
ipt_state,iptable_filter,ipt_MASQUERADE,iptable_nat
i2c_i801                7184  0
i2c_sensor              2688  0
i2c_core               20872  6
bttv,tuner,tvaudio,i2c_algo_bit,i2c_i801,i2c_sensor
nvidia               1702188  10
i810_audio             27668  2
ac97_codec             17036  1 i810_audio


--------------------------------
Thanks for your attention:

max


