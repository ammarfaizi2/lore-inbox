Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTDYTv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTDYTv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:51:58 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:42926 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id S263737AbTDYTv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:51:56 -0400
From: folkert@vanheusden.com
Date: Fri, 25 Apr 2003 22:04:07 +0200 (CEST)
To: <linux-kernel@vger.kernel.org>
Subject: problems with orinoco_plx and prims I card with version 0.13d of
 the drivers (fwd)
Message-ID: <Pine.LNX.4.33.0304252203280.3618-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have Prism I compatible card with intersil firmware version 0.8.3.
I'm using linux kernel 2.4.20 with orinoco-drivers 0.13d
The network-card is a SMC EZ Connect Wireless PCI Card. According to the
manual, it is a SMC2602W.
The card sits in a Pentium 233MMX (pentium-i so to say).

When I load the drivers, I get:
Apr 24 21:43:45 hobbel kernel: hermes.c: 4 Dec 2002 David Gibson
<hermes@gibson.dropbear.id.au>
Apr 24 21:43:45 hobbel kernel: orinoco.c 0.13d (David Gibson
<hermes@gibson.dropbear.id.au> and others)
Apr 24 21:43:45 hobbel kernel: orinoco_plx.c 0.13d (Daniel Barlow
<dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)
Apr 24 21:43:45 hobbel kernel: orinoco_plx: CIS:
8801:03:1F00:BA00:B4FF:8817:D04:D067:235A:5208:21FF:F41D:8705:ED01:2F67:C55A:
Apr 24 21:43:45 hobbel kernel: orinoco_plx: Local Interrupt already
enabled
Apr 24 21:43:45 hobbel kernel: Detected Orinoco/Prism2 PLX device at
00:0e.0 irq:15, io addr:0x6600
Apr 24 21:43:45 hobbel kernel: eth0: Station identity 001f:0003:0000:0008
Apr 24 21:43:45 hobbel kernel: eth0: Looks like an Intersil firmware
version 0.8.3
Apr 24 21:43:45 hobbel kernel: eth0: Ad-hoc demo mode supported
Apr 24 21:43:45 hobbel kernel: eth0: IEEE standard IBSS ad-hoc mode
supported
Apr 24 21:43:45 hobbel kernel: eth0: WEP supported, 104-bit key
Apr 24 21:43:45 hobbel kernel: eth0: MAC address 00:04:E2:2A:42:0B
Apr 24 21:43:45 hobbel kernel: eth0: Station name "Prism  I"
Apr 24 21:43:45 hobbel kernel: eth0: ready

All fine up to there.
But then I try to configure the card, and then things go wrong:

iwconfig eth0 essid "VANHEUSDENDOTCOM"
iwconfig eth0 channel 6
iwconfig eth0 mode Managed

After the first command I get:
Apr 24 21:44:34 hobbel kernel: hermes @ IO
0x6600: Timeout waiting for command completion.
Apr 24 21:44:34 hobbel kernel: eth0: Unable to disable port while
reconfiguring card
Apr 24 21:44:34 hobbel kernel: eth0: Resetting instead...

The channel-command completely fails! And that is strange since it worked
before (with the standard drivers from kernel 2.4.20).

After that, everything keeps on failing:
Apr 24 21:44:38 hobbel kernel: hermes @ IO 0x6600: Timeout waiting for
command completion.
Apr 24 21:44:38 hobbel kernel: eth0: Error -110 setting multicast list.
Apr 24 21:45:00 hobbel kernel: hermes @ IO 0x6600: Timeout waiting for
command completion.
Apr 24 21:45:00 hobbel kernel: eth0: Error -110 setting MAC address
Apr 24 21:45:00 hobbel kernel: eth0: Error -110 configuring card
Apr 24 21:45:02 hobbel kernel: hermes @ IO 0x6600: Timeout waiting for
command completion.
Apr 24 21:45:02 hobbel kernel: eth0: Error -110 setting MAC address
Apr 24 21:45:02 hobbel kernel: eth0: Error -110 configuring card
Apr 24 21:45:02 hobbel kernel: hermes @ IO 0x6600: Error -16 issuing
command.
Apr 24 21:45:02 hobbel kernel: eth0: Error -16 setting MAC address
Apr 24 21:45:02 hobbel kernel: eth0: Error -16 configuring card
Apr 24 21:45:08 hobbel kernel: hermes @ IO 0x6600: Error -16 issuing
command.

I cannot ping anything on the network, then.
(the accesspoint and its configuration is actually working fine: I have a
belkin-card in my laptop which works like a charm)

If I can test anything to fix this problem, new drivers, new kernel,
whatever: no problem!


Folkert


