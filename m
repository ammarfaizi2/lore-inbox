Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314380AbSEBMgg>; Thu, 2 May 2002 08:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314383AbSEBMgf>; Thu, 2 May 2002 08:36:35 -0400
Received: from sbmail.sb.aau.dk ([130.225.24.60]:14085 "EHLO
	sbmail.statsbiblioteket.dk") by vger.kernel.org with ESMTP
	id <S314380AbSEBMge>; Thu, 2 May 2002 08:36:34 -0400
Date: Thu, 2 May 2002 14:36:01 +0200 (CEST)
From: "Tom G. Christensen" <tom.christensen@get2net.dk>
To: linux-kernel@vger.kernel.org
cc: Carlos Francisco Regis <zeca@h8.ita.br>
Subject: Re: smp/dac960/i450gx boot problem
In-Reply-To: <20020430233558.51bf6ed2.zeca@h8.ita.br>
Message-ID: <Pine.LNX.4.44.0205021302490.8394-100000@ares.statsbiblioteket.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002, Carlos Francisco Regis wrote:

> 
> 	
> 	Hello all,
> 
> 	I'm with some troubles on trying to boot a kernel in a dual PPro machine. When a compile the kernel with smp support the machine hungs during the boot, this occurs exactly when the dac960 driver is being loaded. When I remove the smp support the driver is loaded but I have only one processor running.
> 
> 	I think the problem is the i450kx/gx pci bridge and the pci->apic irq transform. But I can't figure out why this is happening.
> 
> 	If someone knows some workaround, please let me know.
> 
> 
Me too.

I have what looks like the same problem here only my machine is a quad 
PPro system (Intel Alder arch).

One thing is different though, I can't get the DAC960 to initialize no 
matter what I do (it's a DAC960PL-2, fw 2.73)
Only thing I've gotten working so far is boot off a RH 7.2 install CD in 
rescue mode (DAC960 driver in RH 7.2 CD is too old to support 2.73 fw)

If I boot the RH 7.2 installer the machine hangs right after loading the 
AIC7xxx driver.
The symptoms are the same with kernel 2.4.18 booted of a floppy. If I 
include the DAC960 driver the machine will hang as soon as it 
loads, only displaying the 2 lines with driver version and copyright information.
A 2.4.18 SMP kernel boots until the DAC960 driver then hangs.

I get these PCI messages on boot (kernel 2.4.18 built for i386)
PCI: Cannot allocate resource region 1 of device 00:0f.0
PCI: Cannot allocate resource region 2 of device 00:0f.0
PCI: Cannot allocate resource region 3 of device 00:0f.0
PCI: Cannot allocate resource region 4 of device 00:0f.0
PCI: Cannot allocate resource region 5 of device 00:0f.0
PCI: Error while updating region 00:0f.0/1 (20000408 != 20000008)
PCI: Error while updating region 00:0f.0/2 (20000408 != 20000008)
PCI: Error while updating region 00:0f.0/3 (20000408 != 20000008)
PCI: Error while updating region 00:0f.0/4 (20000408 != 20000008)
PCI: Error while updating region 00:0f.0/5 (20000408 != 20000008) 

lspci output is available if needed.

I tried a few other OS just to make sure the machine is okay, and I found 
that Win2000 and Solaris 8/IA will install and run without any problems.
FreeBSD 4.5 release seems to have the same problem as Linux, a 
hang soon after initializing the AIC7xxx driver.

-tgc

-- 
Tom G. Christensen - Email: tom.christensen@get2net.dk
Linux ares 2.4.18 on an i686


