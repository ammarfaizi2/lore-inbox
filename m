Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRCCTm3>; Sat, 3 Mar 2001 14:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRCCTmT>; Sat, 3 Mar 2001 14:42:19 -0500
Received: from fe3.rdc-kc.rr.com ([24.94.163.50]:46351 "EHLO mail3.mmcable.com")
	by vger.kernel.org with ESMTP id <S129706AbRCCTmG> convert rfc822-to-8bit;
	Sat, 3 Mar 2001 14:42:06 -0500
Date: Sat, 3 Mar 2001 13:43:36 -0600 (CST)
From: Jason Madden <jmadden@spock.shacknet.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre - Kernel Panic: no init found
In-Reply-To: <002501c0a369$4abe8f70$4601a8c0@oracle.intranet>
Message-ID: <Pine.LNX.4.21.0103031334340.11559-100000@spock.shacknet.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Stéphane GARIN wrote:

> Hi,
> 
> I have a kernel panic with the patch 2.2.19pre16 that I test. I use a 2.2.18
> Kernel very well. I used the last patch on this kernel and make my kernel
> with sames parameters without error message. At the boot, I can see this :
> 
> ...
> eth0: RealTek RTL8139 Fast Ethernet at 0xa800, IRQ 10, 00:50:fc:0b:60:70
> eth1: RealTek RTL8139 Fast Ethernet at 0xac00, IRQ 11, 00:50:fc:1f:c1:98
> Partition check:
>  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
> Trying to vfree() noexistent vm area (c00f0000)
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 68k freed
> Kernel panic: No init found. Try passing init= option to kernel.
> 

I get similar messages on 2.4.2 and 2.4.2-ac7 :

...
ACPI: Core Subsystem version [20010208]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: plvl2lat=10 plvl3lat=20
ACPI: C2 enter=143 C2 exit=35
ACPI: C3 enter=858 C3 exit=71
ACPI: Not using ACPI idle
ACPI: System firmware supports: S0 S1 S5
ACPI: If experiencing system slowdowns, pass acpi=no-idle #FROM MEMORY
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Kernel  panic: No init found. Try passing init= option to kernel.

The solution was to pass acpi=no-idle on the kernel command line. The same
configuration worked fine with 2.4.1

Jason


