Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbULDDQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbULDDQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 22:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbULDDQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 22:16:15 -0500
Received: from mail19a.dulles19-verio.com ([204.202.242.24]:63931 "HELO
	mail19a.g19.rapidsite.net") by vger.kernel.org with SMTP
	id S262417AbULDDPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 22:15:53 -0500
Message-ID: <000501c4d9af$850c8170$87033944@msr>
From: "Reddy Mukkamalla" <msreddy@guardiansolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: Oops on 2.4.20-6 Kernel
Date: Fri, 3 Dec 2004 22:15:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi group,
  We are getting very frequent Kernel Oops on many machine. The machines 
have IB104+; PC104 based computer with Transmeta Crusoe TM5800 processor. 
Almost all the errors seem to be with virtual memory. Here is the output of 
ksymoops and related information from a machine.

[root@Tioga2 guard]# dmesg | ksymoops --system-map=/boot/System.map
ksymoops 2.4.9 on i686 2.4.20-6crusoe.  Options used
    -V (default)
    -k /proc/ksyms (default)
    -l /proc/modules (default)
    -o /lib/modules/2.4.20-6crusoe/ (default)
    -m /boot/System.map (specified)

e100: selftest OK.
e100: eth0: Intel(R) PRO/100+ Management Adapter
e100: eth0 NIC Link is Up 10 Mbps Half duplex
Unable to handle kernel paging request at virtual address 10101011
c0135e87
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0135e87>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013
eax: 10101011  ebx: 00000140  ecx: c1a4ef18  edx: c1a4ef28
esi: 00000008  edi: 00000000  ebp: c1a4ef84  esp: ca9e388c
ds: 0068  es: 0068  ss: 0068
Process CSM (pid: 1515, stackpage=ca9e3000)
Stack: c030e458 00000000 c1a4ef18 00000000 00000006 00000006 0000188d 
000001d2
      000001d2 00000000 c0138c9e c1a4c12c 000001d2 ca9e2000 00000001 
c01392e1
      000001d2 c027efcc 00000300 c013a87f c027efc0 00000000 00000001 
00000001
Call Trace:  [<c0138c9e>]  (0xca9e38b4))
[<c01392e1>]  (0xca9e38c8))
[<c013a87f>]  (0xca9e38d8))
[<c013261b>]  (0xca9e3914))
[<c016cd99>]  (0xca9e3984))
[<c0162a9b>]  (0xca9e39a4))
[<c0163ab8>]  (0xca9e39bc))
[<c01cba54>]  (0xca9e3a5c))
[<c0210810>]  (0xca9e3a68))
[<c020f532>]  (0xca9e3a8c))
[<c01cbbdd>]  (0xca9e3a98))
[<c022378a>]  (0xca9e3abc))
[<c021e7e2>]  (0xca9e3adc))
[<c01acf38>]  (0xca9e3ae4))
[<c01ad005>]  (0xca9e3af0))
[<c01d319d>]  (0xca9e3b00))
[<c01d3b58>]  (0xca9e3b3c))
[<c01d3d16>]  (0xca9e3b4c))
[<c01d39ec>]  (0xca9e3b54))
[<c01d2f70>]  (0xca9e3b60))
[<c01d3640>]  (0xca9e3b68))
[<c01ccd83>]  (0xca9e3b7c))
[<c01c2ab1>]  (0xca9e3ba4))
[<c01f0444>]  (0xca9e3bb0))
[<c0178157>]  (0xca9e3bc8))
[<c0178157>]  (0xca9e3bdc))
[<c0178b24>]  (0xca9e3c04))
[<c017175f>]  (0xca9e3c30))
[<c0178157>]  (0xca9e3c3c))
[<c0178495>]  (0xca9e3c50))
[<c014bc0a>]  (0xca9e3e74))
[<c0120035>]  (0xca9e3ea0))
[<c012488f>]  (0xca9e3ec0))
[<c01248f4>]  (0xca9e3edc))
[<c01259c8>]  (0xca9e3ef8))
[<c0109041>]  (0xca9e3f20))
[<c016cd99>]  (0xca9e3f78))
[<c01428a9>]  (0xca9e3f98))
[<c01092b0>]  (0xca9e3fc0))
Code: 8b 00 43 39 d0 75 f9 8b 44 24 08 89 da 8b 78 24 8b 40 44 89


>>EIP; c0135e87 <kmem_cache_reap+137/1d0>  <=====

>>ecx; c1a4ef18 <_end+17016a0/f5057e8>
>>edx; c1a4ef28 <_end+17016b0/f5057e8>
>>ebp; c1a4ef84 <_end+170170c/f5057e8>
>>esp; ca9e388c <_end+a696014/f5057e8>

Trace; c0138c9e <do_try_to_free_pages+5e/a0>
Trace; c01392e1 <try_to_free_pages+51/60>
Trace; c013a87f <__alloc_pages+16f/300>
Trace; c013261b <generic_file_write+37b/810>
Trace; c016cd99 <ext3_file_write+39/d0>
Trace; c0162a9b <dump_write+2b/40>
Trace; c0163ab8 <elf_core_dump+ba8/cd0>
Trace; c01cba54 <start_request+1b4/230>
Trace; c0210810 <ip_queue_xmit2+c0/240>
Trace; c020f532 <ip_queue_xmit+1f2/2d0>
Trace; c01cbbdd <ide_do_request+bd/190>
Trace; c022378a <tcp_v4_send_check+4a/d0>
Trace; c021e7e2 <tcp_transmit_skb+2b2/440>
Trace; c01acf38 <locate_hd_struct+38/90>
Trace; c01ad005 <account_io_start+35/60>
Trace; c01d319d <ide_build_sglist+16d/210>
Trace; c01d3b58 <__ide_dma_begin+38/50>
Trace; c01d3d16 <__ide_dma_count+16/20>
Trace; c01d39ec <__ide_dma_read+10c/120>
Trace; c01d2f70 <ide_dma_intr+0/c0>
Trace; c01d3640 <dma_timer_expiry+0/e0>
Trace; c01ccd83 <do_rw_disk+1d3/720>
Trace; c01c2ab1 <ide_wait_stat+f1/130>
Trace; c01f0444 <lvm_map+124/4a0>
Trace; c0178157 <do_get_write_access+2a7/590>
Trace; c0178157 <do_get_write_access+2a7/590>
Trace; c0178b24 <journal_dirty_metadata+174/200>
Trace; c017175f <ext3_do_update_inode+16f/3e0>
Trace; c0178157 <do_get_write_access+2a7/590>
Trace; c0178495 <journal_get_write_access+55/80>
Trace; c014bc0a <do_coredump+19a/1b0>
Trace; c0120035 <__request_resource+25/70>
Trace; c012488f <__dequeue_signal+6f/a0>
Trace; c01248f4 <dequeue_signal+34/70>
Trace; c01259c8 <get_signal_to_deliver+1a8/280>
Trace; c0109041 <do_signal+61/d0>
Trace; c016cd99 <ext3_file_write+39/d0>
Trace; c01428a9 <sys_write+e9/130>
Trace; c01092b0 <signal_return+14/18>

Code;  c0135e87 <kmem_cache_reap+137/1d0>
00000000 <_EIP>:
Code;  c0135e87 <kmem_cache_reap+137/1d0>  <=====
  0:  8b 00                    mov    (%eax),%eax  <=====
Code;  c0135e89 <kmem_cache_reap+139/1d0>
  2:  43                        inc    %ebx
Code;  c0135e8a <kmem_cache_reap+13a/1d0>
  3:  39 d0                    cmp    %edx,%eax
Code;  c0135e8c <kmem_cache_reap+13c/1d0>
  5:  75 f9                    jne    0 <_EIP>
Code;  c0135e8e <kmem_cache_reap+13e/1d0>
  7:  8b 44 24 08              mov    0x8(%esp,1),%eax
Code;  c0135e92 <kmem_cache_reap+142/1d0>
  b:  89 da                    mov    %ebx,%edx
Code;  c0135e94 <kmem_cache_reap+144/1d0>
  d:  8b 78 24                  mov    0x24(%eax),%edi
Code;  c0135e97 <kmem_cache_reap+147/1d0>
  10:  8b 40 44                  mov    0x44(%eax),%eax
Code;  c0135e9a <kmem_cache_reap+14a/1d0>
  13:  89 00                    mov    %eax,(%eax)



[root@Tioga2 guard]# cat /proc/cpuinfo
processor      : 0
vendor_id      : GenuineTMx86
cpu family      : 6
model          : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5800
stepping        : 3
cpu MHz        : 799.335
cache size      : 512 KB
fdiv_bug        : no
hlt_bug        : no
f00f_bug        : no
coma_bug        : no
fpu            : yes
fpu_exception  : yes
cpuid level    : 1
wp              : yes
flags          : fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips        : 1255.01




[guard@localhost guard]$ /sbin/lspci -v
00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
        Flags: fast devsel

00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
        Flags: fast devsel

00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 0141
        Flags: bus master, VGA palette snoop, stepping, medium devsel, 
latency 32
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at ec00 [size=256]
        Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

00:05.0 IDE interface: CMD Technology Inc PCI0680 (rev 02) (prog-if 85 
[Master SecO PriO])
        Subsystem: Dell Computer Corporation: Unknown device 0141
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at e8f8 [size=8]
        I/O ports at e8f0 [size=4]
        I/O ports at e8e0 [size=8]
        I/O ports at e8d8 [size=4]
        I/O ports at e8c0 [size=16]
        Memory at fe102000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at fe000000 [disabled] [size=512K]
        Capabilities: <available only to root>

00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev a0)
        Subsystem: ServerWorks: Unknown device 0201
        Flags: bus master, medium devsel, latency 32

00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0) 
(prog-if 8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 0141
        Flags: bus master, medium devsel, latency 64
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05) 
(prog-if 10 [OHCI])
        Subsystem: ServerWorks: Unknown device 0220
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at fe100000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

00:10.0 Host bridge: ServerWorks: Unknown device 0110 (rev 12)
        Flags: 66Mhz, medium devsel
        Capabilities: <available only to root>

00:10.2 Host bridge: ServerWorks: Unknown device 0110 (rev 12)
        Flags: 66Mhz, medium devsel
        Capabilities: <available only to root>

01:03.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller 
(Copper) (rev 01)
        Subsystem: Intel Corp.: Unknown device 1012
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
        Memory at fcf20000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at dcc0 [size=64]
        Capabilities: <available only to root>

01:03.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller 
(Copper) (rev 01)
        Subsystem: Intel Corp.: Unknown device 1012
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 7
        Memory at fcf00000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at dc80 [size=64]
        Capabilities: <available only to root>


[root@Tioga2 guard]# /sbin/lsmod
Module                  Size  Used by    Not tainted
bttv                  73696  1  (autoclean)
soundcore              6372  0  (autoclean) [bttv]
i2c-algo-bit            8776  1  (autoclean) [bttv]
videodev                8192  3  (autoclean) [bttv]
eeprom                  4916  0  (unused)
via686a                9760  0  (unused)
i2c-proc                9008  0  [eeprom via686a]
i2c-viapro              4944  0  (unused)
i2c-isa                1864  0  (unused)
i2c-core              18916  0  [bttv i2c-algo-bit eeprom via686a i2c-proc 
i2c-viapro i2c-isa]
softdog                2940  1
parport_pc            18916  1  (autoclean)
lp                      8932  0  (autoclean)
parport                36576  1  (autoclean) [parport_pc lp]
sd_mod                13292  0  (autoclean) (unused)
scsi_mod              105656  1  (autoclean) [sd_mod]
e100                  59684  1


There are also times when machines just hang (no oops ). It is possible that 
hardware is the culprit here (and I strongly suspect it is), but I am not 
really sure how to confirm that or if it is the kernel or something else. 
These errors are very frequent on few particular machines. Greatly 
appreciate you input and time. Thanks

regards,
MSR

