Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280840AbRKLRGz>; Mon, 12 Nov 2001 12:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280852AbRKLRGn>; Mon, 12 Nov 2001 12:06:43 -0500
Received: from olinz-dsl-0250.utaonline.at ([212.152.234.250]:47090 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S280840AbRKLRGP>;
	Mon, 12 Nov 2001 12:06:15 -0500
Message-ID: <3BF0000B.6F118A43@falke.mail>
Date: Mon, 12 Nov 2001 17:59:55 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SiS630 and 5591/5592 AGP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: tw@webit.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alright, AFAIK it's like this:

The SiS630 - although only one chip - contains a real bunch of
components, such as SiS300 (vga), SiS900 (network) etc. In general, all
the SiS "chips" that list in lspci are actually part of the SiS630.

The vga component, as said, the SiS300, is capable of using either
direct vga output (standard vga connector) as well a video bridge, most
of the cases SiS301.

The SiS301 is responsible for controlling TV-out and LCD panels.

The problem with the current driver for Linux (kernel) and XFree ist,
that SiS did not release any (up-to-date) data sheets on the SiS301.

Thus nobody knows how to tell the SiS300 how to tell the SiS301 that it
should enable output on - let's say - a LCD panel.

The current work-around is as Stuart said: We are forced to use VESA (ie
the BIOS) to set up a display on the LCD panel. Apart from the display
(mode) setup, the xfree sis_drv.o works perfectly. (The same applies for
SiS630 on standard CTR on vga connector; this works even without a
patch)

I've been using Stuart's patch for quite a while now and it works
flawlessly.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:
mailto:tw@webit.com              http://www.webit.com/tw
ICQ #63288080

