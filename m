Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSLBVRV>; Mon, 2 Dec 2002 16:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbSLBVRU>; Mon, 2 Dec 2002 16:17:20 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265205AbSLBVRE>; Mon, 2 Dec 2002 16:17:04 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Richard Henderson'" <rth@twiddle.net>,
       "'Bjoern Brauel'" <bjb@gentoo.org>
Cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: RE: patch: linux-2.4.20 alpha broken cia(rev1) fix
Date: Mon, 2 Dec 2002 22:23:56 +0100
Message-ID: <003b01c29a49$1f7e3490$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20021201233309.A32203@twiddle.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The attached patch fixes the initialization for CIA revision 1 chips
> that can be found on most Alcor machines. As it is impossible to boot
> such a box together with the Qlogic ISP SCSI controller without this
> patch I believe it is important to include it in the official kernel.

RH> Try this version instead.  Control structures should not be
RH> replicated in different functions like that.  It's a sure
RH> recipie for one of them getting out of sync.

I had problems compiling that one:

make[1]: Leaving directory `/data/src/linux-2.4.20/Documentation/DocBook'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
make: *** No rule to make target `include/linux/autoconf.h', needed by
`include/config/MARKER'.  Stop.

which I find rather strange.
make dep ; make clean ; make boot modules modules_install
should take care of those dependencies, doesn't it?
<...>
Hmmm, for some reason include/linux/autoconf.h doesn't exist at all.
<...>
Oh, I see: I had to run make menuconfig & save the config for that.
That's odd. I just copied my old config to .config, thought that
would do the trick!


Folkert van Heusden
http://www.vanheusden.com/Linux/kernel_patches.php3

