Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S288255AbSAMWu7>; Sun, 13 Jan 2002 17:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S288256AbSAMWut>; Sun, 13 Jan 2002 17:50:49 -0500
Received: from ti200710a082-0716.bb.online.no ([148.122.10.204]:6404 "EHLO empire.e") by vger.kernel.org with ESMTP id <S288255AbSAMWuf>; Sun, 13 Jan 2002 17:50:35 -0500
Message-ID: <3C420F33.20506@freenix.no>
Date: Sun, 13 Jan 2002 23:50:27 +0100
From: frode <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020111
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.17 Ooops!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed someone having 2.4.17 oops in 
<http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.1/0809.html>,
in process 'kswapd'.

I get similar oopses as well on a k7 750mhz with 384mb ram.
The process 'kswapd' was listed as defunct, but the system seemed to 
work - at least well enough for me to do a clean 'shutdown -r now'...

---- 8< ----
Jan 12 16:45:28 kingdom kernel: Unable to handle kernel paging request 
at virtual address 16a1842f
Jan 12 16:45:28 kingdom kernel: c01447e8
Jan 12 16:45:28 kingdom kernel: *pde = 00000000
Jan 12 16:45:28 kingdom kernel: Oops: 0000
Jan 12 16:45:28 kingdom kernel: CPU:    0
Jan 12 16:45:28 kingdom kernel: EIP:    0010:[iput+56/512]    Tainted: P
Jan 12 16:45:28 kingdom kernel: EFLAGS: 00010206
Jan 12 16:45:28 kingdom kernel: eax: 00000000   ebx: cd4ff700   ecx: 
cdcff710   edx: cdcff710
Jan 12 16:45:28 kingdom kernel: esi: 16a1840f   edi: 00000000   ebp: 
000000d1   esp: c1635f4c
Jan 12 16:45:28 kingdom kernel: ds: 0018   es: 0018   ss: 0018
Jan 12 16:45:28 kingdom kernel: Process kswapd (pid: 5, stackpage=c1635000)
Jan 12 16:45:28 kingdom kernel: Stack: cdd01458 cdd01440 cd4ff700 
c0142746 cd4ff700 00000013 000001d0 00000020
Jan 12 16:45:28 kingdom kernel:        00000006 c0142a1b 0000015c 
c012bfa6 00000006 000001d0 00000006 000001d0
Jan 12 16:45:28 kingdom kernel:        c02fa048 00000000 c02fa048 
c012c00c 00000020 c02fa048 00000001 c1634000
Jan 12 16:45:28 kingdom kernel: Call Trace: [prune_dcache+214/336] 
[shrink_dcache_memory+27/64] [shrink_caches+102/144] [try_to_free_p
ages+60/96] [kswapd_balance_pgdat+67/144]
Jan 12 16:45:28 kingdom kernel: Code: 8b 7e 20 85 ff 74 0d 8b 47 10 85 
c0 74 06 53 ff d0 83 c4 04
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 7e 20                  mov    0x20(%esi),%edi
Code;  00000002 Before first symbol
    3:   85 ff                     test   %edi,%edi
Code;  00000004 Before first symbol
    5:   74 0d                     je     14 <_EIP+0x14> 00000014 Before 
first symbol
Code;  00000006 Before first symbol
    7:   8b 47 10                  mov    0x10(%edi),%eax
Code;  0000000a Before first symbol
    a:   85 c0                     test   %eax,%eax
Code;  0000000c Before first symbol
    c:   74 06                     je     14 <_EIP+0x14> 00000014 Before 
first symbol
Code;  0000000e Before first symbol
    e:   53                        push   %ebx
Code;  0000000e Before first symbol
    f:   ff d0                     call   *%eax
Code;  00000010 Before first symbol
   11:   83 c4 04                  add    $0x4,%esp

---- 8< ----


