Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUEHV2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUEHV2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 17:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbUEHV2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 17:28:01 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:22669 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S264164AbUEHV1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 17:27:46 -0400
Message-ID: <409D50AE.2020908@superonline.com>
Date: Sun, 09 May 2004 00:27:10 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: len.brown@intel.com
Subject: OOPS :  2.4.27-pre2 + latest ACPI
Content-Type: multipart/mixed;
 boundary="------------040906010909060507000106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040906010909060507000106
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

Hi Len, all:

Vanilla 2.4.27-pre2 + acpi-20040326-2.4.27.diff.gz (dated May 06) from
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.27/

Decoded oops below, gzipped config and dmesg attached.

Regards;
Özkan Sezer

--------------040906010909060507000106
Content-Type: text/plain;
 name="ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.txt"

ksymoops 2.4.5 on i686 2.4.27-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27-pre2/ (default)
     -m /boot/System.map-2.4.27-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/floppy.o) for floppy
Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (map_ksym_to_module): cannot match loaded module floppy to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
May  9 00:13:46 p733 kernel: Unable to handle kernel paging request at virtual address 5a5a5a5a
May  9 00:13:46 p733 kernel: c01a575a
May  9 00:13:46 p733 kernel: *pde = 00000000
May  9 00:13:46 p733 kernel: Oops: 0000
May  9 00:13:46 p733 kernel: CPU:    0
May  9 00:13:46 p733 kernel: EIP:    0010:[<c01a575a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May  9 00:13:46 p733 kernel: EFLAGS: 00010246
May  9 00:13:46 p733 kernel: eax: 00000000   ebx: 5a5a5a5a   ecx: 00000000   edx: 00000006
May  9 00:13:46 p733 kernel: esi: 00000000   edi: ddc69e9c   ebp: ddc69e90   esp: ddc69e8c
May  9 00:13:46 p733 kernel: ds: 0018   es: 0018   ss: 0018
May  9 00:13:46 p733 kernel: Process modprobe (pid: 2066, stackpage=ddc69000)
May  9 00:13:46 p733 kernel: Stack: df651a8c ddc69eb8 c0196144 5a5a5a5a 00000004 c028413e c0284100 00200000 
May  9 00:13:46 p733 kernel:        df651a8c ddc69ecc dfff0800 ddc69ee8 e0ae293a 5a5a5a5a 00000001 e0ae245d 
May  9 00:13:46 p733 kernel:        00080000 e0ae2c9f e0ae2abc 00000473 dfff0800 dfff0800 e0ae3340 ddc69f14 
May  9 00:13:46 p733 kernel: Call Trace:    [<c0196144>] [<e0ae293a>] [<e0ae245d>] [<e0ae2c9f>] [<e0ae2abc>]
May  9 00:13:46 p733 kernel:   [<e0ae3340>] [<c01b5a3f>] [<c01b59ab>] [<c01b5339>] [<e0ae3340>] [<e0ae3340>]
May  9 00:13:46 p733 kernel:   [<c01b5cca>] [<c01b59ab>] [<e0ae3340>] [<e0ae2a84>] [<e0ae3340>] [<e0ae2cc3>]
May  9 00:13:46 p733 kernel:   [<e0ae2abc>] [<c012051a>] [<c011f889>] [<c0108ea7>]
May  9 00:13:46 p733 kernel: Code: 80 3b 0f 0f 44 c3 5b 5d c3 a1 94 c0 32 c0 eb f6 55 89 e5 8b 


>>EIP; c01a575a <acpi_ns_map_handle_to_node+19/29>   <=====

>>ebx; 5a5a5a5a Before first symbol
>>edi; ddc69e9c <_end+1d919018/206911dc>
>>ebp; ddc69e90 <_end+1d91900c/206911dc>
>>esp; ddc69e8c <_end+1d919008/206911dc>

Trace; c0196144 <acpi_remove_notify_handler+87/18e>
Trace; e0ae293a <[button]acpi_button_remove+78/d4>
Trace; e0ae245d <[button]acpi_button_notify+0/94>
Trace; e0ae2c9f <[button].text.end+1e4/2e5>
Trace; e0ae2abc <[button].text.end+1/2e5>
Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
Trace; c01b5a3f <acpi_bus_unattach+94/11f>
Trace; c01b59ab <acpi_bus_unattach+0/11f>
Trace; c01b5339 <acpi_bus_walk+a3/cf>
Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
Trace; c01b5cca <acpi_bus_unregister_driver+4c/d1>
Trace; c01b59ab <acpi_bus_unattach+0/11f>
Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
Trace; e0ae2a84 <[button]acpi_button_exit+49/80>
Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
Trace; e0ae2cc3 <[button].text.end+208/2e5>
Trace; e0ae2abc <[button].text.end+1/2e5>
Trace; c012051a <free_module+ba/d0>
Trace; c011f889 <sys_delete_module+a9/1e0>
Trace; c0108ea7 <system_call+33/38>

Code;  c01a575a <acpi_ns_map_handle_to_node+19/29>
00000000 <_EIP>:
Code;  c01a575a <acpi_ns_map_handle_to_node+19/29>   <=====
   0:   80 3b 0f                  cmpb   $0xf,(%ebx)   <=====
Code;  c01a575d <acpi_ns_map_handle_to_node+1c/29>
   3:   0f 44 c3                  cmove  %ebx,%eax
Code;  c01a5760 <acpi_ns_map_handle_to_node+1f/29>
   6:   5b                        pop    %ebx
Code;  c01a5761 <acpi_ns_map_handle_to_node+20/29>
   7:   5d                        pop    %ebp
Code;  c01a5762 <acpi_ns_map_handle_to_node+21/29>
   8:   c3                        ret    
Code;  c01a5763 <acpi_ns_map_handle_to_node+22/29>
   9:   a1 94 c0 32 c0            mov    0xc032c094,%eax
Code;  c01a5768 <acpi_ns_map_handle_to_node+27/29>
   e:   eb f6                     jmp    6 <_EIP+0x6>
Code;  c01a576a <acpi_ns_convert_entry_to_handle+0/8>
  10:   55                        push   %ebp
Code;  c01a576b <acpi_ns_convert_entry_to_handle+1/8>
  11:   89 e5                     mov    %esp,%ebp
Code;  c01a576d <acpi_ns_convert_entry_to_handle+3/8>
  13:   8b 00                     mov    (%eax),%eax


3 warnings and 3 errors issued.  Results may not be reliable.

--------------040906010909060507000106
Content-Type: application/x-gzip;
 name="dmesg.out.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.out.gz"

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
VJ2fW51/ySymrv0fxjtdt9MoAAA=
--------------040906010909060507000106
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
ynA9DV6JvkIsW/r/Ac1teivhegAA
--------------040906010909060507000106--

