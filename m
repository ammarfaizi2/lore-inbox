Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSBIXnF>; Sat, 9 Feb 2002 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSBIXmz>; Sat, 9 Feb 2002 18:42:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288748AbSBIXmr>;
	Sat, 9 Feb 2002 18:42:47 -0500
Message-ID: <3C65B3F4.FD45143D@mandrakesoft.com>
Date: Sat, 09 Feb 2002 18:42:44 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4-pre5 fails to build (sounddrivers.o/pcmcia_net.o)
In-Reply-To: <3C658EC2.158C2B2C@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> drivers/sound/sounddrivers.o: In function `m3_play_setup':
> drivers/sound/sounddrivers.o(.text+0xf4e): undefined reference to `virt_to_bus_not_defined_use_pci_map'
> drivers/sound/sounddrivers.o(.text+0xf6e): undefined reference to `virt_to_bus_not_defined_use_pci_map'
> drivers/sound/sounddrivers.o(.text+0xf93): undefined reference to `virt_to_bus_not_defined_use_pci_map'
> drivers/sound/sounddrivers.o(.text+0xfb7): undefined reference to `virt_to_bus_not_defined_use_pci_map'
> drivers/sound/sounddrivers.o(.text+0xfde): undefined reference to `virt_to_bus_not_defined_use_pci_map'
> drivers/sound/sounddrivers.o(.text+0x1000): more undefined references to `virt_to_bus_not_defined_use_pci_map' follow
> drivers/net/pcmcia/pcmcia_net.o: In function `xircom_rx':
> drivers/net/pcmcia/pcmcia_net.o(.text+0x1801): undefined reference to `bus_to_virt_not_defined_use_pci_map'
> drivers/net/pcmcia/pcmcia_net.o(.text+0x19a2): undefined reference to `virt_to_bus_not_defined_use_pci_map'
> drivers/net/pcmcia/pcmcia_net.o: In function `set_rx_mode':
> drivers/net/pcmcia/pcmcia_net.o(.text+0x22d4): undefined reference to `virt_to_bus_not_defined_use_pci_map'
> make: *** [vmlinux] Error 1


These driver(s) need to be cleaned up to use pci_alloc_consistent.

Patches welcome!

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
