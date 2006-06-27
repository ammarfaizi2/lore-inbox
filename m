Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWF0Tdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWF0Tdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWF0Tdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:33:45 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:42438 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030323AbWF0Tdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:33:44 -0400
Subject: Re: [git pull] Input update for 2.6.17
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net>
	 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
	 <20060627063734.GA28135@kroah.com>
	 <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 21:33:38 +0200
Message-Id: <1151436818.25011.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> > Yes, if you have the UHCI driver loaded first, then when EHCI is loaded,
> > it disconnects everything on the bus and re-enumerates it.
> > 
> > But EHCI is built into the kernel first, before UHCI, so unless you are
> > using modules, nothing should be getting disconnected at boot time.
> 
> Yeah, that's not it.
> 
> It _seems_ to be triggered by this:
> 
> 	Bluetooth: HCI device and connection manager initialized
> 	Bluetooth: HCI socket layer initialized
> 	usb 5-1: USB disconnect, address 2
> 	usb 5-1: new full speed USB device using uhci_hcd and address 4
> 	usb 5-1: configuration #1 chosen from 1 choice
> 	Bluetooth: HCI USB driver ver 2.9
> 	usbcore: registered new driver hci_usb

I actually doubt that it is any of Bluetooth modules, but to be sure you
might boot the next time without the hci_usb driver around.

Regards

Marcel


