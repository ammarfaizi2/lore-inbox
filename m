Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280339AbRKJAKx>; Fri, 9 Nov 2001 19:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280343AbRKJAKo>; Fri, 9 Nov 2001 19:10:44 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:5564 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S280339AbRKJAK1>;
	Fri, 9 Nov 2001 19:10:27 -0500
Date: Sat, 10 Nov 2001 01:10:25 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200111100010.BAA27674@harpo.it.uu.se>
To: nick@coelacanth.com
Subject: Re: 2.4.13 pcd problems?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Nov 2001 13:38:05 -0500, Nick Papadonis wrote:
>Is anyone having similar problems with pcd using Kernel v2.4.13?  I'm trying
>to get my BackPack 6 working.  I don't think I should be passing any
>other parameters to pcd.
>
>Any insight much appreciated.
>
>- Nick
>
>$ 540 /home/nick -> modprobe paride
>$ 541 /home/nick -> modprobe bpck6
>$ 542 /home/nick -> modprobe pcd
>/lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o: init_module: Operation not permitted
>Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
>/lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o: insmod /lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o failed
>/lib/modules/2.4.13/kernel/drivers/block/paride/pcd.o: insmod pcd failed

A dmesg log would have been appropriate here.
Two things to check/test:
1. Configure the parport as EPP or PS2 in the BIOS, not ECP.
2. Tell Linux the IO address _and_ IRQ of your parport.

I have the following in /etc/modules.conf in an old box, and
its Freecom parport CD-ROM works fine in 2.4.current.

alias parport_serial off
alias parport_lowlevel off
above parport parport_pc
options parport_pc io=0x378 irq=7
above paride frpw
alias block-major-46 pcd
