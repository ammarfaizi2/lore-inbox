Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUFAVy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUFAVy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUFAVy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:54:57 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:393 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S265084AbUFAVyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:54:43 -0400
Date: Tue, 1 Jun 2004 17:55:52 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: Saurabh Barve <sa@atmos.colostate.edu>
cc: linux-kernel@vger.kernel.org,
       Red Hat AMD64 Mailing List <amd64-list@redhat.com>
Subject: Re: GART Error 11
In-Reply-To: <Pine.LNX.4.58.0406011728001.9355@tiamat.perryconsulting.net>
Message-ID: <Pine.LNX.4.58.0406011753300.9355@tiamat.perryconsulting.net>
References: <Pine.LNX.4.44.0406011436530.4341-200000@eliassen.atmos.colostate.edu>
 <Pine.LNX.4.58.0406011728001.9355@tiamat.perryconsulting.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saurabh,

I almost forgot.
Can you also tell me which AMD CPUs you are using?
Preferrably by number if you know (starts with OSA I believe), or at least
the CPU speed.
Thanks!

Arthur Perry
Lead Linux Developer / Linux Systems Architect
Validation, CSU Celestica
Sair/Linux Gnu Certified Professional
Providing professional Linux solutions for 7+ years

On Tue, 1 Jun 2004, Arthur Perry wrote:

> Hi Saurabh,
>
> I am working on this issue as we speak.
> It is interesting that your machine crashes entirely with iommu disabled.
>
> I am starting to think there is more to this than just the kernel
> misreporting other hardware errors (being improperly decoded as GART
> errors).
> On my machine, I am actaully getting Gart erros on 3 out of 4 CPUS when I
> use RedHat's 2.4.21-9EL kernel. This same kernel when rebuilt from source,
> however, will not produce GART errors when built without AGP support.
>
> Here is my Extended error code (bits 19-16 on 0:[18,19,1b]:3 at offset 0x44:
> 0101 = GART error
>
> So, this is not a translation issue on my side.
>
> Can you do this for me?
>
> pcitweak -r 0:18:3 0x44
> and
> pcitweak -r 0:19:3 0x44
>
>
> Thanks!
>
>
> Arthur Perry
> Lead Linux Developer / Linux Systems Architect
> Validation, CSU Celestica
> Sair/Linux Gnu Certified Professional
> Providing professional Linux solutions for 7+ years
>
> On Tue, 1 Jun 2004, Saurabh Barve wrote:
>
> > Hi,
> >
> > I know this has been posted before on this list, but the solution
> > suggested does not seem to work for me.
> >
> > I have a dual opteron system with 8 GB of RAM. I am running RHEL 3.0 AS on
> > it. The kernel version is 2.4.21-4.ELsmp. The motherboard I am using is
> > the Tyan Thunder K8S Pro - 2882 motherboard.
> >
> > I am getting the following error every two minutes or so:
> >
> > GART error 11
> > Lost an northbridge error
> > NB error address some-hex-number
> > Error uncorrected
> >
> > I checked the various postings on the list, and someone suggested that
> > passing iommu=off option to the kernel solved the problem for him.
> > However, when I tried that, it got the kernel to panic. I read somewhere
> > that a newer kernel would fix these 'bugs' in the default RHEL kernel.
> > However, I am using the onboard SATA controller for my hard disks. This
> > requires binary drivers from Tyan. I already downloaded a newer kernel,
> > however, it breaks the drivers, so I can't boot into the new kernel.
> >
> > Here is my output from lspci:
> >
> > 00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
> > 00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
> > 00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
> > 00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
> > 00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
> > 00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> > (rev 12)
> > 00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
> > 00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> > (rev 12)
> > 00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
> > 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> > 02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
> > Gigabit Ethernet (rev 03)
> > 02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
> > Gigabit Ethernet (rev 03)
> > 03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
> > 03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
> > 03:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD
> > Technology Inc) Silicon Image SiI 3114 SATARaid Controller (rev 02)
> > 03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> > 03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> > 10)
> >
> > The dmesg output was too large to include inline, so I am attaching it as
> > a text file.
> >
> > I tried passing the following options to the kernel:
> >
> > iommu=noagp
> > iommu=noforce
> > iommu=off (results in kernel-panic)
> > mce=off
> > mce=0
> >
> > I tried all the above in various combinations, but none of them worked.
> > The machine doesn't crash, and everything else seems to work fine, but I'd
> > like to get rid of these errors.
> >
> > There are some snippets from the dmesg output that I found to be of
> > interest:
> >
> > ------------------------------------------------------------
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 7956M
> > agpgart: no supported devices found.
> > PCI-DMA: Disabling AGP.
> > PCI-DMA: aperture base @ 10000000 size 65536 KB
> > PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> > -----------------------------------------------------------
> >
> > -----------------------------------------------------------
> >
> > GART error 11
> > Lost an northbridge error
> > NB error address 00000000fbfe4398
> > Error uncorrected
> > Northbridge status a40000000005001b
> >
> > ----------------------------------------------------------
> >
> >
> > Any suggestions?
> >
> > Thanks,
> > Saurabh.
> >
>
>
> --
> amd64-list mailing list
> amd64-list@redhat.com
> https://www.redhat.com/mailman/listinfo/amd64-list
>
