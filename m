Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271721AbTHMJFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271718AbTHMJFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:05:34 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:57359 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271721AbTHMJF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:05:26 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [2.6-test3] bttv driver confuses PS2 mouse
Date: Wed, 13 Aug 2003 11:05:09 +0200
User-Agent: KMail/1.5.3
References: <200308092104.48878.fsdeveloper@yahoo.de> <20030811121546.GA8998@bytesex.org> <200308111813.56558.fsdeveloper@yahoo.de>
In-Reply-To: <200308111813.56558.fsdeveloper@yahoo.de>
Cc: video4linux-list@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308131105.21689.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I'm running linux-2.6.0-test3 with this patch:
(without the patch, bttv doesn't run)
http://bytesex.org/patches/2.6.0-test3/patch-2.6.0-test3-kraxel.gz

My tv application runs fine, but every few minutes, the
bttv driver re-initializes itself:

Aug 12 23:36:29 lfs kernel: bttv0: IRQ lockup, cleared int mask
Aug 12 23:36:29 lfs kernel: rtc: lost some interrupts at 1024Hz.
Aug 12 23:36:29 lfs kernel: bttv0: timeout: risc=185357c4, bits: VSYNC HSYNC RISCI
Aug 12 23:36:29 lfs kernel: bttv0: reset, reinitialize
Aug 12 23:36:29 lfs kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug 12 23:37:33 lfs kernel: bttv0: skipped frame. no signal? high irq latency?

Sometimes during this re-initialization, my
ps/2 mouse looses synchronization:

Aug 12 23:37:33 lfs kernel: bttv0: IRQ lockup, cleared int mask
Aug 12 23:37:33 lfs kernel: psmouse.c: Lost synchronization, throwing 2 bytes away.
Aug 12 23:37:33 lfs kernel: bttv0: timeout: risc=08e8f9e4, bits: VSYNC HSYNC RISCI
Aug 12 23:37:33 lfs kernel: bttv0: reset, reinitialize
Aug 12 23:37:33 lfs kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug 12 23:37:33 lfs kernel: psmouse.c: Lost synchronization, throwing 2 bytes away.
Aug 12 23:38:01 lfs kernel: bttv0: skipped frame. no signal? high irq latency?

Then the mouse jumps randomly over the screen and I have to
restart X.

I'm running a bt878 card with tvtime as tv-app.

I hope this helps.

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Animals on this machine: some GNUs and Penguin 2.6.0-test3

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Of9NoxoigfggmSgRAk/SAJ9QoyyjU9sM3m7vj2S6n5PnE7UeMACfRxk1
Wid502ZTxWmhE6LxPGYMH7A=
=uShv
-----END PGP SIGNATURE-----

