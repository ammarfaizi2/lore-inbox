Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVBYQ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVBYQ2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 11:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVBYQ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 11:28:52 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:19060 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262733AbVBYQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 11:28:49 -0500
Date: Fri, 25 Feb 2005 11:28:20 -0500 (EST)
From: vcjones@networkingunlimited.com (Vincent C Jones)
Subject: Re: 2.6.11-rc5
In-reply-to: <3BjgD-5iu-7@gated-at.bofh.it>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <20050225162820.D403D2240D@X31.networkingunlimited.com>
Organization: Networking Unlimited, Inc.
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BjgD-5iu-7@gated-at.bofh.it> you write:
>
>
>Hey, I hoped -rc4 was the last one, but we had some laptop resource
>conflicts, various ppc TLB flush issues, some possible stack overflows in
>networking and a number of other details warranting a quick -rc5 before
>the final 2.6.11.
>
>This time it's really supposed to be a quickie, so people who can, please 
>check it out, and we'll make the real 2.6.11 asap.

Hmmm. Also seems to have introduced a laptop conflict. Bluetooth no
longer survives a suspend/resume cycle.

IBM ThinkPad X31 (2884-JUU) using hci_usb. Bluetooth service is shut
down before suspend and restarted upon return. Works fine in rc4.

# lspci
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
0000:02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
0000:02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
0000:02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02)
0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab NIC (rev 01)
#

Unlike earlier problems (circa 2.6.10), the bluetooth LED comes back on,
but the drivers complain of no device available and socket in use.

Vince
-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
