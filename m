Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbUCUOsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263659AbUCUOsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:48:15 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:50386 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263658AbUCUOsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:48:10 -0500
Message-ID: <405DAB2B.6050504@hotmail.com>
Date: Sun, 21 Mar 2004 09:48:11 -0500
From: Colin <cwvca_blah@hotmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bttv driver no longer works with xawtv
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use my WinFast TV 2000 XP card with xawtv and all the 
channels appear fuzzy or are appearing in the wrong spots.  The kernel 
worked fine with the 2.4 line of kernels but it no longer works properly 
with the 2.6 line.

I'm using Debian sarge (soon to be version 3.1).  I asked the maintainer of 
the xawtv package about this problem and he insists that the problem is 
with the driver itself saying that the NTSC frequency table in the driver 
is wrong.  I'm using version 2.6.4 of the kernel.

I think the card is detected properly:

Mar 13 10:23:01 raven kernel: bttv: driver version 0.9.12 loaded
Mar 13 10:23:01 raven kernel: bttv: using 8 buffers with 2080k (520 pages) each
for capture
Mar 13 10:23:01 raven kernel: bttv: Bt8xx card found (0).
Mar 13 10:23:01 raven kernel: bttv0: Bt878 (rev 17) at 0000:02:0a.0, irq: 
22, la
tency: 64, mmio: 0xefefe000
Mar 13 10:23:01 raven kernel: bttv0: detected: Leadtek WinFast TV 2000 
[card=34]
, PCI subsystem ID is 107d:6606
Mar 13 10:23:01 raven kernel: bttv0: using: Leadtek WinFast 2000/ WinFast 
2000 X
P [card=34,autodetected]
Mar 13 10:23:01 raven kernel: bttv0: gpio: en=00000000, out=00000000 
in=00bf7707
  [init]
Mar 13 10:23:01 raven kernel: bttv0: using tuner=5
Mar 13 10:23:01 raven kernel: bttv0: i2c: checking for MSP34xx @ 0x80... 
not fou
nd
Mar 13 10:23:01 raven kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... 
not fou
nd
Mar 13 10:23:01 raven kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... 
not fou
nd
Mar 13 10:23:01 raven kernel: tuner: chip found at addr 0xc2 i2c-bus bt878 
#0 [s
w]
Mar 13 10:23:01 raven kernel: tuner: type set to 5 (Philips PAL_BG (FI1216 
and c
ompatibles)) by bt878 #0 [sw]
Mar 13 10:23:01 raven kernel: bttv0: registered device video0
Mar 13 10:23:01 raven kernel: bttv0: registered device vbi0
Mar 13 10:23:01 raven kernel: bttv0: registered device radio0
Mar 13 10:23:01 raven kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Mar 13 10:23:01 raven kernel: bttv0: add subdevice "remote0"
Mar 13 10:23:01 raven kernel: bttv0: PLL can sleep, using XTAL (28636363).
Mar 13 10:23:03 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=29f9e000,rc=29f9e01c]
Mar 13 10:23:05 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=29f9d000,rc=29f9d01c]
Mar 13 10:23:06 raven last message repeated 2 times
Mar 13 10:23:07 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=2ac96000,rc=2ac9601c]
Mar 13 10:23:07 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=2ac96000,rc=2ac9601c]
Mar 13 10:23:11 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=28151000,rc=2815101c]
Mar 13 10:23:11 raven last message repeated 3 times
Mar 13 10:38:06 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=1b1df000,rc=1b1df01c]
Mar 13 10:38:17 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=23d5f000,rc=23d5f01c]
Mar 13 10:38:22 raven last message repeated 2 times
Mar 13 10:38:44 raven kernel: bttv0: skipped frame. no signal? high irq 
latency?
  [main=29e51000,o_vbi=29e51018,o_field=20f2f000,rc=20f2f01c]
...

