Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSJEPTL>; Sat, 5 Oct 2002 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSJEPTL>; Sat, 5 Oct 2002 11:19:11 -0400
Received: from ns1.baby-dragons.com ([199.33.245.254]:62394 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S262372AbSJEPTJ>; Sat, 5 Oct 2002 11:19:09 -0400
Date: Sat, 5 Oct 2002 11:24:31 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19: sym53c8xx problems
In-Reply-To: <3D9EDC65.7C35221F@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.44.0210051116120.20304-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Eyal ,  I have a CP6000 unit (PPRO's tho) & am having no
	such difficulties .  Now that said I rebuilt the WHOLE scsi
	layout in the system in order to get rid of those older hotswap
	cages (imo, they stink electrically) .  Btw , Stable as heck .
	Wheres that forest I need to knock on ;-)

	Is your scsi setup easy enough to make an ascii art description
	of ?  If so would you post it please ?  From the messages below
	it appears (to me) that their is some difficulty in the chain that
	attaches to the python .  I have never seen those messages when I
	have attached (albeit differant) tape drives , ie: DLT,dat2,dat3 .
		Twys ,  JimL

On Sat, 5 Oct 2002, Eyal Lebedinsky wrote:

> Actually I tried all the drivers for the ASUS SC200, a 53c810 based
> card that used to work well. I have only a DDS-1 tape connected to
> it but the drivers just do not cut it. Some refuse to load and others
> get kernel panics. This gets even stranger. I proceeded to connect
> the unit to a Compaq Proliant 6000 (four PIII Xeons). It has a 53c875
> controller (three channels) and the sym53c8xx is crashing the system
> if I try to access the tape (it does recognise it just fine when
> loaded).
>
> The newer driver (in sym53c8xx_2) does not get that far, the driver
> locks up when I modprobe this driver.
>
> Here are the boot messages, where the driver seems to OK (this is
> the original sym53c8xx driver):
> [BTW, why the final "scsi : 0 hosts left" message?]
> [I will test again tomorrow, it is a new moon then...]
>
> Oct  4 12:56:16 ssa28 kernel: SCSI subsystem driver Revision: 1.00
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: at PCI bus 0, device 13,
> function 0
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: 53c875 detected
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
> function 0
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: 53c875 detected
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
> function 1
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: 53c875 detected
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: rev 0x4 on pci bus 0 device
> 13 function 0 irq 5
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: ID 7, Fast-20, Parity
> Checking
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: rev 0x14 on pci bus 4 device
> 9 function 0 irq 5
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: ID 7, Fast-20, Parity
> Checking
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: rev 0x14 on pci bus 4 device
> 9 function 1 irq 5
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: ID 7, Fast-20, Parity
> Checking
> Oct  4 12:56:16 ssa28 kernel: scsi0 : sym53c8xx-1.7.3c-20010512
> Oct  4 12:56:16 ssa28 kernel: scsi1 : sym53c8xx-1.7.3c-20010512
> Oct  4 12:56:16 ssa28 kernel: scsi2 : sym53c8xx-1.7.3c-20010512
> Oct  4 12:56:16 ssa28 kernel:   Vendor: ARCHIVE   Model: Python
> 28388-XXX  Rev: 4.28
> Oct  4 12:56:16 ssa28 kernel:   Type:
> Sequential-Access                  ANSI SCSI revision: 02
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: detaching ...
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: resetting chip
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: detaching ...
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: resetting chip
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: detaching ...
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: resetting chip
> Oct  4 12:56:16 ssa28 kernel:
> Oct  4 12:56:16 ssa28 kernel: inserting floppy driver for 2.4.18-ac3ser
> Oct  4 12:56:16 ssa28 kernel: Floppy drive(s): fd0 is 1.44M
> Oct  4 12:56:16 ssa28 kernel: FDC 0 is a National Semiconductor PC87306
> Oct  4 12:56:16 ssa28 kernel: parport0: PC-style at 0x3bc [PCSPP]
> Oct  4 12:56:16 ssa28 kernel: SCSI subsystem driver Revision: 1.00
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: at PCI bus 0, device 13,
> function 0
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: 53c875 detected
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
> function 0
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: 53c875 detected
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
> function 1
> Oct  4 12:56:16 ssa28 kernel: sym53c8xx: 53c875 detected
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: rev 0x4 on pci bus 0 device
> 13 function 0 irq 5
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: ID 7, Fast-20, Parity
> Checking
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: rev 0x14 on pci bus 4 device
> 9 function 0 irq 5
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: ID 7, Fast-20, Parity
> Checking
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: rev 0x14 on pci bus 4 device
> 9 function 1 irq 5
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: ID 7, Fast-20, Parity
> Checking
> Oct  4 12:56:16 ssa28 kernel: scsi0 : sym53c8xx-1.7.3c-20010512
> Oct  4 12:56:16 ssa28 kernel: scsi1 : sym53c8xx-1.7.3c-20010512
> Oct  4 12:56:16 ssa28 kernel: scsi2 : sym53c8xx-1.7.3c-20010512
> Oct  4 12:56:16 ssa28 kernel:   Vendor: ARCHIVE   Model: Python
> 28388-XXX  Rev: 4.28
> Oct  4 12:56:16 ssa28 kernel:   Type:
> Sequential-Access                  ANSI SCSI revision: 02
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: detaching ...
> Oct  4 12:56:16 ssa28 kernel: sym53c875-0: resetting chip
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: detaching ...
> Oct  4 12:56:16 ssa28 kernel: sym53c875-1: resetting chip
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: detaching ...
> Oct  4 12:56:16 ssa28 kernel: sym53c875-2: resetting chip
> Oct  4 12:56:16 ssa28 kernel: scsi : 0 hosts left.
>
> --
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

