Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289228AbSBJDbx>; Sat, 9 Feb 2002 22:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289230AbSBJDbn>; Sat, 9 Feb 2002 22:31:43 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:57729 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S289228AbSBJDbb>; Sat, 9 Feb 2002 22:31:31 -0500
Message-ID: <3C65E916.9000306@wanadoo.fr>
Date: Sun, 10 Feb 2002 04:29:26 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.4-pre5 fails to build (sounddrivers.o/pcmcia_net.o)
In-Reply-To: <3C658EC2.158C2B2C@oracle.com> <3C65B3F4.FD45143D@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Alessandro Suardi wrote:
> 
>>drivers/sound/sounddrivers.o: In function `m3_play_setup':
>>drivers/sound/sounddrivers.o(.text+0xf4e): undefined reference to `virt_to_bus_not_defined_use_pci_map'
>>drivers/sound/sounddrivers.o(.text+0xf6e): undefined reference to `virt_to_bus_not_defined_use_pci_map'
>>drivers/sound/sounddrivers.o(.text+0xf93): undefined reference to `virt_to_bus_not_defined_use_pci_map'
>>drivers/sound/sounddrivers.o(.text+0xfb7): undefined reference to `virt_to_bus_not_defined_use_pci_map'
>>drivers/sound/sounddrivers.o(.text+0xfde): undefined reference to `virt_to_bus_not_defined_use_pci_map'
>>drivers/sound/sounddrivers.o(.text+0x1000): more undefined references to `virt_to_bus_not_defined_use_pci_map' follow
>>drivers/net/pcmcia/pcmcia_net.o: In function `xircom_rx':
>>drivers/net/pcmcia/pcmcia_net.o(.text+0x1801): undefined reference to `bus_to_virt_not_defined_use_pci_map'
>>drivers/net/pcmcia/pcmcia_net.o(.text+0x19a2): undefined reference to `virt_to_bus_not_defined_use_pci_map'
>>drivers/net/pcmcia/pcmcia_net.o: In function `set_rx_mode':
>>drivers/net/pcmcia/pcmcia_net.o(.text+0x22d4): undefined reference to `virt_to_bus_not_defined_use_pci_map'
>>make: *** [vmlinux] Error 1
>>
> 
> 
> These driver(s) need to be cleaned up to use pci_alloc_consistent.
> 
> Patches welcome!
> 
> 
es1370.c is using pci_alloc_consistent. However insmod es1370 gives this 
message :
/lib/modules/2.5.4-pre5/kernel/drivers/sound/es1370.o: unresolved symbol 
virt_to_bus_not_defined_use_pci_map_R2278fef8

It comes from a workaround for the "phantom write" bug. A workaround for 
the workaround might be in this case isa_virt_to_bus

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

