Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263996AbRFMPWz>; Wed, 13 Jun 2001 11:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbRFMPWp>; Wed, 13 Jun 2001 11:22:45 -0400
Received: from dialin-194-29-61-34.berlin.gigabell.net ([194.29.61.34]:772
	"EHLO server1.localnet") by vger.kernel.org with ESMTP
	id <S263996AbRFMPWf>; Wed, 13 Jun 2001 11:22:35 -0400
Date: Wed, 13 Jun 2001 17:23:20 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org,
        "Ademar de Souza Reis Jr." <ademar@conectiva.com.br>
Cc: Rolf Schillinger <rolf@sir-wum.de>
Subject: sis630 - help needed debugging in the kernel
Message-Id: <20010613172320.306d5208.rene.rebe@gmx.net>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.10; i686-pc-linux-gnu)
Organization: FreeSourceCommunity ;-)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I currently try to debug why the sisfb driver crashes my machine. (SIS 630
based laptop - linux-2.4.5-ac13).

On my serial-console I get:
[...]
sisfb: framebuffer at 0xe0000000, mapped to 0xcb800000, size 16384k
sisfb: MMIO at 0xefce0000, mapped to 0xcc801000, size 128k
sisfb: encountered LCD # debug output by me
sisfb: fall back to 1024x768 # debug ouput by me
sisfb: LCD mode # debug output by me
sisfb: mode is 800x600x8, linelength=800
[...]
Unable to handle kernel paging request at virtual address cc800180
[oops]

This happens in the method: register_framebuffer called from sisfb_init.

I compared the sisfb_init with other framebuffer drivers and can't find what is wrong.
(I normally don't do kernel hacking...). What does the kernel try to do with the
_io-memory_, mapped around line 2230 in sis_main.c? - Must the memory reqeuested or
mapped in an other way?

Another strange thing is, that the code seems to work for some people ...

I would be nice if anyone could give me a hint - because the sis-drivers (kernel and X)
doesn't work for many people ...

k33p h4ck1n6 René

-- 
René Rebe (Registered Linux user: #127875)
http://www.rene.rebe.myokay.net/
-Germany-

Anyone sending unwanted advertising e-mail to this address will be charged
$25 for network traffic and computing time. By extracting my address from
this message or its header, you agree to these terms.
