Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbREPS0s>; Wed, 16 May 2001 14:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbREPS0i>; Wed, 16 May 2001 14:26:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26243 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261802AbREPS02>; Wed, 16 May 2001 14:26:28 -0400
Date: Wed, 16 May 2001 14:25:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Massimo Dal Zotto <dz@cs.unitn.it>
cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: wrong /dev/sd... order with multiple adapters in kernel 2.4.4
In-Reply-To: <200105161138.NAA11330@nikita.dz.net>
Message-ID: <Pine.LNX.3.95.1010516141437.2686A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2001, Massimo Dal Zotto wrote:

> Hi,
> 
> I have recently upgraded the kernel from 2.2.19 to 2.4.4 and discovered
> that it assigns the /dev/sd... devices in the wrong order with respect both
> to the behavior of kernel 2.2.19 and to the `scsihosts' boot option which I
> specified at the boot prompt.
[SNIPPED]

As a work-around, you can use modules and boot through 'initrd' where
you load the modules in the order you want.

When you have two SCSI disk controllers, the order at which the drives
are seen will "always be wrong" --Murphys Law. You can control the
order in which the controllers are detected and installed by using
modules.

Basically you cannot ever expect that multiple controllers will
be detected in any particular order. They usually end up being detected
in the device-order for which they exist on the PCI bus. This changes!

If both of your controllers are "pluggable", you can swap them
on the physical bus to change the order in which they are detected.

If only one is pluggable, you might try another PCI slot. It may
have a number above/below the one embedded on the board.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


