Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVDMMqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVDMMqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 08:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVDMMqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 08:46:11 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:24739 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261326AbVDMMpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 08:45:53 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: Garbage on serial console after serial driver loads
Date: Wed, 13 Apr 2005 12:45:51 +0000 (UTC)
Organization: Wurtelization
Message-ID: <d3j49v$u2j$1@news.cistron.nl>
References: <20050325202414.GA9929@dreamland.darkstar.lan> <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr> <20050326151005.D12809@flint.arm.linux.org.uk> <20050326155549.GA5881@linuxace.com>
X-Trace: ncc1701.cistron.net 1113396351 30803 83.68.3.130 (13 Apr 2005 12:45:51 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester  <kernel@linuxace.com> wrote:
>On Sat, Mar 26, 2005 at 03:10:05PM +0000, Russell King wrote:
>> Doesn't matter.  The problem is that dwmw2's NS16550A patch (from ages
>> ago) changes the prescaler setting for this device so we can use the
>> higher speed baud rates.  This means any programmed divisor (programmed
>> at early serial console initialisation time) suddenly becomes wrong as
>> soon as we fiddle with the prescaler during normal UART initialisation
>> time.
>
>FWIW, I see the same thing here on some Dell Poweredge boxes:
>
>serio: i8042 AUX port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
>ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
><garbage>
>
>But intererstingly, on identical boxes, the garbage only appears on
>those hooked up to a PortMaster device - those using a Cyclades never
>display this problem. (???)

We have a variety of Dell rackmount systems, also on Cyclades, and see
this mess everywhere.

I had reported this problem a little while ago, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=111036598927105&w=2
but unfortunately didn't get any response at that time.


Paul Slootman

