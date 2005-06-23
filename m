Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVFWWYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVFWWYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVFWWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:20:35 -0400
Received: from [85.8.12.41] ([85.8.12.41]:46008 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262858AbVFWWOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:14:06 -0400
Message-ID: <42BB3428.6030708@drzeus.cx>
Date: Fri, 24 Jun 2005 00:14:00 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com>
In-Reply-To: <200506231143.34769.bjorn.helgaas@hp.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:

>
>Your 2.6.11 dmesg mentions the VIA IRQ fixup, but the 2.6.12 one
>doesn't.  I bet something's broken there.
>
>Can you try the attached debugging patch?  And please collect the
>output of lspci, too.
>  
>

I tried the attached patch and it had no effect. I also tried porting
the 2.6.11 way of handling the VIA quirk but it didn't have any effect.
I'll try a more complete port tomorrow (it was a bit of a hack this time).

Rgds
Pierre

lspci:

00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O
Controller (rev 03)
00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP
Controller (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
[FireGL 9000] (rev 01)
02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 20)
02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
02:04.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
(rev 01)

