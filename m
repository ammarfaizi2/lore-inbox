Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbQL0UWe>; Wed, 27 Dec 2000 15:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQL0UWO>; Wed, 27 Dec 2000 15:22:14 -0500
Received: from dusdi5-212-144-140-003.arcor-ip.net ([212.144.140.3]:33549 "EHLO
	al.romantica.wg") by vger.kernel.org with ESMTP id <S129729AbQL0UWG>;
	Wed, 27 Dec 2000 15:22:06 -0500
Date: Wed, 27 Dec 2000 15:06:24 +0100
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: test13-pre4-ac2 -- The cardbus/pcmcia sockets no longer work with two devices present at boot time.
Message-ID: <20001227150623.A19813@al.romantica.wg>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	Miles Lane <miles@megapathdsl.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	acpi@phobos.fachschaften.tu-muenchen.de
In-Reply-To: <3A49AB66.1000607@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A49AB66.1000607@megapathdsl.net>; from miles@megapathdsl.net on Wed, Dec 27, 2000 at 12:42:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be a problem that was introduced with the big ACPI update
as pointed out earlier by Andrew Morton.  Try disabling ACPI (since your
BIOS does not seem to have ACPI support anyway it should not be a
disadvantage) and see if PCMCIA support works again on bootup.

Jens

On Wed, Dec 27, 2000 at 12:42:14AM -0800, Miles Lane wrote:
> When I boot with the following inserted:
> 
> Socket 0:
>    product info: "3Com Corporation", "3CCFE575BT", "LAN Cardbus Card", "001"
>    manfid: 0x0101, 0x5157
>    function: 6 (network)
> Socket 1:
>    product info: "PCMCIA  ", "56K V.90 Fax Modem (LK)  ", "FM560LK  "
>    manfid: 0x0175, 0x0000
>    function: 2 (serial)
> 
> both sockets fail to set up properly and work.
> 
> Linux PCMCIA Card Services 3.1.22
>    options:  [pci] [cardbus] [pm]
> PCI: Enabling device 00:04.0 (0000 -> 0002)
> PCI: Assigned IRQ 11 for device 00:04.0
> PCI: Enabling device 00:04.1 (0000 -> 0002)
> PCI: Assigned IRQ 11 for device 00:04.1
> Intel PCIC probe: not found.
> Yenta IRQ list 0698, PCI irq11
> Socket status: 30000020
> Yenta IRQ list 0698, PCI irq11
> Socket status: 30000010
> ACPI: System description tables not found
> cs: socket c118b000 timed out during reset.  Try increasing setup_delay.
> cs: socket c118b800 timed out during reset.  Try increasing setup_delay.
> 
> If I then run "cardctl eject" and then eject and reinsert the two
> cards, the cards get set up correctly.
> 
> Note that I am not using the PCMCIA drivers.  I am using Yenta
> and its native development kernel friends. I am using modutils
> 2.3.22.
-- 
Jens Taprogge


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
