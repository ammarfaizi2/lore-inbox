Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUHTBxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUHTBxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUHTBxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:53:12 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:47964 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265148AbUHTBxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:53:00 -0400
Subject: Re: HCI USB on USB 2.0: hci_usb_intr_rx_submit (works with USB 1.1)
From: "Raf D'Halleweyn (list)" <list@noduck.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092049263.21815.18.camel@pegasus>
References: <1091581193.15561.3.camel@alto.dhalleweyn.com>
	 <1092049263.21815.18.camel@pegasus>
Content-Type: text/plain
Date: Thu, 19 Aug 2004 21:52:57 -0400
Message-Id: <1092966777.5230.4.camel@alto.dhalleweyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcel,

This was under 2.6.7, using ehci for USB 2.0 and uhci for 1.1.

Under 2.6.8.1 I get with USB 1.1:
usb 4-1.3: new full speed USB device using address 3
bcm203x_probe: Mini driver request failed
bcm203x: probe of 4-1.3:1.0 failed with error -5
usb 4-1.3: USB disconnect, address 3
usb 4-1.3: new full speed USB device using address 4

but USB 2.0 gives:
usb 1-3.4: new full speed USB device using address 6
ehci_hcd 0000:00:1d.7: qh f7d2d200 (#0) state 1
bcm203x_probe: Mini driver request failed
bcm203x: probe of 1-3.4:1.0 failed with error -5
usb 1-3.4: bulk timeout on ep1in
usb 1-3.4: usbfs: USBDEVFS_BULK failed ep 0x81 len 10 ret -110
usb 1-3.4: USB disconnect, address 6
usb 1-3.4: new full speed USB device using address 7
ehci_hcd 0000:00:1d.7: qh f7d2d280 (#0) state 1
hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c1ad1994 err -28

If I try to do 'hciconfig hci0 up' when connected to USB 2.0 I also get
a 'hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f7e22814 err
-28'.

Thanks,

PS Sorry for the late reply, I just returned from vacation.

Raf.

On Mon, 2004-08-09 at 13:01 +0200, Marcel Holtmann wrote: 
> Hi Ralf,
> 
> > It seems that hci_usb does not like USB 2.0: when I connect a D-Link USB
> > bluetooth dongle (DBT-120) to a USB 2.0 port, I get the following error
> > message when I try to 'hciconfig hci0 up':
> > 
> > hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f768ae94 err -28
> > 
> > If I connect the same dongle through a USB 1.1 hub on the same USB 2.0
> > port, the device comes up and I don't get this error.
> 
> about what kernel version are you talking? What USB host hardware do you
> use?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 

