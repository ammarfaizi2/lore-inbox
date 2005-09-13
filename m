Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVIMVzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVIMVzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVIMVzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:55:47 -0400
Received: from advect.atmos.washington.edu ([128.95.89.50]:14722 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S1751070AbVIMVzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:55:44 -0400
Message-ID: <43274ACC.6060504@atmos.washington.edu>
Date: Tue, 13 Sep 2005 14:55:24 -0700
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 - Failed boot of "kdump" kernel
References: <4326FAF3.7080901@atmos.washington.edu>
In-Reply-To: <4326FAF3.7080901@atmos.washington.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -105.899 () ALL_TRUSTED,BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this message.  I did not properly specify the kernel 
parameters for booting a RAID-1 root partition.  Once I did it properly 
the kernel boots fine.

Harry Edmon wrote:

> I am using kexec and SYSRQ to boot up a "kdump" kernel on a Dual Xeon 
> system (and yes, I have SMP off on the second kernel per the 
> instructions in Documentation/kdump/kdump.txt).  The second kernel 
> that I loaded with kexec is crashing on boot.  Here is the output from 
> the serial console:
>
> SysRq : Trigger a crashdump
> I'm in purgatory
> Linux version 2.6.13.1-kdump (root@freshair1) (gcc version 3.3.5 
> (Debian 1:3.3.5-13)) #5 Tue Sep 13 08:36:21 PDT 2005
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000100 - 000000000009b000 (usable)
> BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
> BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
> BIOS-e820: 00000000bff70000 - 00000000bff78000 (ACPI data)
> BIOS-e820: 00000000bff78000 - 00000000bff80000 (ACPI NVS)
> BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
> BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
> BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
> user-defined physical RAM map:
> user: 0000000000000000 - 00000000000a0000 (usable)
> user: 0000000001000000 - 0000000001347000 (usable)
> user: 00000000013e7400 - 0000000005000000 (usable)
> 0MB HIGHMEM available.
> 80MB LOWMEM available.
> found SMP MP-table at 000f5d40
> DMI present.
> Intel MultiProcessor Specification v1.4
>    Virtual Wire compatibility mode.
> OEM ID: INTEL    Product ID: Lindenhurst  APIC at: 0xFEE00000
> Processor #0 15:3 APIC version 20
> Processor #6 15:3 APIC version 20
> WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> I/O APIC #2 Version 32 at 0xFEC00000.
> I/O APIC #3 Version 32 at 0xFEC10000.
> I/O APIC #4 Version 32 at 0xFEC80000.
> I/O APIC #5 Version 32 at 0xFEC80400.
> Enabling APIC mode:  Flat.  Using 4 I/O APICs
> Processors: 1
> Allocating PCI resources starting at 05000000 (gap: 05000000:fb000000)
> Built 1 zonelists
> Kernel command line: root=/dev/md0 init 1 irqpoll console=ttyS0,38400 
> memmap=exactmap memmap=640K@0K memmap=3356K@16384K 
> memmap=61539K@20381K elfcorehdr=20380K
> Misrouted IRQ fixup and polling support enabled
> This may significantly impact system performance
> Initializing CPU#0
> PID hash table entries: 512 (order: 9, 8192 bytes)
> Detected 3001.041 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 61268k/81920k available (2134k kernel code, 4104k reserved, 
> 808k data, 160k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor 
> mode... Ok.
> Calibrating delay using timer specific routine.. 6008.19 BogoMIPS 
> (lpj=3004095)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512
> monitor/mwait feature present.
> using mwait in idle threads.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
> CPU0: Thermal monitoring enabled
> mtrr: v2.0 (20020519)
> CPU: Intel(R) Xeon(TM) CPU 3.00GHz stepping 04
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> ------------[ cut here ]------------
> kernel BUG at <bad filename>:65464!
> invalid operand: 0000 [#1]
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c100fde6>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.13.1-kdump)
> EIP is at setup_local_APIC+0x26/0x180
> eax: 00000000   ebx: 00050014   ecx: 00000000   edx: ffffffff
> esi: 00000014   edi: c14c9fd4   ebp: 00000000   esp: c14c9f94
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c14c8000 task=c14aba40)
> Stack: c12ed809 c10141dd c14ab530 c1000290 00000000 c12edf89 c101cc6a 
> c14ab530
>       00000001 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
>       00000000 c10002ab 0000007b ffffffff c1000f88 c1000f8d 00000000 
> 00000000
> Call Trace:
> [<c12ed809>] verify_local_APIC+0x69/0x120
> [<c10141dd>] wake_up_process+0x1d/0x30
> [<c1000290>] init+0x0/0x110
> [<c12edf89>] APIC_init_uniprocessor+0xb9/0x120
> [<c101cc6a>] cpu_callback+0xaa/0xb0
> [<c10002ab>] init+0x1b/0x110
> [<c1000f88>] kernel_thread_helper+0x0/0x18
> [<c1000f8d>] kernel_thread_helper+0x5/0x18
> Code: c3 8d 74 26 00 56 53 83 ec 0c 8b 1d 30 d0 ff ff a1 20 d0 ff ff 
> 0f b6 f3 c1 e8 18 83 e0 0f 0f a3 05 60 07 31 c1 19 c0 85 c0 75 02 <0f> 
> 0b b8 ff ff ff ff a3 e0 d0 ff ff a1 d0 d0 ff ff 25 ff ff ff
> <0>Kernel panic - not syncing: Attempted to kill init!
>
> Anyone have ideas why this is crashing?  kernel config file available 
> upon request.
>
>
>
>

