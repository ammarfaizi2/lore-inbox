Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVAJABF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVAJABF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVAJABE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:01:04 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:24003 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261982AbVAJAAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:00:46 -0500
Date: Mon, 10 Jan 2005 02:00:43 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bttv/v4l2/Linux 2.6.10-ac8: xawtv hanging in videobuf_waiton
Message-ID: <20050110000043.GA9549@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I start xawtv and alevt in the same window and press 'v' in xawtv,
bttv goes berserk, producing around 25 lines per second of debug stuffs.
(xawtv was also in fullscreen mode when I did this).
alevt quits just fine.

Jan 10 00:43:26 safari kernel: bttv0: OCERR @ 0d1f9014,bits: HSYNC OFLOW OCERR*
Jan 10 00:43:26 safari last message repeated 11 times
Jan 10 00:43:26 safari kernel: bttv0: timeout: drop=0 irq=7236/7236, risc=0d1f901c, bits: HSYNC OFLOW
Jan 10 00:43:26 safari kernel: bttv0: reset, reinitialize
Jan 10 00:43:26 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 00:43:56 safari kernel: bttv0: OCERR @ 0d1f9014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*

...

Jan 10 00:45:36 safari kernel: xawtv         D C05742E0     0  9544   9543          9546       (NOTLB)
Jan 10 00:45:36 safari kernel: cced7e88 00000046 cd358560 c05742e0 c843303c cced7eac d0d76fdc d0d87ea0 
Jan 10 00:45:36 safari kernel:        c84330f0 c72e6000 00000c00 00015389 e6fcc913 000000bd cd3586b8 c843303c 
Jan 10 00:45:36 safari kernel:        cced6000 cced6000 cced7ef0 d0ca78c5 00000046 c05959a0 d0d88334 c84330a8 
Jan 10 00:45:36 safari kernel: Call Trace:
Jan 10 00:45:36 safari kernel:  [<d0ca78c5>] videobuf_waiton+0xa5/0x150 [video_buf]
Jan 10 00:45:36 safari kernel:  [<d0ca8437>] videobuf_read_zerocopy+0xa7/0x110 [video_buf]
Jan 10 00:45:36 safari kernel:  [<d0ca866c>] videobuf_read_one+0x1cc/0x250 [video_buf]
Jan 10 00:45:36 safari kernel:  [<d0d6f60c>] bttv_read+0xfc/0x170 [bttv]
Jan 10 00:45:36 safari kernel:  [<c015a2cf>] vfs_read+0xcf/0x150
Jan 10 00:45:36 safari kernel:  [<c015a5eb>] sys_read+0x4b/0x80
Jan 10 00:45:36 safari kernel:  [<c0103123>] syscall_call+0x7/0xb

xawtv couldn't take kill -9 as an answer, so I had to reboot.

I have gcc-3.4.3, kernel compiled for PPro, UP, no preempt, 8k stacks.

Linux video capture interface: v1.00
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
PCI: Found IRQ 9 for device 0000:00:0b.0
PCI: Sharing IRQ 9 with 0000:00:0b.1
bttv0: Bt878 (rev 2) at 0000:00:0b.0, irq: 9, latency: 64, mmio: 0xe9001000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: enabling ETBF (430FX/VP3 compatibilty)
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=61314, tuner=Philips FI1216 MK2 (5), radio=no
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp3400: Unknown parameter `simple'
msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
msp3410: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok



BTW. one quickie question about I2C:
when I switch channels in xawtv, I get at max 125ms latencies when running
rtc_latencytest.  with the patch below around 1.5ms (same as without xawtv...).
so, I ask is this patch OK (safe, etc)?


--- linux/drivers/i2c/algos/i2c-algo-bit.c.bak	2004-10-19 23:38:52.000000000 +0300
+++ linux/drivers/i2c/algos/i2c-algo-bit.c	2004-10-24 23:29:12.000000000 +0300
@@ -153,6 +153,7 @@ static int i2c_outb(struct i2c_adapter *
 	int ack;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
+	cond_resched();
 	/* assert: scl is low */
 	for ( i=7 ; i>=0 ; i-- ) {
 		sb = c & ( 1 << i );
@@ -195,6 +196,7 @@ static int i2c_inb(struct i2c_adapter *i
 	unsigned char indata=0;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
+	cond_resched();
 	/* assert: scl is low */
 	sdahi(adap);
 	for (i=0;i<8;i++) {

-- 
