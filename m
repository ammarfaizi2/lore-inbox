Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTAGIT4>; Tue, 7 Jan 2003 03:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTAGIT4>; Tue, 7 Jan 2003 03:19:56 -0500
Received: from mailgate2.globalintranet.net ([194.206.181.243]:59322 "EHLO
	relais-int8.globalintranet.net") by vger.kernel.org with ESMTP
	id <S267337AbTAGITy>; Tue, 7 Jan 2003 03:19:54 -0500
Message-ID: <3E1A8E73.3060802@intranode.com>
Date: Tue, 07 Jan 2003 09:23:15 +0100
From: FORT David <david.fort@intranode.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021209
X-Accept-Language: fr-fr, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ooops in 2.4.21-pre2
Content-Type: multipart/mixed;
 boundary="------------030808090402050105090402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030808090402050105090402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I caught that oops when trying 2.4.21-pre2, the oops clearly occurs when
the ide-tape module is unloaded. When ide-tape is compiled in the kernel
everything is fine. Despite that oops the corrections on ide-tape are 
just fine,
i couldn't get 2.4.x kernel working correctly with tape drive(Oops and host
completly frozen, no serial console), and now i have no more problem.

Host is a Compaq ML350, but same thing occurs with DL380. Oops occurs in 
both
SMP and UP environments.
Pertinant part of dmesg(ide-tape in kernel):
 >Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
 >ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
 >SvrWks OSB4: IDE controller at PCI slot 00:0f.1
 >SvrWks OSB4: chipset revision 0
 >SvrWks OSB4: not 100% native mode: will probe irqs later
 >    ide0: BM-DMA at 0x3400-0x3407, BIOS settings: hda:DMA, hdb:DMA
 >    ide1: BM-DMA at 0x3408-0x340f, BIOS settings: hdc:pio, hdd:pio
 >hda: Compaq CRD-8402B, ATAPI CD/DVD-ROM drive
 >hdb: Seagate STT20000A, ATAPI TAPE drive
 >ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 >hdb: DMA disabled
 >ide-tape: hdb <-> ht0: Seagate STT20000A rev 8A51
 >ide-tape: hdb <-> ht0: 1000KBps, 6*54kB buffer, 9720kB pipeline, 110ms 
tDSC

Feel free to ask more details.

-- 
-- FORT David - david.fort@intranode.com --
-- Intranode Software Technologies --------
----- Security you can see. ---------------



--------------030808090402050105090402
Content-Type: text/plain;
 name="oops-tape"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-tape"

ksymoops 0.7c on i686 2.4.20-pre2-pfo.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre2-pfo/ (default)
     -m /boot/System.map-2.4.20-pre2-pfo (specified)

Warning (compare_ksyms_lsmod): module ide-tape is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_build_dmatable not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_destroy_dmatable not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_dma_intr not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_get_best_pio_mode not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_register_driver not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_unregister_driver not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pio_timings not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_set_xfer_rate not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_dma not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_device not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_devices not found in System.map.  Ignoring ksyms_base entry
cpu: 0, clocks: 1324516, slice: 662258
Unable to handle kernel NULL pointer dereference at virtual address 000000c4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c88a3689>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: c02f3e9c   edx: c88a5d81
esi: 00000014   edi: 00000001   ebp: bfffee28   esp: c28e9f8c
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 1196, stackpage=c28e9000)
Stack: c889c000 c8895000 c011b8fe c889c000 c8895000 00000001 c011adba c889c000 
       00000001 c28e8000 00000061 080661b8 bfffee28 c01070bf 00000000 bffffeb4 
       0805a95b 00000061 080661b8 bfffee28 00000081 0000002b 0000002b 00000081 
Call Trace:    [<c011b8fe>] [<c011adba>] [<c01070bf>]
Code: 8b b3 c4 00 00 00 85 f6 74 13 68 e4 5f 8a c8 8b 8b c4 00 00 

>>EIP; c88a3689 <[8139too].data.end+ab22/154f9>   <=====
Trace; c011b8fe <free_module+1e/d0>
Trace; c011adba <sys_delete_module+1ea/260>
Trace; c01070bf <system_call+33/38>
Code;  c88a3689 <[8139too].data.end+ab22/154f9>
00000000 <_EIP>:
Code;  c88a3689 <[8139too].data.end+ab22/154f9>   <=====
   0:   8b b3 c4 00 00 00         mov    0xc4(%ebx),%esi   <=====
Code;  c88a368f <[8139too].data.end+ab28/154f9>
   6:   85 f6                     test   %esi,%esi
Code;  c88a3691 <[8139too].data.end+ab2a/154f9>
   8:   74 13                     je     1d <_EIP+0x1d> c88a36a6 <[8139too].data.end+ab3f/154f9>
Code;  c88a3693 <[8139too].data.end+ab2c/154f9>
   a:   68 e4 5f 8a c8            push   $0xc88a5fe4
Code;  c88a3698 <[8139too].data.end+ab31/154f9>
   f:   8b 8b c4 00 00 00         mov    0xc4(%ebx),%ecx


12 warnings issued.  Results may not be reliable.

--------------030808090402050105090402--

