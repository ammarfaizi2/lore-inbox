Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314654AbSEFShj>; Mon, 6 May 2002 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSEFShi>; Mon, 6 May 2002 14:37:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31173 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314654AbSEFShi>; Mon, 6 May 2002 14:37:38 -0400
Date: Mon, 06 May 2002 12:35:41 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Kosta Porotchkin <kporotchkin@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Wrong IRQ distribution on Dual Xeon SMP system (2.4.17).
Message-ID: <246660000.1020713741@flay>
In-Reply-To: <003901c1f532$4116fcc0$a396a8c0@compaq12xl510a>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem:  Wrong interrupts distribution between processors, as a result of
> IO APIC configuration errors
> 
> Platform:  SuperMicro P4DP6 motherboard (Intel E7500 chipset) with two Intel
> Xeon Processors (512 Kb L2 cache @ 2.2 GHz), 1 Gb PC2100 RAM. Phoenix BIOS
> 1.1a (latest available for this board). Hyper threading enabled, ACPI
> enabled.
> 
> Kernel:    2.4.17 Sherman-x330 (MontaVista) - SMP enabled.
> 
> Problem Description:
> 
> After booting the /proc/interrupts files reads as follows:
> 
>            CPU0       CPU1       CPU2       CPU3
>   0:      23794          0          0          0    IO-APIC-edge  timer
>   1:       1900          0          0          0    IO-APIC-edge  keyboard
>   2:          0          0          0          0          XT-PIC  cascade
>   4:          0          0          0          0    IO-APIC-edge  KGDB-stub
>   9:          0          0          0          0    IO-APIC-edge  acpi
>  17:       4718          0          0          0   IO-APIC-level  eth0
> NMI:      23672      23672      23672      23672
> LOC:      23649      23648      23648      23646
> ERR:          0
> MIS:          0

P4 based systems don't round-robin interrupts like P3 based systems do. 
Check back in the archives, and find one of the interrupt routing patches. 
Dave Olien had one, and Ingo Molnar had one, they use slightly different 
approaches.

Martin.

