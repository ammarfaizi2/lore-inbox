Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTEFJhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbTEFJhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:37:04 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:35212 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S262482AbTEFJhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:37:03 -0400
Date: Tue, 6 May 2003 12:49:34 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm1
In-Reply-To: <20030505164505.GA1177@kroah.com>
Message-ID: <Pine.LNX.4.50L0.0305061243450.4098-100000@webdev.ines.ro>
References: <20030504231650.75881288.akpm@digeo.com>
 <Pine.LNX.4.50L0.0305051826500.4098-100000@webdev.ines.ro>
 <20030505164505.GA1177@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've tried plain 2.5.69 and -mm1, with all the combinations of acpi 
and local apic (enabled and disabled), and it still doesn't work. The only 
thing that works is to unplug and to plug in the mouse after start-up.

relevant boot messages:

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.0uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 11, io base 0000d400
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 2
usb 1-2: USB device not accepting new address=2 (error=-110)
hub 1-0:0: new USB device on port 2, assigned address 3
usb 1-2: USB device not accepting new address=3 (error=-110)

after re-pluging the mouse:

hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 4
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with 
IntelliEye(TM)] on usb-00:07.2-2


On Mon, 5 May 2003, Greg KH wrote:

> On Mon, May 05, 2003 at 06:32:36PM +0300, Andrei Ivanov wrote:
> > 
> > The usb mouse still doesn't work... :(
> > Is there anything else I should try ?
> 
> Yes, does 2.5.69 (no -mm) work ok?
> And what are the usb messages from the kernel log when you plug your USB
> mouse in?
> 
> thanks,
> 
> greg k-h
> 
