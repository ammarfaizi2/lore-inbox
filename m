Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTLKDop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 22:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLKDop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 22:44:45 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:38306 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S264334AbTLKDon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 22:44:43 -0500
Subject: Re: PPP over ttyUSB (visor.o, Treo)
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <1071105744.1154.1.camel@chevrolet.hybel>
References: <20031210165540.B26394@fi.muni.cz>
	 <20031210212807.GA8784@kroah.com> <1071105744.1154.1.camel@chevrolet.hybel>
Content-Type: text/plain
Message-Id: <1071114290.750.18.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 04:44:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 11.12.2003 kl. 02.22 skrev Stian Jordet:
> ons, 10.12.2003 kl. 22.28 skrev Greg KH:
> > Can you try the patch below?  I think it will fix the problem.
> 
> Fixes it for me. Thanks :)
> 
Uhm.. I was a bit too fast. It fixed the problem, okay, but it makes the
kernel spit out a lot of these messages:


Dec 11 02:29:40 chevrolet kernel: usb 1-1: USB disconnect, address 7
Dec 11 02:29:40 chevrolet kernel: hub 1-0:1.0: new USB device on port 1,
assigned address 8
Dec 11 02:29:40 chevrolet kernel: input: USB HID v1.10 Keyboard
[Logitech USB Receiver] on usb-0000:00:11.2-1
Dec 11 02:29:40 chevrolet kernel: input: USB HID v1.10 Mouse [Logitech
USB Receiver] on usb-0000:00:11.2-1
Dec 11 02:33:59 chevrolet kernel: usb 1-1: USB disconnect, address 8
Dec 11 02:33:59 chevrolet kernel: hub 1-0:1.0: new USB device on port 1,
assigned address 9
Dec 11 02:33:59 chevrolet kernel: input: USB HID v1.10 Keyboard
[Logitech USB Receiver] on usb-0000:00:11.2-1
Dec 11 02:33:59 chevrolet kernel: input: USB HID v1.10 Mouse [Logitech
USB Receiver] on usb-0000:00:11.2-1
Dec 11 02:34:15 chevrolet kernel: usb 1-1: USB disconnect, address 9
Dec 11 02:34:16 chevrolet kernel: hub 1-0:1.0: new USB device on port 1,
assigned address 10
Dec 11 02:34:16 chevrolet kernel: input: USB HID v1.10 Keyboard
[Logitech USB Receiver] on usb-0000:00:11.2-1
Dec 11 02:34:16 chevrolet kernel: input: USB HID v1.10 Mouse [Logitech
USB Receiver] on usb-0000:00:11.2-1
Dec 11 02:35:15 chevrolet kernel: usb 1-1: USB disconnect, address 10
Dec 11 02:35:15 chevrolet kernel: hub 1-0:1.0: new USB device on port 1,
assigned address 11
Dec 11 02:35:20 chevrolet kernel: usb 1-1: control timeout on ep0out

Untill finally this last line makes my mouse stop working :( Won't help
unplug/replug, have to restart to make it work again.. I'm using the
ftdi_sio driver. It might be a problem with that, but since pppd won't
work without the patch, I don't know...

Best regards,
Stian

