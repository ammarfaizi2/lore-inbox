Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSE2Azm>; Tue, 28 May 2002 20:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSE2Azl>; Tue, 28 May 2002 20:55:41 -0400
Received: from server0051.freedom2surf.net ([194.106.33.61]:38017 "EHLO
	server0051.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S312962AbSE2Azk>; Tue, 28 May 2002 20:55:40 -0400
Date: Wed, 29 May 2002 02:04:27 +0100
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: [USB OHCI] BUG()
Message-Id: <20020529020427.6a9cdc92.spyro@armlinux.org>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I wrotew a while ago about an oops I was getting with an OPTi OHCI USB
1.1 card, a BUG() at line 464 in one of the usb-ohci.h, IIRC.

well, I since replaced the card with an NEC USB 2.0 card, (and am using
OHCI mode), and am hitting the same BUG().

Here is a cat /proc/pci (trimmed)

Bus  0, device  10, function  0:
  USB Controller: NEC Corporation USB (rev 65).
    IRQ 10.
    Master Capable.  Latency=16.  Min Gnt=1.Max Lat=42.
    Non-prefetchable 32 bit memory at 0xe0800000 [0xe0800fff].
Bus  0, device  10, function  1:
  USB Controller: NEC Corporation USB (#2) (rev 65).
    IRQ 12.
    Master Capable.  Latency=16.  Min Gnt=1.Max Lat=42.
    Non-prefetchable 32 bit memory at 0xe0801000 [0xe0801fff].
Bus  0, device  10, function  2:
  USB Controller: NEC Corporation USB 2.0 (rev 2).
    IRQ 5.
    Master Capable.  Latency=16.  Min Gnt=16.Max Lat=34.
    Non-prefetchable 32 bit memory at 0xe0802000 [0xe08020ff].

This is starting to look like a real bug, not just a 'crap OPTi' bug.

Oh, one other thing - when using my ADSL modem on this USB card, ping
shows up occasional 'wrong' packets. with 2.4.18, this didnt happen (I
suspect it simply oopsed instead). Does this help?

Anyone here want to suggest some debug code?

Kernel 2.4.19-pre8-ac5

On another note, I need my server up and running - can anyone suggest a
PCI USB card / chipset that actually ***works*** on Linux (preferably
UHCI based as all UHCI stuff I tried so far has worked)?

have I justr been exceptionally unlucky and bought two duff chipsets, or
is Linux OHCI just really flakey ?
