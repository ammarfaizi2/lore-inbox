Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTFYJVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 05:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTFYJVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 05:21:39 -0400
Received: from asterix-ether.oma.be ([193.190.249.240]:64775 "EHLO
	asterix.oma.be") by vger.kernel.org with ESMTP id S262465AbTFYJVe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 05:21:34 -0400
From: Luis Gonzalez <luis.gonzalez@oma.be>
Organization: RMIB
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.20 and rsync
Date: Wed, 25 Jun 2003 11:35:43 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306251135.43313.luis.gonzalez@oma.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened when using rsync:

> /usr/bin/rsync  -a --delete --ignore-errors -v rsync://tornado/gerb     
/typhoon/gerb

the rsync is done between two computers tornado (Compaq Alpha OSF1) and 
typhoon (Intel 2.4 Ghz).

typhoon kernel: Linux version 2.4.20-4GB (root@Pentium.suse.de) (gcc version 
3.3 20030226 (prerelease) (SuSE Linux)) #1 Mon Mar 17 10:51:11 UTC 2003

feel free to ask any additionnal information to  luis.gonzalez@oma.be

Log (ksymoops follows):

Jun 24 13:05:39 typhoon kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Jun 24 13:05:39 typhoon kernel:  printing eip:
Jun 24 13:05:39 typhoon kernel: c0157950
Jun 24 13:05:39 typhoon kernel: *pde = 00000000
Jun 24 13:05:39 typhoon kernel: Oops: 0000 2.4.20-4GB #1 Mon Mar 17 10:51:11 
UTC 2003
Jun 24 13:05:39 typhoon kernel: CPU:    0
Jun 24 13:05:39 typhoon kernel: EIP:    0010:[d_lookup+96/240]    Not tainted
Jun 24 13:05:39 typhoon kernel: EFLAGS: 00010203
Jun 24 13:05:39 typhoon kernel: eax: 00000000   ebx: 00000000   ecx: 00000011   
edx: c1f00000
Jun 24 13:05:39 typhoon kernel: esi: d864601c   edi: 26478a83   ebp: fffffff0   
esp: ebb01efc
Jun 24 13:05:39 typhoon kernel: ds: 0018   es: 0018   ss: 0018
Jun 24 13:05:39 typhoon kernel: Process rsync (pid: 2829, stackpage=ebb01000)
Jun 24 13:05:39 typhoon kernel: Stack: c1f99de0 26478a83 00000064 d864601c 
00000017 ebb01f50 26478a83 d8646033 
Jun 24 13:05:39 typhoon kernel:        ebb01f98 c014e980 e3b35160 ebb01f50 
26478a83 c014f056 e3b35160 ebb01f50 
Jun 24 13:05:39 typhoon kernel:        00000000 00000008 00000000 e3b36bc0 
00000000 d864601c 00000017 26478a83 
Jun 24 13:05:39 typhoon kernel: Call Trace:    [cached_lookup+16/96] 
[link_path_walk+1222/2208] [getname+74/176] [path_lookup+33/48] 
[__user_walk+42/80]
Jun 24 13:05:39 typhoon kernel:   [sys_lstat64+23/112] [system_call+51/64]
Jun 24 13:05:39 typhoon kernel: Code: 8b 1b 39 7d 44 75 eb 8b 44 24 28 39 45 
0c 75 e2 8b 40 4c 85 
Jun 24 13:18:22 typhoon kernel:  <1>Unable to handle kernel paging request at 
virtual address 00004000
Jun 24 13:18:22 typhoon kernel:  printing eip:
Jun 24 13:18:22 typhoon kernel: c256a0ee
Jun 24 13:18:22 typhoon kernel: *pde = 00000000
Jun 24 13:18:22 typhoon kernel: Oops: 0002 2.4.20-4GB #1 Mon Mar 17 10:51:11 
UTC 2003
Jun 24 13:18:22 typhoon kernel: CPU:    0
Jun 24 13:18:22 typhoon kernel: EIP:    
0010:[joydev:__insmod_joydev_O/lib/modules/2.4.20-4GB/kernel/drivers/inp+-2875154/96]    
Not tainted
Jun 24 13:18:22 typhoon kernel: EFLAGS: 00010206
Jun 24 13:18:22 typhoon kernel: eax: c0462001   ebx: ed6677e0   ecx: 00004000   
edx: ed667801
Jun 24 13:18:22 typhoon kernel: esi: c1ca7fa0   edi: c02d9bc0   ebp: 00000003   
esp: c1ca7f74
Jun 24 13:18:22 typhoon kernel: ds: 0018   es: 0018   ss: 0018
Jun 24 13:18:22 typhoon kernel: Process kinoded (pid: 7, stackpage=c1ca7000)
Jun 24 13:18:22 typhoon kernel: Stack: ed6677e0 c0158ea1 ed6677e0 ed6677e0 
c0158ef7 ed6677e0 00000000 00000340 
Jun 24 13:18:22 typhoon kernel:        c0159238 c1ca7fa0 00006058 ed667608 
f207a4a8 ffffe000 00006398 c1ca6000 
Jun 24 13:18:22 typhoon kernel:        c1ca6000 c0159a70 00000340 00000000 
c1ca6000 00000000 00000000 00000000 
Jun 24 13:18:22 typhoon kernel: Call Trace:    [clear_inode+161/224] 
[dispose_list+23/160] [_prune_icache+312/464] [kinoded+160/288] 
[rest_init+0/32]
Jun 24 13:18:22 typhoon kernel:   [rest_init+0/32] [kernel_thread+35/48] 
[kinoded+0/288]
Jun 24 13:18:22 typhoon kernel: Modules: [(ext3:<c2560060>:<c2572e08>)]
Jun 24 13:18:22 typhoon kernel: Code: ff 09 0f 94 c0 84 c0 75 15 c7 83 7c 01 
00 00 ff ff ff ff 5b 

ksymoops:

ksymoops 2.4.3 on i686 2.4.20-4GB.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-4GB/ (default)
     -m /boot/System.map-2.4.20-4GB (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_driver_target not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_driver_target_l not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_governor_l not found 
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_notify_transition 
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_parse_governor not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_register_driver not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_register_governor 
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_restore not found in 
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_unregister_driver 
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_unregister_governor 
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_build_dmatable not found 
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_destroy_dmatable not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_dma_intr not found in 
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_get_best_pio_mode not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_register_driver not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_unregister_driver 
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pio_timings not found in 
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_set_xfer_rate not found 
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_dma not found in 
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_device not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_devices not 
found in System.map.  Ignoring ksyms_base entry
Oops: 0000 2.4.20-4GB #1 Mon Mar 17 10:51:11 UTC 2003
CPU:    0
EIP:    0010:[d_lookup+96/240]    Not tainted
EFLAGS: 00010203
eax: 00000000   ebx: 00000000   ecx: 00000011   edx: c1f00000
esi: d864601c   edi: 26478a83   ebp: fffffff0   esp: ebb01efc
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 2829, stackpage=ebb01000)
Stack: c1f99de0 26478a83 00000064 d864601c 00000017 ebb01f50 26478a83 d8646033
       ebb01f98 c014e980 e3b35160 ebb01f50 26478a83 c014f056 e3b35160 ebb01f50
       00000000 00000008 00000000 e3b36bc0 00000000 d864601c 00000017 26478a83
Call Trace:    [cached_lookup+16/96] [link_path_walk+1222/2208] 
[getname+74/176] [path_lookup+33/48] [__user_walk+42/80]
Code: 8b 1b 39 7d 44 75 eb 8b 44 24 28 39 45 0c 75 e2 8b 40 4c 85
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 1b                     mov    (%ebx),%ebx
Code;  00000002 Before first symbol
   2:   39 7d 44                  cmp    %edi,0x44(%ebp)
Code;  00000004 Before first symbol
   5:   75 eb                     jne    fffffff2 <_EIP+0xfffffff2> fffffff2 
<END_OF_CODE+3c8c8774/????>
Code;  00000006 Before first symbol
   7:   8b 44 24 28               mov    0x28(%esp,1),%eax
Code;  0000000a Before first symbol
   b:   39 45 0c                  cmp    %eax,0xc(%ebp)
Code;  0000000e Before first symbol
   e:   75 e2                     jne    fffffff2 <_EIP+0xfffffff2> fffffff2 
<END_OF_CODE+3c8c8774/????>
Code;  00000010 Before first symbol
  10:   8b 40 4c                  mov    0x4c(%eax),%eax
Code;  00000012 Before first symbol
  13:   85 00                     test   %eax,(%eax)

 <1>Unable to handle kernel paging request at virtual address 00004000
c256a0ee
*pde = 00000000
Oops: 0002 2.4.20-4GB #1 Mon Mar 17 10:51:11 UTC 2003
CPU:    0
EIP:    
0010:[joydev:__insmod_joydev_O/lib/modules/2.4.20-4GB/kernel/drivers/inp+-2875154/96]    
Not tainted
EFLAGS: 00010206
eax: c0462001   ebx: ed6677e0   ecx: 00004000   edx: ed667801
esi: c1ca7fa0   edi: c02d9bc0   ebp: 00000003   esp: c1ca7f74
ds: 0018   es: 0018   ss: 0018
Process kinoded (pid: 7, stackpage=c1ca7000)
Stack: ed6677e0 c0158ea1 ed6677e0 ed6677e0 c0158ef7 ed6677e0 00000000 00000340
       c0159238 c1ca7fa0 00006058 ed667608 f207a4a8 ffffe000 00006398 c1ca6000
       c1ca6000 c0159a70 00000340 00000000 c1ca6000 00000000 00000000 00000000
Call Trace:    [clear_inode+161/224] [dispose_list+23/160] 
[_prune_icache+312/464] [kinoded+160/288] [rest_init+0/32]
Code: ff 09 0f 94 c0 84 c0 75 15 c7 83 7c 01 00 00 ff ff ff ff 5b

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 09                     decl   (%ecx)
Code;  00000002 Before first symbol
   2:   0f 94 c0                  sete   %al
Code;  00000004 Before first symbol
   5:   84 c0                     test   %al,%al
Code;  00000006 Before first symbol
   7:   75 15                     jne    1e <_EIP+0x1e> 0000001e Before first 
symbol
Code;  00000008 Before first symbol
   9:   c7 83 7c 01 00 00 ff      movl   $0xffffffff,0x17c(%ebx)
Code;  00000010 Before first symbol
  10:   ff ff ff
Code;  00000012 Before first symbol
  13:   5b                        pop    %ebx


22 warnings issued.  Results may not be reliable.

-- 
-------------------------------------------------
Luis Gonzalez

Section télédétection depuis l'espace
Département observations
Institut Royal Météorologique de Belgique,
Avenue Circulaire 3, 1180 Uccle, Belgium.

phone        : + 32 2373 06 99  
fax          : + 32 2374 67 88
e-mail : Luis.Gonzalez@oma.be
www: http://gerb.oma.be/
------------------------------------------------

