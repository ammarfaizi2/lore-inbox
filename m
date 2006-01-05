Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWAEX41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWAEX41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWAEX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:56:27 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:25275 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932268AbWAEX40 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:56:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZGH8V57hnTWuAD2nUwpEse1RzeU/+PEy7pbvAH9isfcV4dYR4iZ1kdv22UR1mX7XfvQs5U9AgMjYTKBu00IuGP0b/sMr4pHR9cgZS1fjZAP6PDlPNvLmqWm/gNbHlsqybBqLGmilF3OdF+cvVfKs19t/B0ERxa4Hkl4uX6tWv2w=
Message-ID: <9a8748490601051556r601d606do2f561aff6d5b32a@mail.gmail.com>
Date: Fri, 6 Jan 2006 00:56:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 1/5/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/
> >
> >
> <!-- snip -->
>
> Hi Andrew,
>
> 2.6.15-mm1 seems to be working less than perfect on my box.
>
<snip original mail>

Whoops, forgot to include dmesg info (taken from /var/log/messages).
This is from boot until crash of my last 2.6.15-mm1 boot.


Jan  6 00:18:39 dragon kernel: [    0.000000] Linux version 2.6.15-mm1
(juhl@dragon) (gcc version 3.4.5) #1 SMP PREEMPT Fri Jan 6 00:01:50
CET 2006
Jan  6 00:18:39 dragon kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  6 00:18:39 dragon kernel: [    0.000000] 1151MB HIGHMEM available.
Jan  6 00:18:39 dragon kernel: [    0.000000] 896MB LOWMEM available.
Jan  6 00:18:39 dragon kernel: [    0.000000] found SMP MP-table at 000ff780
Jan  6 00:18:39 dragon kernel: [    0.000000] DMI 2.3 present.
Jan  6 00:18:39 dragon kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x808
Jan  6 00:18:39 dragon kernel: [    0.000000] ACPI: LAPIC
(acpi_id[0x01] lapic_id[0x00] enabled)
Jan  6 00:18:39 dragon kernel: [    0.000000] ACPI: LAPIC
(acpi_id[0x02] lapic_id[0x01] enabled)
Jan  6 00:18:39 dragon kernel: [    0.000000] ACPI: IOAPIC (id[0x02]
address[0xfec00000] gsi_base[0])
Jan  6 00:18:39 dragon kernel: [    0.000000] ACPI: IOAPIC (id[0x03]
address[0xfec10000] gsi_base[24])
Jan  6 00:18:39 dragon kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0
bus_irq 0 global_irq 2 dfl dfl)
Jan  6 00:18:39 dragon kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0
bus_irq 9 global_irq 9 low level)
Jan  6 00:18:39 dragon kernel: [    0.000000] Using ACPI (MADT) for
SMP configuration information
Jan  6 00:18:39 dragon kernel: [   30.291133] Enabling fast FPU save
and restore... done.
Jan  6 00:18:39 dragon kernel: [   30.291135] Enabling unmasked SIMD
FPU exception support... done.
Jan  6 00:18:39 dragon kernel: [   30.291138] Initializing CPU#0
Jan  6 00:18:39 dragon kernel: [   30.291142] Kernel command line:
BOOT_IMAGE=2.6.15-mm1 ro root=801 pci=usepirqmask
Jan  6 00:18:39 dragon kernel: [   31.092058] Memory:
2074832k/2096832k available (2136k kernel code, 20832k reserved, 868k
data, 208k init, 1179328k highmem)
Jan  6 00:18:39 dragon kernel: [   31.151513] CPU: L1 I Cache: 64K (64
bytes/line), D cache 64K (64 bytes/line)
Jan  6 00:18:39 dragon kernel: [   31.151517] CPU: L2 Cache: 1024K (64
bytes/line)
Jan  6 00:18:39 dragon kernel: [   31.151520] CPU 0(2) -> Core 0
Jan  6 00:18:39 dragon kernel: [   31.151528] Intel machine check
architecture supported.
Jan  6 00:18:39 dragon kernel: [   31.151532] Intel machine check
reporting enabled on CPU#0.
Jan  6 00:18:39 dragon kernel: [   31.151541] mtrr: v2.0 (20020519)
Jan  6 00:18:39 dragon kernel: [   31.151547] Checking 'hlt' instruction... OK.
Jan  6 00:18:39 dragon kernel: [   31.167918] Initializing CPU#1
Jan  6 00:18:39 dragon kernel: [   31.228356] CPU: L1 I Cache: 64K (64
bytes/line), D cache 64K (64 bytes/line)
Jan  6 00:18:39 dragon kernel: [   31.228357] CPU: L2 Cache: 1024K (64
bytes/line)
Jan  6 00:18:39 dragon kernel: [   31.228359] CPU 1(2) -> Core 1
Jan  6 00:18:39 dragon kernel: [   31.228364] Intel machine check
architecture supported.
Jan  6 00:18:39 dragon kernel: [   31.228366] Intel machine check
reporting enabled on CPU#1.
Jan  6 00:18:39 dragon kernel: [   31.228495] Total of 2 processors
activated (8801.21 BogoMIPS).
Jan  6 00:18:39 dragon kernel: [   31.229078] ..TIMER: vector=0x31
apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  6 00:18:39 dragon kernel: [   31.340174] checking TSC
synchronization across 2 CPUs:
Jan  6 00:18:39 dragon kernel: [    0.000002] CPU#0 had 0 usecs TSC
skew, fixed it up.
Jan  6 00:18:39 dragon kernel: [    0.000005] CPU#1 had 0 usecs TSC
skew, fixed it up.
Jan  6 00:18:39 dragon kernel: [    0.000996] Brought up 2 CPUs
Jan  6 00:18:39 dragon kernel: [    0.144949] NET: Registered protocol family 16
Jan  6 00:18:39 dragon kernel: [    0.144975] ACPI: bus type pci registered
Jan  6 00:18:39 dragon kernel: [    0.145337] PCI: PCI BIOS revision
3.00 entry at 0xf0031, last bus=4
Jan  6 00:18:39 dragon kernel: [    0.145345] PCI: Using configuration type 1
Jan  6 00:18:39 dragon kernel: [    0.145505] ACPI: Subsystem revision 20051216
Jan  6 00:18:39 dragon kernel: [    0.148985] ACPI: Interpreter enabled
Jan  6 00:18:39 dragon kernel: [    0.148992] ACPI: Using IOAPIC for
interrupt routing
Jan  6 00:18:39 dragon kernel: [    0.149711] ACPI: PCI Root Bridge
[PCI0] (0000:00)
Jan  6 00:18:39 dragon kernel: [    0.152491] PCI: Transparent bridge
- 0000:00:06.0
Jan  6 00:18:39 dragon kernel: [    0.172120] SCSI subsystem initialized
Jan  6 00:18:39 dragon kernel: [    0.172128] PCI: Using ACPI for IRQ routing
Jan  6 00:18:39 dragon kernel: [    0.172132] PCI: If a device doesn't
work, try "pci=routeirq".  If it helps, post a report
Jan  6 00:18:39 dragon kernel: [    0.180365] PCI: Bridge: 0000:00:01.0
Jan  6 00:18:39 dragon kernel: [    0.180368]   IO window: disabled.
Jan  6 00:18:39 dragon kernel: [    0.180373]   MEM window: ff200000-ff2fffff
Jan  6 00:18:39 dragon kernel: [    0.180376]   PREFETCH window: disabled.
Jan  6 00:18:39 dragon kernel: [    0.180381] PCI: Bridge: 0000:00:02.0
Jan  6 00:18:39 dragon kernel: [    0.180383]   IO window: disabled.
Jan  6 00:18:39 dragon kernel: [    0.180387]   MEM window: ff300000-ff3fffff
Jan  6 00:18:39 dragon kernel: [    0.180391]   PREFETCH window: disabled.
Jan  6 00:18:39 dragon kernel: [    0.180395] PCI: Bridge: 0000:00:05.0
Jan  6 00:18:39 dragon kernel: [    0.180397]   IO window: disabled.
Jan  6 00:18:39 dragon kernel: [    0.180403]   MEM window: ff400000-ff4fffff
Jan  6 00:18:39 dragon kernel: [    0.180408]   PREFETCH window:
c7f00000-d7efffff
Jan  6 00:18:39 dragon kernel: [    0.180415] PCI: Bridge: 0000:00:06.0
Jan  6 00:18:39 dragon kernel: [    0.180419]   IO window: d000-dfff
Jan  6 00:18:39 dragon kernel: [    0.180425]   MEM window: ff500000-ff5fffff
Jan  6 00:18:39 dragon kernel: [    0.180430]   PREFETCH window:
88000000-880fffff
Jan  6 00:18:39 dragon kernel: [    0.180443] ACPI: PCI Interrupt
0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
Jan  6 00:18:39 dragon kernel: [    0.180457] ACPI: PCI Interrupt
0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
Jan  6 00:18:39 dragon kernel: [    0.396000] Machine check exception
polling timer started.
Jan  6 00:18:39 dragon kernel: [    0.396000] apm: BIOS version 1.2
Flags 0x02 (Driver version 1.16ac)
Jan  6 00:18:39 dragon kernel: [    0.396000] apm: disabled - APM is
not SMP safe.
Jan  6 00:18:39 dragon kernel: [    0.397000] io scheduler noop registered
Jan  6 00:18:39 dragon kernel: [    0.397000] io scheduler
anticipatory registered
Jan  6 00:18:39 dragon kernel: [    0.397000] vesafb: framebuffer at
0xc8000000, mapped to 0xf8880000, using 3072k, total 16384k
Jan  6 00:18:39 dragon kernel: [    0.397000] vesafb: mode is
1024x768x16, linelength=2048, pages=9
Jan  6 00:18:39 dragon kernel: [    0.397000] vesafb: protected mode
interface info at c000:7880
Jan  6 00:18:39 dragon kernel: [    0.397000] vesafb: scrolling: redraw
Jan  6 00:18:39 dragon kernel: [    0.397000] vesafb: Truecolor:
size=0:5:6:5, shift=0:11:5:0
Jan  6 00:18:39 dragon kernel: [    0.408000] Time: tsc clocksource
has been installed.
Jan  6 00:18:39 dragon kernel: [    0.460000] Time: pit clocksource
has been installed.
Jan  6 00:18:39 dragon kernel: [    0.549000] fb0: VESA VGA frame buffer device
Jan  6 00:18:39 dragon kernel: [    0.552000] Real Time Clock Driver v1.12
Jan  6 00:18:39 dragon kernel: [    0.554000] serio: i8042 AUX port at
0x60,0x64 irq 12
Jan  6 00:18:39 dragon kernel: [    0.555000] serio: i8042 KBD port at
0x60,0x64 irq 1
Jan  6 00:18:39 dragon kernel: [    0.555000] Serial: 8250/16550
driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
Jan  6 00:18:39 dragon kernel: [    0.557000] serial8250: ttyS0 at I/O
0x3f8 (irq = 4) is a 16550A
Jan  6 00:18:39 dragon kernel: [    0.558000] Floppy drive(s): fd0 is 1.44M
Jan  6 00:18:39 dragon kernel: [    0.572000] FDC 0 is a post-1991 82077
Jan  6 00:18:39 dragon kernel: [    0.574000]
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
Jan  6 00:18:39 dragon kernel: [    0.575000] ACPI: PCI Interrupt
0000:04:07.0[A] -> GSI 22 (level, low) -> IRQ 18
Jan  6 00:18:39 dragon kernel: [    0.576000] PCI: Via IRQ fixup for
0000:04:07.0, from 11 to 2
Jan  6 00:18:39 dragon kernel: [    0.578000] eth0: VIA Rhine II at
0xff5fec00, 00:50:ba:f2:a3:1d, IRQ 18.
Jan  6 00:18:39 dragon kernel: [    0.580000] eth0: MII PHY found at
address 8, status 0x782d advertising 01e1 Link 45e1.
Jan  6 00:18:39 dragon kernel: [    0.581000] ACPI: PCI Interrupt
0000:04:06.0[A] -> GSI 21 (level, low) -> IRQ 19
Jan  6 00:18:39 dragon kernel: [    0.792000] scsi0 : Adaptec AIC7XXX
EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
Jan  6 00:18:39 dragon kernel: [   16.824000]   Vendor: PIONEER  
Model: DVD-ROM DVD-305   Rev: 1.03
Jan  6 00:18:39 dragon kernel: [   16.852000]   Type:   CD-ROM        
                    ANSI SCSI revision: 02
Jan  6 00:18:39 dragon kernel: [   16.854000]  target0:0:4: Beginning
Domain Validation
Jan  6 00:18:39 dragon kernel: [   16.858000]  target0:0:4: FAST-20
SCSI 20.0 MB/s ST (50 ns, offset 16)
Jan  6 00:18:39 dragon kernel: [   16.888000]  target0:0:4: Domain
Validation skipping write tests
Jan  6 00:18:39 dragon kernel: [   16.890000]  target0:0:4: Ending
Domain Validation
Jan  6 00:18:39 dragon kernel: [   16.923000]   Vendor: PLEXTOR  
Model: CD-R   PX-W1210S  Rev: 1.01
Jan  6 00:18:39 dragon kernel: [   16.926000]   Type:   CD-ROM        
                    ANSI SCSI revision: 02
Jan  6 00:18:39 dragon kernel: [   16.954000]  target0:0:5: Beginning
Domain Validation
Jan  6 00:18:39 dragon kernel: [   16.983000]  target0:0:5: FAST-20
SCSI 20.0 MB/s ST (50 ns, offset 16)
Jan  6 00:18:39 dragon kernel: [   17.012000]  target0:0:5: Domain
Validation skipping write tests
Jan  6 00:18:39 dragon kernel: [   17.013000]  target0:0:5: Ending
Domain Validation
Jan  6 00:18:39 dragon kernel: [   17.041000]   Vendor: IBM      
Model: DDYS-T36950N      Rev: S96H
Jan  6 00:18:39 dragon kernel: [   17.044000]   Type:   Direct-Access 
                    ANSI SCSI revision: 03
Jan  6 00:18:39 dragon kernel: [   17.073000]  target0:0:6: Beginning
Domain Validation
Jan  6 00:18:39 dragon kernel: [   17.077000]  target0:0:6: wide asynchronous
Jan  6 00:18:39 dragon kernel: [   17.106000]  target0:0:6: FAST-80
WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
Jan  6 00:18:39 dragon kernel: [   17.147000]  target0:0:6: Ending
Domain Validation
Jan  6 00:18:39 dragon kernel: [   19.200000] QLogic Fibre Channel HBA Driver
Jan  6 00:18:39 dragon kernel: [   19.228000] SCSI device sda:
71687340 512-byte hdwr sectors (36704 MB)
Jan  6 00:18:39 dragon kernel: [   19.230000] sda: Write Protect is off
Jan  6 00:18:39 dragon kernel: [   19.258000] SCSI device sda: drive
cache: write back
Jan  6 00:18:39 dragon kernel: [   19.260000] SCSI device sda:
71687340 512-byte hdwr sectors (36704 MB)
Jan  6 00:18:39 dragon kernel: [   19.262000] sda: Write Protect is off
Jan  6 00:18:39 dragon kernel: [   19.291000] SCSI device sda: drive
cache: write back
Jan  6 00:18:39 dragon kernel: [   19.318000]  sda: sda1 sda2 sda3 sda4
Jan  6 00:18:39 dragon kernel: [   19.335000] sd 0:0:6:0: Attached scsi disk sda
Jan  6 00:18:39 dragon kernel: [   19.344000] Uniform CD-ROM driver
Revision: 3.20
Jan  6 00:18:39 dragon kernel: [   19.351000] sr 0:0:4:0: Attached
scsi generic sg0 type 5
Jan  6 00:18:39 dragon kernel: [   19.379000] sr 0:0:5:0: Attached
scsi generic sg1 type 5
Jan  6 00:18:39 dragon kernel: [   19.380000] sd 0:0:6:0: Attached
scsi generic sg2 type 0
Jan  6 00:18:39 dragon kernel: [   19.381000] mice: PS/2 mouse device
common for all mice
Jan  6 00:18:39 dragon kernel: [   19.382000] MC:
drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Jan  5 2006
Jan  6 00:18:39 dragon kernel: [   19.409000] NET: Registered protocol family 2
Jan  6 00:18:39 dragon kernel: [   19.416000] input: AT Translated Set
2 keyboard as /class/input/input0
Jan  6 00:18:39 dragon kernel: [   19.427000] TCP: Hash tables
configured (established 262144 bind 65536)
Jan  6 00:18:39 dragon kernel: [   19.441000] Time: acpi_pm
clocksource has been installed.
Jan  6 00:18:39 dragon kernel: [   19.455000] TCP reno registered
Jan  6 00:18:39 dragon kernel: [   19.456000] TCP bic registered
Jan  6 00:18:39 dragon kernel: [   19.457000] NET: Registered protocol family 1
Jan  6 00:18:39 dragon kernel: [   19.458000] NET: Registered protocol family 17
Jan  6 00:18:39 dragon kernel: [   19.459000] Starting balanced_irq
Jan  6 00:18:39 dragon kernel: [   19.476000] EXT3-fs: mounted
filesystem with ordered data mode.
Jan  6 00:18:39 dragon kernel: [   19.478000] Freeing unused kernel
memory: 208k freed
Jan  6 00:18:39 dragon kernel: [   19.479000] kjournald starting. 
Commit interval 5 seconds
Jan  6 00:18:39 dragon kernel: [   19.819000] input: ImExPS/2 Generic
Explorer Mouse as /class/input/input1
Jan  6 00:18:39 dragon kernel: [   21.108000] Adding 763076k swap on
/dev/sda3.  Priority:-1 extents:1 across:763076k
Jan  6 00:18:39 dragon kernel: [   21.280000] EXT3 FS on sda1, internal journal
Jan  6 00:18:39 dragon kernel: [   22.130000] Linux agpgart interface
v0.101 (c) Dave Jones
Jan  6 00:18:39 dragon kernel: [   25.715000] ReiserFS: sda2: found
reiserfs format "3.6" with standard journal
Jan  6 00:18:39 dragon kernel: [   25.949000] ReiserFS: sda2: using
ordered data mode
Jan  6 00:18:39 dragon kernel: [   25.957000] ReiserFS: sda2: journal
params: device sda2, size 8192, journal first block 18, max trans len
1024, max batch 900, max commit age 30, max trans age 30
Jan  6 00:18:39 dragon kernel: [   25.959000] ReiserFS: sda2: checking
transaction log (sda2)
Jan  6 00:18:39 dragon kernel: [   25.972000] ReiserFS: sda2: Using r5
hash to sort names
Jan  6 00:18:39 dragon kernel: [   26.024000] ReiserFS: sda4: found
reiserfs format "3.6" with standard journal
Jan  6 00:18:39 dragon kernel: [   26.664000] ReiserFS: sda4: using
ordered data mode
Jan  6 00:18:39 dragon kernel: [   26.679000] ReiserFS: sda4: journal
params: device sda4, size 8192, journal first block 18, max trans len
1024, max batch 900, max commit age 30, max trans age 30
Jan  6 00:18:39 dragon kernel: [   26.680000] ReiserFS: sda4: checking
transaction log (sda4)
Jan  6 00:18:39 dragon kernel: [   26.728000] ReiserFS: sda4: Using r5
hash to sort names
Jan  6 00:18:39 dragon logger: /etc/rc.d/rc.inet1:  /sbin/ifconfig lo 127.0.0.1
Jan  6 00:18:39 dragon logger: /etc/rc.d/rc.inet1:  /sbin/route add
-net 127.0.0.0 netmask 255.0.0.0 lo
Jan  6 00:18:39 dragon logger: /etc/rc.d/rc.inet1:  /sbin/dhcpcd -d -t 60  eth0
Jan  6 00:18:39 dragon kernel: [   28.541000] eth0: link up, 100Mbps,
full-duplex, lpa 0x45E1
Jan  6 00:18:40 dragon dhcpcd[1065]: infinite IP address lease time. Exiting
Jan  6 00:18:40 dragon logger: /etc/rc.d/rc.hotplug start (entering script)
Jan  6 00:18:40 dragon kernel: [   28.974000] ACPI: PCI Interrupt
0000:04:05.0[A] -> GSI 20 (level, low) -> IRQ 20
Jan  6 00:18:41 dragon kernel: [   29.689000] usbcore: registered new
driver usbfs
Jan  6 00:18:41 dragon kernel: [   29.699000] usbcore: registered new driver hub
Jan  6 00:18:41 dragon kernel: [   29.717000] USB Universal Host
Controller Interface driver v3.0
Jan  6 00:18:41 dragon logger: /etc/rc.d/rc.hotplug start (exiting script)
Jan  6 00:18:41 dragon sshd[2184]: Server listening on 0.0.0.0 port 22.
Jan  6 00:19:07 dragon kernel: [   55.776000] psmouse.c: resync
failed, issuing reconnect request



--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
