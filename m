Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262861AbSJGERb>; Mon, 7 Oct 2002 00:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSJGERb>; Mon, 7 Oct 2002 00:17:31 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:64188 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S262861AbSJGERa>; Mon, 7 Oct 2002 00:17:30 -0400
Date: Mon, 7 Oct 2002 00:22:34 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19: sym53c8xx problems
In-Reply-To: <3D9F7779.579746C6@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.44.0210070001560.25396-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Eyal ,

On Sun, 6 Oct 2002, Eyal Lebedinsky wrote:
> "Mr. James W. Laferriere" wrote:
> >         Is your scsi setup easy enough to make an ascii art description
> >         of ?  If so would you post it please ?  From the messages below
> >         it appears (to me) that their is some difficulty in the chain that
> >         attaches to the python .  I have never seen those messages when I
> >         have attached (albeit differant) tape drives , ie: DLT,dat2,dat3 .
> As I mentioned the ONLY scsi device is the externally connected DDS-1
> tape drive. It is a SCSI-2 narrow (50-pin) device. It uses a
> HD-centronics->50pin-centronics cable.
	I have been reviewing your previous message to the list .  In it
	you mentioned putting a Asus sc200(53c810) card into this system .
	Was that card in the system when the dmesg output was taken ?
	IF it was then that dmesg output shows a bug in the controller
	card recognition routines .  A 53c810 isn't a 53c875 .
	Also iirc the 6000 has either a 53c876 or two 53c875's on board
	not three .  At least mine only reports 2 53c875's .

	Another source of information for the sym driver is
	/usr/src/linux/drivers/scsi/sym53c8xx_2/Documentation.txt

> I believe the BIOS on this machine really does not like and IDE disks
> connected. It does have an IDE controller but will only allow the CD
> drive on it, so we have a PCI/IDE controller installed to handle the
> single IDE disk. The machine refuses to boot off the IDE but LILO is
> happy to do so off a floppy.
	Iirc the bios is stunted to only allow boot to cdrom on the ide
	port .  So the limitation probably continues onto other ide
	controllers as well .

> BTW, I only have this machine in order to test out software on a 4-way
> SMP machine, which is why we passed on installing more expensive scsi
> disks.
>
> Now, when I connect the cable to my tape, lilo fails to boot off the
> floppy. It seems that the first BIOS disk (80h) which is detected
> properly by the IDE controller is trashed by the scsi controller
> (which initialises later than the IDE). So we now boot off the floppy
> directly (i.e. the kernel boots off the floppy, not just lilo).
>
> Finally, now that we are booting just fine, and the scsi tape drive
> is clearly detected at bootup by the kernel, I see that the scsi
> driver does not stay loaded (maybe the boot process loads it, and
> if there are no disks it unloads it?). So I try to load it myself
> 	modprobe sym53c8xx
> and this kills the machine.
>
> By "kills" I mean the machine stutters for a few seconds, and then
> locks up, not even vt switching. No message is ever displayed.

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

