Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbRABGPR>; Tue, 2 Jan 2001 01:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRABGPH>; Tue, 2 Jan 2001 01:15:07 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:62098 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S129597AbRABGOu>; Tue, 2 Jan 2001 01:14:50 -0500
Date: Tue, 2 Jan 2001 06:27:37 +0100
To: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: [OOPS] kacpid dies on boot 2.4.0-prerelease
Message-ID: <20010102062737.A8217@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	acpi@phobos.fachschaften.tu-muenchen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a ksymoops processed oops which kacpid creates as part of
its initialization (i.e. at boot time).  It was connected to AC power
with a full battery, if that is significant.

Kernel is 2.4.0-prerelease.  The machine is a IBM Thinkpad i1200 series
(to be more specific model 1161-267), Coppermine Celeron CPU 550MHz,
64MB RAM, BIOS updated to 1.0R.

This machine works fine under APM except that it sucks as much power on
suspend than when running (LCD and HD shut off, that's all).  With ACPI
I have the contrary problem that it goes into CPU powersave even when it
should be running normally.  The userspace bogomips program normally
reports 546bm but only 64bm when running ACPI (and it is slow; kernel
cpuinfo reports 1040bm in both cases, it is reduced in speed only after
kernel did its own measurement).  This could be related to the kacipd
failure however.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=acpi-oops

ksymoops 2.3.4 on i686 2.4.0-prerelease-acpi.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-prerelease-acpi/ (default)
     -m /boot/System.map-2.4.0-prerelease-acpi (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01ac476
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01ac476>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0000a800   ebx: c3fa1ea4   ecx: 0000001e   edx: c1123770
esi: 00000000   edi: c027e3fc   ebp: c027e378   esp: c3fa1e84
ds: 0018   es: 0018   ss: 0018
Process kacpid (pid: 7, stackpage=c3fa1000)
Stack: c3f86360 c3fa1f1c c3fa1f78 c3f86360 c3f86360 c3fa1f1c c3fa1f78 c1123770 
       000000f0 c1123760 c01ac597 c3f86360 c027e378 c020ef80 00000000 c3f86360 
       c3fa1f1c c3fa1f78 00000006 30544142 00000009 30504e50 00413043 00000000 
Call Trace: [<c01ac597>] [<c020ef80>] [<c01988e1>] [<c01a6187>] [<c01a5a13>] [<c020ea58>] [<c01a61d7>] 
       [<c01a60e0>] [<c01ac494>] [<c020f30e>] [<c01ac96c>] [<c020f30e>] [<c01ac494>] [<c020ea58>] [<c020fc22>] 
       [<c01adaf8>] [<c020fc1c>] [<c01adb12>] [<c01ac12f>] [<c020eb82>] [<c0220018>] [<c01074c3>] [<c01074cc>] 
Code: ac aa 84 c0 75 f7 f3 aa 8b 43 04 50 e8 4d ab f7 ff 31 c0 83 

>>EIP; c01ac476 <acpi_get_battery_info+14e/16c>   <=====
Trace; c01ac597 <acpi_found_cmbatt+103/16c>
Trace; c020ef80 <_acpi_ctype+3700/6a45>
Trace; c01988e1 <acpi_cm_execute_HID+75/80>
Trace; c01a6187 <acpi_ns_get_device_callback+a7/b4>
Trace; c01a5a13 <acpi_ns_walk_namespace+87/104>
Trace; c020ea58 <_acpi_ctype+31d8/6a45>
Trace; c01a61d7 <acpi_get_devices+43/6c>
Trace; c01a60e0 <acpi_ns_get_device_callback+0/b4>
Trace; c01ac494 <acpi_found_cmbatt+0/16c>
Trace; c020f30e <_acpi_ctype+3a8e/6a45>
Trace; c01ac96c <acpi_cmbatt_init+18/94>
Trace; c020f30e <_acpi_ctype+3a8e/6a45>
Trace; c01ac494 <acpi_found_cmbatt+0/16c>
Trace; c020ea58 <_acpi_ctype+31d8/6a45>
Trace; c020fc22 <_acpi_ctype+43a2/6a45>
Trace; c01adaf8 <acpi_power_init+40/60>
Trace; c020fc1c <_acpi_ctype+439c/6a45>
Trace; c01adb12 <acpi_power_init+5a/60>
Trace; c01ac12f <acpi_thread+eb/21c>
Trace; c020eb82 <_acpi_ctype+3302/6a45>
Trace; c0220018 <__ksymtab_arp_broken_ops+0/8>
Trace; c01074c3 <kernel_thread+1f/38>
Trace; c01074cc <kernel_thread+28/38>
Code;  c01ac476 <acpi_get_battery_info+14e/16c>
00000000 <_EIP>:
Code;  c01ac476 <acpi_get_battery_info+14e/16c>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  c01ac477 <acpi_get_battery_info+14f/16c>
   1:   aa                        stos   %al,%es:(%edi)
Code;  c01ac478 <acpi_get_battery_info+150/16c>
   2:   84 c0                     test   %al,%al
Code;  c01ac47a <acpi_get_battery_info+152/16c>
   4:   75 f7                     jne    fffffffd <_EIP+0xfffffffd> c01ac473 <acpi_get_battery_info+14b/16c>
Code;  c01ac47c <acpi_get_battery_info+154/16c>
   6:   f3 aa                     repz stos %al,%es:(%edi)
Code;  c01ac47e <acpi_get_battery_info+156/16c>
   8:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c01ac481 <acpi_get_battery_info+159/16c>
   b:   50                        push   %eax
Code;  c01ac482 <acpi_get_battery_info+15a/16c>
   c:   e8 4d ab f7 ff            call   fff7ab5e <_EIP+0xfff7ab5e> c0126fd4 <kfree+0/b0>
Code;  c01ac487 <acpi_get_battery_info+15f/16c>
  11:   31 c0                     xor    %eax,%eax
Code;  c01ac489 <acpi_get_battery_info+161/16c>
  13:   83 00 00                  addl   $0x0,(%eax)


--envbJBWh7q8WU6mo--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
