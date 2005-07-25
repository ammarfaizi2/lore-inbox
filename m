Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVGYUSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVGYUSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVGYUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:15:25 -0400
Received: from totor.bouissou.net ([82.67.27.165]:51611 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261497AbVGYUOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:14:11 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Date: Mon, 25 Jul 2005 22:14:06 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507251500270.8043-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507251500270.8043-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507252214.06802@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 25 Juillet 2005 21:18, Alan Stern a écrit :
>
> It seems quite clear that the EHCI controller's IRQ line is causing the
> problems.  Just out of curiousity, what happens if you really do remove
> the UHCI driver, keeping only the EHCI driver, and then plug in the mouse?
> Off hand I would expect nothing much to happen -- maybe a line or two in
> the system log, no change to the IRQ counters, and the mouse doesn't work
> (not even erratically).

As you expect, in such a condition (with only ehci loaded), absolutely nothing 
happens when plugging the mouse.

OTOH, a high-speed device is recognized, althouh it generates messages like:

totor kernel: usb 1-5: device not accepting address 3, error -71
totor kernel: usb 1-5: new high speed USB device using ehci_hcd and address 4
totor kernel: usb 1-5: device not accepting address 4, error -71
totor kernel: usb 1-5: new high speed USB device using ehci_hcd and address 5

If plugged to any USB socket, except the two integrated to the motherboard 
connectors plate. There only it fully succeeds without such errors.

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
