Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRGKSQr>; Wed, 11 Jul 2001 14:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264541AbRGKSQh>; Wed, 11 Jul 2001 14:16:37 -0400
Received: from customers.imt.ru ([212.16.0.33]:12330 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S264169AbRGKSQW>;
	Wed, 11 Jul 2001 14:16:22 -0400
Message-ID: <20010711111356.A15553@saw.sw.com.sg>
Date: Wed, 11 Jul 2001 11:13:56 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Stefan Hoffmeister <lkml.2001@econos.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.6: eepro100 does not survive warm boot
In-Reply-To: <gg4oktks8jch0sqsdivo2m5071t2h0q1jp@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <gg4oktks8jch0sqsdivo2m5071t2h0q1jp@4ax.com>; from "Stefan Hoffmeister" on Wed, Jul 11, 2001 at 10:47:35AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apparently, the card is unaccessible after warm reboot.
It should be a PCI initialization problem.
What lspci shows after the warm reboot?

	Andrey

On Wed, Jul 11, 2001 at 10:47:35AM +0200, Stefan Hoffmeister wrote:
> For testing purposes, I am running a stock 2.4.6 kernel on a Sony VAIO
> Z600 NE notebook (Sony Z505 JS in the US).
> 
> On a cold boot, I get this information in dmesg:
> 
> >eth0: OEM i82557/i82558 10/100 Ethernet, 08:00:46:07:49:99, IRQ 9.
> >  Receiver lock-up bug exists -- enabling work-around.
> >  Board assembly 100001-001, Physical connectors present: RJ45
[snip]
> 
> With the exact same kernel, after a warm boot ('reboot'), the picture
> changes to
> 
> >eth0: Invalid EEPROM checksum 0xff00, check settings before activating this device!
> >eth0: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 9.
> >  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
> >  Primary interface chip unknown-15 PHY #31.
> >    Secondary interface chip i82555.
> >Self test failed, status ffffffff:
> > Failure to initialize the i82557.
> > Verify that the card is a bus-master capable slot.
> 
> 
> Result: The network essentially is dead; I cannot make HTTP requests to a
> server on the LAN, for instance. Shut down the system and go through a
