Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262333AbTCTVSk>; Thu, 20 Mar 2003 16:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCTVSk>; Thu, 20 Mar 2003 16:18:40 -0500
Received: from loki.a-q.co.uk ([195.224.50.15]:54025 "EHLO loki.a-q.co.uk")
	by vger.kernel.org with ESMTP id <S262333AbTCTVSg>;
	Thu, 20 Mar 2003 16:18:36 -0500
Date: Thu, 20 Mar 2003 21:29:34 +0000
From: James Wright <james@jigsawdezign.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org
Subject: Re: P4 3.06Ghz Hyperthreading with 2.4.20?
Message-Id: <20030320212934.0e4ad939.james@jigsawdezign.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96D2E@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A847E96D2E@orsmsx401.jf.intel.com>
Organization: Jigsaw Dezign
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I have patched my 2.4.20 kernel with the relevant ACPI patch, and now it suing ACPI
it detects the 2 Logical CPU's BUT it still disables SMP and /proc/cpuinfo only shows one processor... Sorry for the including this but here is a extract "dmesg":


Linux version 2.4.20 (root@neutrino) (gcc version 3.2.2) #1 SMP Thu Mar 20 21:02:11 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f51e0
ACPI: RSDT (v001 ASUS   P4G8X    16944.11825) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4G8X    16944.11825) @ 0x1fffc0c0
ACPI: BOOT (v001 ASUS   P4G8X    16944.11825) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4G8X    16944.11825) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4G8X    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 16
Kernel command line: BOOT_IMAGE=linux ro root=302 acpismp=force
Found and enabled local APIC!
Initializing CPU#0
Detected 3066.823 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6121.06 BogoMIPS
Memory: 515648k/524272k available (1439k kernel code, 8236k reserved, 364k data, 288k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
per-CPU timeslice cutoff: 1462.78 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3066.8182 MHz.
..... host bus clock speed is 133.3398 MHz.
cpu: 0, clocks: 1333398, slice: 666699
CPU0<T0:1333392,T1:666688,D:5,S:666699,C:1333398>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf1db0, last bus=2



On Thu, 20 Mar 2003 09:11:10 -0800
"Grover, Andrew" <andrew.grover@intel.com> wrote:

> > From: James Wright [mailto:james@jigsawdezign.com] 
> >    So i can apply the ACPI patch to 2.4.20, and it will work, 
> > even though my motherboard BIOS
> > doesn't provide the MPS table?
> 
> Yes, because ACPI uses a different table.
> 
> > Do i still need to use 
> > "acpismp=force" option?
> 
> Nope.
> 
> > What do you mean
> > by *configuring* acpi
> 
> Configuring it into your kernel, presumably, using make menuconfig.
> 
> > do i need the "acpid" or other 
> > resources, than just enabling it?
> 
> Nope, all the SMP detection stuff is in the kernel.
> 
> Regards -- Andy
> 
> > 
> > Thanks,
> > James
> > 
> > 
> > On Wed, 19 Mar 2003 18:50:59 -0800
> > "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> > 
> > > You need to apply the ACPI patch: 
> > http://sourceforge.net/projects/acpi and *configure* APIC. 
> > > 
> > > The 2.4 kernel depends on the MPS table for all but logical 
> > processors. If MPS table is not present, it will fall back to UP.
> > > 
> > > Thanks,
> > > Jun
> > > 
> > > > -----Original Message-----
> > > > From: James Wright [mailto:james@jigsawdezign.com]
> > > > Sent: Wednesday, March 19, 2003 5:34 PM
> > > > To: linux-kernel@vger.kernel.org
> > > > Subject: P4 3.06Ghz Hyperthreading with 2.4.20?
> > > > 
> > > > Hello,
> > > > 
> > > >    I have kernel 2.4.20 with a single P4 3.06Ghz CPU and 
> > Asus P4G8X
> > > > motherboard
> > > > (with the Intel E7205) Chipset. I have enabled 
> > Hyperthreading in the BIOS
> > > > options,
> > > > compiled in SMP & ACPI support, and also tried adding 
> > "acpismp=force" to
> > > > my lilo
> > > > kernel cmdline, but it just doesn't seem to detect the 
> > second Logical CPU.
> > > > My
> > > > current theory is that this is bcos Linux expects the 
> > motherboard to be an
> > > > SMP
> > > > item (as with the Xeon boards) but this board is a Single 
> > processor board,
> > > > ansd
> > > > doesn't have an MP table, but the cpu info is held in the 
> > ACPI tables.?!?
> > > > 
> > > > I have tried installing 2.5.65 but can't get past the 
> > compile due to
> > > > compile-time
> > > > errors... Is this a known problem? SHall i just disable 
> > Hyperthreading
> > > > until a new
> > > > kernel release?
> > > > 
> > > > 
> > > > Thanks,
> > > > James
> > > > 
> > > > 
> > > > 
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
