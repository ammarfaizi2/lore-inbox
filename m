Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTDMTTY (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 15:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTDMTTX (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 15:19:23 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:8198 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id S261893AbTDMTTV convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 15:19:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: BUG: sleeping function called from illegal context
Date: Sun, 13 Apr 2003 21:31:03 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304132131.03545.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i saw that one after modprobe snd-sb16...
kernel 2.5.67-bk

rgds
-daniel


Debug: sleeping function called from illegal context at mm/slab.c:1664
Call Trace:
 [<c0120777>] __might_sleep+0x5f/0x68
 [<c0148f35>] kmalloc+0x61/0x174
 [<c01292f7>] __request_region+0x1b/0xb4
 [<c01293aa>] __check_region+0x1a/0x40
 [<c01dc533>] pnp_check_port+0x5f/0x13c
 [<c01de28b>] pnp_manual_config_dev+0x12b/0x2fc
 [<c88c01f7>] snd_card_sb16_pnp+0x123/0x1bc [snd_sb16]
 [<c88c2580>] sb16_pnpc_driver+0x0/0xb4 [snd_sb16]
 [<c889906f>] +0x6f/0x59c [snd_sb16]
 [<c88c249c>] snd_sb16_pnpids+0x3dc/0x474 [snd_sb16]
 [<c88c2580>] sb16_pnpc_driver+0x0/0xb4 [snd_sb16]
 [<c88c249c>] snd_sb16_pnpids+0x3dc/0x474 [snd_sb16]
 [<c88c2580>] sb16_pnpc_driver+0x0/0xb4 [snd_sb16]
 [<c88c02c5>] snd_sb16_pnp_detect+0x35/0x64 [snd_sb16]
 [<c88c249c>] snd_sb16_pnpids+0x3dc/0x474 [snd_sb16]
 [<c01dae4b>] card_probe+0x3f/0x68
 [<c88c249c>] snd_sb16_pnpids+0x3dc/0x474 [snd_sb16]
 [<c88c2580>] sb16_pnpc_driver+0x0/0xb4 [snd_sb16]
 [<c01db8ff>] pnp_register_card_driver+0x17f/0x19c
 [<c88c2580>] sb16_pnpc_driver+0x0/0xb4 [snd_sb16]
 [<c88c1fc0>] port+0x0/0x20 [snd_sb16]
 [<c88996a7>] alsa_card_sb16_init+0x83/0xbc [snd_sb16]
 [<c88c2580>] sb16_pnpc_driver+0x0/0xb4 [snd_sb16]
 [<c88c2634>] possible_ports.1451+0x0/0x2c [snd_sb16]
 [<c889959c>] snd_sb16_probe_legacy_port+0x0/0x88 [snd_sb16]
 [<c88c2660>] +0x0/0xe0 [snd_sb16]
 [<c013f366>] sys_init_module+0x222/0x2d8
 [<c010b65f>] syscall_call+0x7/0xb

pnp: res: The resources requested do not match those set for the PnP device '01:01.00'.
sb16: no OPL device at 0x388-0x38a


