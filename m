Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSGOPZE>; Mon, 15 Jul 2002 11:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSGOPZD>; Mon, 15 Jul 2002 11:25:03 -0400
Received: from [208.33.57.99] ([208.33.57.99]:46286 "EHLO
	radioflyer.ibocradio.com") by vger.kernel.org with ESMTP
	id <S317378AbSGOPZC>; Mon, 15 Jul 2002 11:25:02 -0400
Message-ID: <3D32E9EE.8040608@homemail.com>
Date: Mon, 15 Jul 2002 11:27:42 -0400
From: "D. Sen" <dsen@homemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux-kernel@vger.kernel.org,
       Andreas Bombe <bombe@informatik.tu-muenchen.de>
Subject: Re: "PCI: Cannot allocate resource region" messages at boot
References: <3D2EF7F2.1070107@homemail.com> <m28z4dfe04.fsf@best.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jul 2002 15:27:51.0790 (UTC) FILETIME=[2EEAC0E0:01C22C14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried it out but the patch doesnt seem to make any difference.

I see those messages before any attempt to load the yenta/pcmcia socket 
models. It has to be something else, I would think. Following is the 
sequence of messages at boot time (the messages appear whether or not I 
load pcmcia modules):


Jul 15 11:16:29 calliope syslogd 1.4.1: restart.
Jul 15 11:16:29 calliope kernel: klogd 1.4.1, log source = /proc/kmsg 
started.
Jul 15 11:16:29 calliope kernel: Inspecting /boot/System.map
Jul 15 11:16:29 calliope rpc.statd[769]: Version 0.3.3 Starting
Jul 15 11:16:29 calliope nfslock: rpc.statd startup succeeded
Jul 15 11:16:29 calliope kernel: Loaded 16257 symbols from /boot/System.map.
Jul 15 11:16:29 calliope kernel: Symbols match kernel version 2.4.18.
Jul 15 11:16:29 calliope kernel: Loaded 143 symbols from 8 modules.
Jul 15 11:16:29 calliope kernel: Linux version 2.4.18-lkpc-5beta7 
(root@calliope.research.dstech.org) (gcc version 3.0.4 (Mandrake Linux 
8.2 3.0.4-2mdk)) #5 Mon Jul 15 09:54:34 EDT 2002
Jul 15 11:16:29 calliope kernel: BIOS-provided physical RAM map:
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 0000000000000000 - 
000000000009f000 (usable)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 000000000009f000 - 
00000000000a0000 (reserved)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 00000000000d2000 - 
00000000000d4000 (reserved)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 00000000000dc000 - 
0000000000100000 (reserved)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 0000000000100000 - 
000000003ff60000 (usable)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 000000003ff60000 - 
000000003ff7a000 (ACPI data)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 000000003ff7a000 - 
000000003ff7c000 (ACPI NVS)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 000000003ff7c000 - 
0000000040000000 (reserved)
Jul 15 11:16:29 calliope kernel:  BIOS-e820: 00000000ff800000 - 
0000000100000000 (reserved)
Jul 15 11:16:29 calliope kernel: 127MB HIGHMEM available.
Jul 15 11:16:29 calliope kernel: On node 0 totalpages: 261984
Jul 15 11:16:29 calliope kernel: zone(0): 4096 pages.
Jul 15 11:16:29 calliope kernel: zone(1): 225280 pages.
Jul 15 11:16:29 calliope kernel: zone(2): 32608 pages.
Jul 15 11:16:29 calliope kernel: No local APIC present or hardware disabled
Jul 15 11:16:29 calliope kernel: Kernel command line: root=/dev/hda3 
devfs=mount hdc=ide-scsi vga=794 ide0=autotune ide1=autotune 
video=vesa:mtrr,ywrap
Jul 15 11:16:29 calliope kernel: ide_setup: hdc=ide-scsi
Jul 15 11:16:29 calliope kernel: ide_setup: ide0=autotune
Jul 15 11:16:29 calliope kernel: ide_setup: ide1=autotune
Jul 15 11:16:29 calliope kernel: Initializing CPU#0
Jul 15 11:16:29 calliope kernel: Detected 1794.219 MHz processor.
Jul 15 11:16:29 calliope kernel: Console: colour dummy device 80x25
Jul 15 11:16:29 calliope kernel: Calibrating delay loop... 3578.26 BogoMIPS
Jul 15 11:16:29 calliope kernel: Memory: 1029248k/1047936k available 
(1273k kernel code, 18300k reserved, 304k data, 252k init, 130432k highmem)
Jul 15 11:16:29 calliope kernel: Dentry-cache hash table entries: 131072 
(order: 8, 1048576 bytes)
Jul 15 11:16:29 calliope kernel: Inode-cache hash table entries: 65536 
(order: 7, 524288 bytes)
Jul 15 11:16:29 calliope kernel: Mount-cache hash table entries: 16384 
(order: 5, 131072 bytes)
Jul 15 11:16:29 calliope kernel: Buffer-cache hash table entries: 65536 
(order: 6, 262144 bytes)
Jul 15 11:16:29 calliope kernel: Page-cache hash table entries: 262144 
(order: 8, 1048576 bytes)
Jul 15 11:16:29 calliope kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Jul 15 11:16:29 calliope kernel: CPU: L2 cache: 512K
Jul 15 11:16:29 calliope kernel: Intel machine check architecture supported.
Jul 15 11:16:29 calliope kernel: Intel machine check reporting enabled 
on CPU#0.
Jul 15 11:16:29 calliope kernel: CPU: Intel(R) Pentium(R) 4 Mobile CPU 
1.80GHz stepping 04
Jul 15 11:16:29 calliope kernel: Enabling fast FPU save and restore... done.
Jul 15 11:16:29 calliope kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jul 15 11:16:29 calliope kernel: Checking 'hlt' instruction... OK.
Jul 15 11:16:29 calliope kernel: POSIX conformance testing by UNIFIX
Jul 15 11:16:29 calliope kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Jul 15 11:16:29 calliope kernel: mtrr: detected mtrr type: Intel
Jul 15 11:16:29 calliope kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfd8fe, last bus=8
Jul 15 11:16:29 calliope kernel: PCI: Using configuration type 1
Jul 15 11:16:29 calliope kernel: PCI: Probing PCI hardware
Jul 15 11:16:29 calliope kernel: PCI: Discovered primary peer bus 09 [IRQ]
Jul 15 11:16:29 calliope kernel: PCI: Using IRQ router PIIX [8086/248c] 
at 00:1f.0
Jul 15 11:16:29 calliope kernel: PCI: Found IRQ 11 for device 00:1f.1
Jul 15 11:16:29 calliope kernel: PCI: Sharing IRQ 11 with 00:1d.2
Jul 15 11:16:29 calliope kernel: PCI: Sharing IRQ 11 with 02:02.0
Jul 15 11:16:29 calliope kernel: PCI: Cannot allocate resource region 0 
of device 02:00.0
Jul 15 11:16:29 calliope kernel: PCI: Cannot allocate resource region 0 
of device 02:00.1

Thanks for the suggestion though.

DS

Peter Osterlund wrote:
> "D. Sen" <dsen@homemail.com> writes:
> 
> 
>>I am getting these messages during bootup time on an IBM Thinkpad T30:
>>
>>Jul 11 17:17:24 calliope kernel: PCI: Cannot allocate resource region
>>0 of device 02:00.0
>>Jul 11 17:17:24 calliope kernel: PCI: Cannot allocate resource region
>>0 of device 02:00.1
> 
> 
> I had a similar problem on my notebook, but this patch seems to fix
> it:
> 
> --- linux/drivers/pcmcia/yenta.c.orig	Mon Jul 15 12:40:54 2002
> +++ linux/drivers/pcmcia/yenta.c	Mon Jul 15 12:40:39 2002
> @@ -736,7 +736,7 @@
>  		return;
>  	}
>  
> -	align = size = 4*1024*1024;
> +	align = size = 128*1024;
>  	min = PCIBIOS_MIN_MEM; max = ~0U;
>  	if (type & IORESOURCE_IO) {
>  		align = 1024;
> 
> I have no idea if this is the right thing to do. I found the
> suggestion in an earlier message from Andreas Bombe.
> 



