Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbTLHPk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTLHPk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:40:57 -0500
Received: from legolas.restena.lu ([158.64.1.34]:41699 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265441AbTLHPke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:40:34 -0500
Subject: Re: Kernel 2.6.0-testX show stoppers
From: Craig Bradney <cbradney@zip.com.au>
To: Roberto Sanchez <rcsanchez97@yahoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FD498A0.9080802@yahoo.es>
References: <3FD498A0.9080802@yahoo.es>
Content-Type: text/plain
Message-Id: <1070898030.2098.146.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 16:40:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the Athlon, keep in touch with the nforce thread on here.. There are
patches due to timing issues with the nforce chipset. 

For me, so far, just using this one works:
http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch

There is a program called athcool to turn off CPU Disconnect if you dont
have that in your BIOS. I havent used this patch as I have found
reliability using the first one I mentioned.

Craig

On Mon, 2003-12-08 at 16:28, Roberto Sanchez wrote:
> I am having some problems getting 2.6.0-test11 working on my 2 boxes.
> I am hoping that someone here can provide me some insight so that I
> can provide some useful info to help get these solved.
> 
> Any help would be appreciated.
> 
> -Roberto
> 
> Here goes:
> 
> Box 1:
> 
> Athlon XP 2500+, 1 GB RAM, 120 GB HDD
> nVidia nForce2 chipset
> ATI Radeon 9000 Pro w/ 128 MB
> 
> This machine just randomly and frequently locks up under any 2.6.x
> kernel.  I can't find a particular pattern, but it happens every few
> minutes (enough to make the machine unusable).  It is now running a
> 2.4.23 kernel.
> 
> 
> Box 2:
> 
> Toshiba Satellite 2805-S401 (laptop)
> P-III 700 MHz, 256 MB RAM, 40 GB HDD
> Intel 440BX chipset
> S3 Savage IX/MV 8 MB video
> 
> Problem: Every kernel after 2.6.0-test4 gives me a hard lock-up during
> the boot sequence when PCMCIA services start.  No 2.4.x kernel ever did
> this, and 2.6.0-test1 thru -test4 work fine.  I have narrowed the 
> problem to the point where the yenta_socket socket module is inserted.
> However, if I pass acpi=off as a kernel boot parameter, it does not lock
> up.  Also, if I build PCMCIA support directly into the kernel,
> everything works.  I am currently running 2.6.0-test11 with PCMCIA
> built in (but I would like it to be modular).
> 
> I am also receiving the following errors on boot when my scripts
> set up the parameters on my HDD and CD/DVD (this is also particular
> to the post -test4 kernels):
> 
> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hda: drive not ready for command
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hda: drive not ready for command
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hda: DMA disabled
> hda: drive not ready for command
> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
> DataRequest }
> 
> But, eventhough it says DMA is disabled, it is still enabled.
> 
> # hdparm /dev/hda
> 
> /dev/hda:
>   multcount    = 16 (on)
>   IO_support   =  1 (32-bit)
>   unmaskirq    =  1 (on)
>   using_dma    =  1 (on)
>   keepsettings =  0 (off)
>   readonly     =  0 (off)
>   readahead    = 256 (on)
>   geometry     = 38760/16/63, sectors = 39070080, start = 0

