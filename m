Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129648AbQKYSQa>; Sat, 25 Nov 2000 13:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129770AbQKYSQV>; Sat, 25 Nov 2000 13:16:21 -0500
Received: from perso.tamaris.tm.fr ([193.252.239.194]:65295 "EHLO
        perso.tamaris.tm.fr") by vger.kernel.org with ESMTP
        id <S129648AbQKYSQL>; Sat, 25 Nov 2000 13:16:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14879.64111.798092.158027@whynot.localdomain>
Date: Sat, 25 Nov 2000 18:44:15 +0100
From: Pascal Brisset <Pascal.Brisset@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: [oops] Yenta on 2.4.0-test11 laptop (worked with test9)
X-Mailer: VM 6.76 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone using Yenta on a sony vaio laptop (PII-400) with 2.4.0-test11 ?

I can't even follow my own printk()s through the call to exca_writew()
in the trace below, so the system might be getting corrupted earlier
(possibly not in the cardbus code).

The same .config works on this machine with test9.


Unable to handle kernel NULL pointer dereference at virtual address 00000008
c4828050
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c4828050>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000008   ebx: 00000000   ecx: 00000040   edx: 0000003c
esi: 00000000   edi: c482a3a0   ebp: c113bf24   esp: c113bee4
ds: 0018   es: 0018   ss: 0018
Process eventd (pid: 3, stackpage=c113b000)
Stack: c48288b3 c482a3a0 00000008 00000000 00000000 c113bf24 c482a3a0 c482a300 
       c482a340 0000b22f c482911b c482a3a0 c113bf24 c482a3a0 00000000 c3ae5000 
       00000000 00010000 00000000 00000000 00000fff 00000000 c48292ad c482a3a0 
Call Trace: [<c48288b3>] [<c482a3a0>] [<c482a3a0>] [<c482a300>] [<c482a340>] [<c482911b>] [<c482a3a0>] 
       [<c482a3a0>] [<c48292ad>] [<c482a3a0>] [<c482a3a0>] [<c482a3a0>] [<c4829727>] [<c482a3a0>] [<c482989a>] 
       [<c482a3a0>] [<c481fef8>] [<c481ffc0>] [<c482a3a0>] [<c482a3a0>] [<c4829bc6>] [<c482a300>] [<c482a3a0>] 
       [<c482909b>] [<c482a3a0>] [<c4829e40>] [<c01168cd>] [<c482a3a0>] [<c0105000>] [<c01089ff>] 
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 82 c4 8b 5c 

>>EIP; c4828050 <[yenta_socket]exca_writew+0/4c>   <=====
Trace; c48288b3 <[yenta_socket]yenta_set_io_map+8f/148>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482a300 <[yenta_socket]pci_socket_operations+0/30>
Trace; c482a340 <[yenta_socket]cardbus_table+10/38>
Trace; c482911b <[yenta_socket]yenta_clear_maps+6b/9c>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c48292ad <[yenta_socket]yenta_init+11/18>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c4829727 <[yenta_socket]ricoh_init+b/68>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482989a <[yenta_socket]pci_init_socket+2a/38>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c481fef8 <[pcmcia_core]init_socket+28/2c>
Trace; c481ffc0 <[pcmcia_core]pcmcia_register_socket+c4/128>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c4829bc6 <[yenta_socket]cardbus_register+22/2c>
Trace; c482a300 <[yenta_socket]pci_socket_operations+0/30>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c482909b <[yenta_socket]yenta_open_bh+93/a8>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c4829e40 <[yenta_socket].rodata.start+180/310>
Trace; c01168cd <context_thread+f5/108>
Trace; c482a3a0 <[yenta_socket]__kstrtab_yenta_operations+0/0>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01089ff <kernel_thread+23/30>
Code;  c4828050 <[yenta_socket]exca_writew+0/4c>   <=====
00000000 <_EIP>:   <=====
Code;  c4828060 <[yenta_socket]exca_writew+10/4c>
  10:   82                        (bad)  
Code;  c4828061 <[yenta_socket]exca_writew+11/4c>
  11:   c4 8b 5c 00 00 00         les    0x5c(%ebx),%ecx


1 warning issued.  Results may not be reliable.



Linux version 2.4.0-test11 (root@pcg) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Sat Nov 25 11:34:01 MET 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000017800 @ 00000000000e8800 (reserved)
 BIOS-e820: 0000000003ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000f800 @ 0000000003ff0000 (ACPI data)
 BIOS-e820: 0000000000000800 @ 0000000003fff800 (ACPI NVS)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
On node 0 totalpages: 16368
zone(0): 4096 pages.
zone(1): 12272 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux-2.4.0 ro root=302 1 ro
Initializing CPU#0
Detected 397.002 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 792.99 BogoMIPS
Memory: 62696k/65472k available (882k kernel code, 2388k reserved, 53k data, 172k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Mobile Pentium II stepping 0d
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd99e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 9 for device 00:0c.0
PCI: The same IRQ used for device 00:0a.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
ACPI: "SONY" found at 0x000f6c90
acpi: APM is already active.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc98-0xfc9f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DARA-212000, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=1467/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
Real Time Clock Driver v1.10d
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 172k freed
Adding Swap: 216836k swap-space (priority -1)
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0898, PCI irq9
Socket status: 30000419
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c4828050
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c4828050>]
EFLAGS: 00010246
eax: 00000008   ebx: 00000000   ecx: 00000040   edx: 0000003c
esi: 00000000   edi: c482a3a0   ebp: c113bf24   esp: c113bee4
ds: 0018   es: 0018   ss: 0018
Process eventd (pid: 3, stackpage=c113b000)
Stack: c48288b3 c482a3a0 00000008 00000000 00000000 c113bf24 c482a3a0 c482a300 
       c482a340 0000b22f c482911b c482a3a0 c113bf24 c482a3a0 00000000 c3ae5000 
       00000000 00010000 00000000 00000000 00000fff 00000000 c48292ad c482a3a0 
Call Trace: [<c48288b3>] [<c482a3a0>] [<c482a3a0>] [<c482a300>] [<c482a340>] [<c482911b>] [<c482a3a0>] 
       [<c482a3a0>] [<c48292ad>] [<c482a3a0>] [<c482a3a0>] [<c482a3a0>] [<c4829727>] [<c482a3a0>] [<c482989a>] 
       [<c482a3a0>] [<c481fef8>] [<c481ffc0>] [<c482a3a0>] [<c482a3a0>] [<c4829bc6>] [<c482a300>] [<c482a3a0>] 
       [<c482909b>] [<c482a3a0>] [<c4829e40>] [<c01168cd>] [<c482a3a0>] [<c0105000>] [<c01089ff>] 
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 82 c4 8b 5c 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
