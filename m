Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUAJR6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUAJR6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:58:52 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:31518 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265290AbUAJR4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:56:40 -0500
Message-ID: <3FFFCC4E.1010008@myrealbox.com>
Date: Sat, 10 Jan 2004 01:56:30 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20040103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 + isaPnP + alsa = scheduling while atomic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have one older motherboard with an isa CM8330 sound chip which works
well under 2.4.x with isaPnP enabled, but I get this with 2.6.1:

Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
pnp: Device 01:01.00 activated.
pnp: Device 01:01.03 activated.
bad: scheduling while atomic!
Call Trace:
  [<c011637d>] schedule+0x57d/0x5a0
  [<c0120c38>] __mod_timer+0xf8/0x180
  [<c0121778>] schedule_timeout+0x58/0xc0
  [<c0121700>] process_timeout+0x0/0x20
  [<c02565f5>] snd_ad1848_mce_down+0xf5/0x1c0
  [<c0257175>] snd_ad1848_probe+0x115/0x280
  [<c0257611>] snd_ad1848_create+0xf1/0x180
  [<c025608a>] snd_cmi8330_probe+0xca/0x300
  [<c0256304>] snd_cmi8330_pnp_detect+0x44/0x60
  [<c01d554b>] card_probe+0x4b/0xa0
  [<c01d5b3e>] pnp_register_card_driver+0x7e/0xa0
  [<c038da3a>] alsa_card_cmi8330_init+0x3a/0x80
  [<c037a74c>] do_initcalls+0x2c/0xa0
  [<c01050ef>] init+0x2f/0x140
  [<c01050c0>] init+0x0/0x140
  [<c0106f61>] kernel_thread_helper+0x5/0x24

error in initcall at 0xc038da00: returned with preemption imbalance
ALSA device list:
   #0: C-Media CMI8330/C3D at 0x534, irq 5, dma 1

If you need more info please let me know in detail how to obtain
it for you.

