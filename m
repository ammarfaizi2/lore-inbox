Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317826AbSFMUwc>; Thu, 13 Jun 2002 16:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317827AbSFMUwc>; Thu, 13 Jun 2002 16:52:32 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:10759 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S317826AbSFMUwb>; Thu, 13 Jun 2002 16:52:31 -0400
Date: Thu, 13 Jun 2002 16:52:33 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Martin Knoblauch <knobi@knobisoft.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Problems with 2.4.19-pre10-ac2
Message-ID: <20020613165233.O16859@sventech.com>
In-Reply-To: <200206131916.16214.knobi@knobisoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002, Martin Knoblauch <knobi@knobisoft.de> wrote:
>  on connecting an Olympus 2100UZ camera via USB for use with gphoto2
> I get the following messages from the kernel:
> 
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 18:05:42 Jun 13 2002
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> hub.c: USB new device connect on bus1/2, assigned device number 2
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=2 (error=-110)
> hub.c: USB new device connect on bus1/2, assigned device number 3
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=3 (error=-110)
> 
>  Suspicious are the "usb_control/bulk_msg: timeout" messages and the "not 
> accepting" stuff. Same happens with the uhci.o module. The camera works with 
> the 2.4.18-4GB kernel from SuSE8.0. So I suspect some problems with 
> 2.4.19-pre10-ac2. Unfortunatelly I cannot build 2.4.19-pre10 alone, due to 
> compilation errors.
> 
> Any idea? System in question is based on the VIA KT333 chipset, with an 
> xp2100+ CPU.

Almost definately an IRQ routing problem. Check APIC options in kernel,
try using noapic on kernel command line, etc.

JE

