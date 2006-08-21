Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWHUKzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWHUKzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWHUKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:55:35 -0400
Received: from i59F55009.versanet.de ([89.245.80.9]:19466 "EHLO
	max.erig.daheim") by vger.kernel.org with ESMTP id S1751857AbWHUKze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:55:34 -0400
Date: Mon, 21 Aug 2006 12:55:31 +0200
From: Wolfgang Erig <Wolfgang.Erig@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Regression with hyper threading scheduling
Message-ID: <20060821105531.GA6649@erig.dyndns.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060819223910.fef3bdea.akpm@osdl.org> <44E81770.8080408@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E81770.8080408@bigpond.net.au>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 06:04:00PM +1000, Peter Williams wrote:
> ...
> >lshw
> >    description: Mini Tower Computer
> >    product: SCENIC P / SCENICO P
> >    vendor: FUJITSU SIEMENS
> >    version: SCEP
> >    serial: YBEM738326
> >    width: 32 bits
> >    capabilities: smbios-2.31 dmi-2.31
> >    configuration: boot=normal chassis=mini-tower 
> >    uuid=FA48F283-A977-D811-A847-912FD384AB1D
> >  *-core
> >       description: Motherboard
> >       product: D1561
> >       vendor: FUJITSU SIEMENS
> >       physical id: 0
> >       version: S26361-D1561
> >       slot: Serial-1
> >     *-firmware
> >          description: BIOS
> >          vendor: FUJITSU SIEMENS // Phoenix Technologies Ltd.
> >          physical id: 0
> >          version: 5.00 R2.14.1561.01 (11/25/2004)
> >          size: 109KB
> >          capacity: 448KB
> >          capabilities: pci pnp apm upgrade shadowing escd cdboot 
> >          bootselect int13floppynec int13floppytoshiba int13floppy360 
> >          int13floppy1200 int13floppy720 int13floppy2880 int5printscreen 
> >          int9keyboard int14serial int17printer int10video acpi usb agp 
> >          ls120boot zipboot biosbootspecification
> >     *-cpu
> >          description: CPU
> >          product: Intel(R) Pentium(R) 4 CPU 2.60GHz
> >          vendor: Intel Corp.
> >          physical id: 4
> >          bus info: cpu@0
> >          version: 15.2.9
> >          slot: CPU
> >          size: 2600MHz
> >          capacity: 2600MHz
> >          width: 32 bits
> >          clock: 800MHz
> >          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce 
> >          cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx 
> >          fxsr sse sse2 ss ht tm pbe cid
> >          configuration: id=1
>  ...
> 
> I'm unable to reproduce this problem with 2.6.18-rc4 on my HT system. 
> I'm using top with the "last processor" field enabled to observe (rather 
> than the methods described) and the two bash shells are both getting 
> 100% and are each firmly affixed to different CPUs.

We can see the problem only on the hardware above.
Another (newer) system runs perfectly:

lshw
    description: Mini Tower Computer
    product: SCENIC P / SCENICO P
    vendor: FUJITSU SIEMENS
    version: SCEP2
    serial: YBPB012753
    width: 32 bits
    capabilities: smbios-2.31 dmi-2.31
    configuration: boot=normal chassis=mini-tower
    uuid=F5585067-4E15-11D9-897B-0030057E3EC7
  *-core
       description: Motherboard
       product: D1931
       vendor: FUJITSU SIEMENS
       physical id: 0
       version: S26361-D1931
       serial: 16105060
       slot: Serial-1
     *-firmware
          description: BIOS
          vendor: FUJITSU SIEMENS // Phoenix Technologies Ltd.
          physical id: 0
          version: 5.00 R1.08.1931 (12/03/2004)
          size: 110KB
          capacity: 448KB
          capabilities: pci pnp apm upgrade shadowing escd cdboot
	  bootselect int13floppynec int13floppytoshiba int13floppy360
	  int13floppy1200 int13floppy720 int13floppy2880 int5printscreen
	  int9keyboard int14serial int17printer int10video acpi usb agp
	  ls120boot zipboot biosbootspecification
     *-cpu
          description: CPU
          product: Intel(R) Pentium(R) 4 CPU 3.20GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: 15.4.1
          serial: 0000-0F41-0000-0000-0000-0000
          slot: CPU
          size: 3200MHz
          capacity: 3200MHz
          width: 32 bits
          clock: 800MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc pni monitor ds_cpl cid xtpr
          configuration: id=0
       ...

Wolfgang
