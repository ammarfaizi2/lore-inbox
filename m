Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSJYN0X>; Fri, 25 Oct 2002 09:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSJYN0X>; Fri, 25 Oct 2002 09:26:23 -0400
Received: from gate.gau.hu ([192.188.242.65]:62688 "EHLO gate.gau.hu")
	by vger.kernel.org with ESMTP id <S261402AbSJYN0P>;
	Fri, 25 Oct 2002 09:26:15 -0400
Date: Fri, 25 Oct 2002 15:32:25 +0200 (CEST)
From: Cajoline <cajoline@andaxin.gau.hu>
To: linux-kernel@vger.kernel.org
Subject: ASUS TUSL2-C and Promise Ultra100 TX2
Message-ID: <Pine.LNX.4.44.0210251530530.4572-100000@andaxin.gau.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I recently setup a box with the following components:
Intel Celeron 1300 MHz
ASUS TUSL2-C motherboard
2 x Promise Ultra100 TX2 controllers

Any 2.4 kernel I have tried on this machine displays this strange
behavior: any drives attached to the PDC controllers only work at udma
mode 2 (UDMA33).
I have tried removing either one of the controllers, removing display and
network adapters, changing PCI slots, anything I could think of. It
doesn't make any difference.
I even tried to force udma 5, for example, with hdparm -X69 /dev/hdX, but
that didn't work either.
I finally tried another Promise Ultra66 controller I have. That works as
expected: the drives are detected as udma 4 (UDMA66).

What's even funnier is that if I try to copy files from a filesystem on a
drive attached to a PDC20268 and a drive attached to the motherboard
controller (PIIX4 chipset), the system eventually locks up (after about 3
GB).
What I mean by this is that there are no errors whatsoever, from the
kernel ide driver, from the filesystem, nothing at all. It just stops
responding to anything: login at the console, shell commands, network
daemons, everything stops working. You can't even reboot it - a hard reset
is required.

And apart from this, there are no errors in general, nothing out of the
ordinary in the boot messages, except for the fact that hard disks are
detected as UDMA(33).

So I have come to the conclusion there must be some rather bizarre
incompatibility between the PDCs and this motherboard.
Let me note that the PDC controllers do work just fine with other older
motherboards. And another thing, during boot-up, the PDCs do show the
drives attached to it, detected at the right udma mode.

I was wondering if anyone has come across this specific problem. I browsed
thoroughly through the list archives, but I didn't find any mention of the
specific motherboard, or even the PIIX4 chipset and these controllers.
I know there is probably no way I can get this hardware to work together,
yet I'm curious to know if this has occurred to someone else as well.

Regards,
Cajoline Leblanc

