Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUAZR3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 12:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUAZR3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 12:29:47 -0500
Received: from smtp05.web.de ([217.72.192.209]:60189 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264419AbUAZR3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 12:29:45 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.2-rc2] bttv oops
Date: Mon, 26 Jan 2004 18:29:31 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401261829.31719.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on loading the bttv driver I get the following messages:

bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0f.0, irq: 19, latency: 64, mmio: 0xcddfe000
bttv0: using: Lifeview FlyVideo 2000 /FlyVideo A2/ Lifetec LT 9415 TV [LR90] 
[card=54,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00449fff [init]
i2c_adapter i2c-1: registered as adapter #1
bttv0: FlyVideo Radio=yes RemoteControl=no  Tuner=5 gpio=0x449fff
bttv0: FlyVideo  LR90=yes tda9821/tda9820=yes capture_only=no
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... <7>i2c_adapter i2c-1: master_recv: 
reading 1 bytes.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e0cf8fd3
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0f20:[<e0cf8fd3>]    Tainted: P
EFLAGS: 00010202
EIP is at i2c_master_recv+0xc3/0x110 [i2c_core]
eax: 00000000   ebx: e0e6ec60   ecx: e0e6ec60   edx: 00000023
esi: ffffff87   edi: e0e6ec44   ebp: e0e6ee70   esp: dac13e24
ds: 0f3b   es: 0f3b   ss: 0f28
Process modprobe (pid: 1705, threadinfo=dac12000 task=dac146b0)
Stack: e0e6ec44 dac13e3c e0e6eee4 ffffff87 00000001 00000040 00010040 00000001
       dac13e73 00000246 00000080 e0e6ec40 e0e620c8 00000000 e0e5fc7b e0e6ee70
       dac13e73 00000001 00000080 00e6ec40 e0e6ec40 00000000 00000001 e0e17ed8
Call Trace:
 [<e0e5fc7b>] bttv_I2CRead+0x8b/0x100 [bttv]
 [<e0e17ed8>] bttv_init_card2+0x368/0x610 [bttv]
 [<e0e1760b>] bttv_probe+0x47b/0x6b0 [bttv]
 [<c016c162>] dput+0x22/0x210
 [<c01ef032>] pci_device_probe_static+0x52/0x70
 [<c01ef079>] __pci_device_probe+0x29/0x30
 [<c01ef0ac>] pci_device_probe+0x2c/0x50
 [<c0259a0f>] bus_match+0x3f/0x70
 [<c0259b39>] driver_attach+0x59/0x90
 [<c0259ddd>] bus_add_driver+0x8d/0xa0
 [<c025a21f>] driver_register+0x2f/0x40
 [<c0259fd4>] bus_register+0x84/0xa0
 [<c01ef274>] pci_register_driver+0x34/0x50
 [<e0e5b922>] bttv_init_module+0xa2/0x130 [bttv]
 [<c0137e78>] sys_init_module+0x118/0x230
 [<c010942f>] syscall_call+0x7/0xb

Code: 8b 00 c7 04 24 60 ad cf e0 89 44 24 04 e8 ab 97 42 df 8b 44


As you can guess watching tv doesn't work anymore ;)

Thanks,
	Bernd

