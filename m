Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312468AbSCUTzA>; Thu, 21 Mar 2002 14:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312467AbSCUTyu>; Thu, 21 Mar 2002 14:54:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24448 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312392AbSCUTyj>; Thu, 21 Mar 2002 14:54:39 -0500
Date: Thu, 21 Mar 2002 14:55:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 make modules_install failed
In-Reply-To: <3C9A3043.4AA87A26@wanadoo.fr>
Message-ID: <Pine.LNX.3.95.1020321145223.1567A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Jean-Luc Coulon wrote:

> make[1]: Leaving directory `/usr/src/kernel-sources-2.5.7/arch/i386/lib'
> cd /lib/modules/2.5.7; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.7; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.7/kernel/sound/oss/sound.o
> depmod: 	virt_to_bus_not_defined_use_pci_map
> make: *** [_modinst_post] Error 1
> 
> -----
> Regards
> 	Jean-Luc

Yep. One of the files in ../sound/oss/*.c is using an old interface. 

 	virt_to_bus_not_defined_use_pci_map
 	'virt_to_bus' not defined, 'use_pci_map'


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

