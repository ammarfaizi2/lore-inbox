Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129850AbRBGUbY>; Wed, 7 Feb 2001 15:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130257AbRBGUbF>; Wed, 7 Feb 2001 15:31:05 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8069 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129812AbRBGUan>; Wed, 7 Feb 2001 15:30:43 -0500
Date: Wed, 7 Feb 2001 15:30:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: davej@suse.de, Alan Cox <alan@redhat.com>, becker@scyld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hamachi not doing pci_enable before reading resources
In-Reply-To: <3A81AAA4.318BCD4E@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1010207152715.2498A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Jeff Garzik wrote:

> "Richard B. Johnson" wrote:
> > A PCI device does not and should not be enabled to probe for resources!
> 
> Some PCI devices do not -have- resources until pci_enable_device() is
> called, hence the rule.
> 

I stand by my statement. PCI devices that require resources are
required to provide read/write registers indicating these resources
whether or not the enable bits are set. This is mandatory. 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
