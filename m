Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSGXMla>; Wed, 24 Jul 2002 08:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSGXMla>; Wed, 24 Jul 2002 08:41:30 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:14000 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S317091AbSGXMl2>; Wed, 24 Jul 2002 08:41:28 -0400
Date: Wed, 24 Jul 2002 14:44:50 +0200 (CEST)
From: Michael De Nil <michael@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Tulip-driver && SMC1255TX -> kernel fails
Message-ID: <Pine.LNX.4.44.0207241441100.21178-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Michael De Nil wrote:

> Hey
>
> I have bought an SMC 1255TX-card.
> In the manual is said that I should use the Tulip-driver.
> I was able to load the module tulip.o from kernel 2.4.19-pre10, but when
I
> start my network (/etc/init.d/networking start) on my debian-machine,
the
> screen starts flashing the message:
> Eth0: (i) System Error occured (0)
> with i = number increasing by 1
>
> I didn't see any of this in the changelog up to rc3..

It looked like it was sharing IRQ with another piece of hardware, when I
remove all other hardware, the card runs just fine.

The insmod-msg I recieved with shared IRQ:

...
PCI: Found IRQ 5 for device 00:14.0
PCI Sharing IRQ 5 with 00:13.0
eth0: SMC EZ Card 10/100 rev 17 at 0xc800, 00:04:E2:3D:AB:52, IRQ 5.


Greetings
	Michael


-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
      Linux LiSa 2.4.19-rc2 #1 vr jul 19 22:10:00 CEST 2002 i686
  14:41:01 up 4 days,  3:56,  8 users,  load average: 0.00, 0.00, 0.00
-----------------------------------------------------------------------

