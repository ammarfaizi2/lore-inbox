Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTDGSFU (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTDGSFT (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:05:19 -0400
Received: from [213.171.53.133] ([213.171.53.133]:18703 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S263253AbTDGSFT (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:05:19 -0400
Date: Mon, 7 Apr 2003 22:21:20 +0400
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <15842436780.20030407222120@wr.miee.ru>
To: Linus Torvalds <torvalds@transmeta.com>
CC: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.67
In-Reply-To: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LT>   o ALSA SB16 PnP Update
Hello Linus, Adam and other.
Compile fix.

--- sound/isa/sb/sb16.c~        2003-04-06 00:38:10.000000000 +0400
+++ sound/isa/sb/sb16.c 2003-04-06 00:40:14.000000000 +0400
@@ -331,7 +331,7 @@
                        goto __wt_error;
                }
                awe_port[dev] = pnp_port_start(pdev, 0);
-               snd_printdd("pnp SB16: wavetable port=0x%lx\n", pdev->resource[0].start);
+               snd_printdd("pnp SB16: wavetable port=0x%lx\n", awe_port[dev]);
        } else {
 __wt_error:
                if (pdev) {

