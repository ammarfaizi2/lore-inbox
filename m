Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTIIQog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264224AbTIIQog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:44:36 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:5978 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263497AbTIIQoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:44:32 -0400
From: kinarky <kinarky@free.fr>
Reply-To: kinarky@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re: crash log with 2.4.22 kernel and usb modem
Date: Tue, 9 Sep 2003 18:31:22 +0200
User-Agent: KMail/1.5.3
References: <200309090733.02884.kinarky@free.fr> <20030909151521.GB4499@kroah.com>
In-Reply-To: <20030909151521.GB4499@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309091831.22907.kinarky@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you using the userspace or kernel driver for the speedtouch modem?

	i am using the kernel driver speedtch

> And can you run that oops through ksymoops and send the output to us?
	
	i ran "ksymoops oopslogfile" while using the same kernel that i used with the 	
bug, i don't know exactly if it's what you expected. here's the output :

	ksymoops 2.4.9 on i686 2.4.22-6mdk.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-6mdk/ (default)
     -m /boot/System.map-2.4.22-6mdk (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module ext3 is in lsmod but not in ksyms, 
probabl
y no symbols exported
Sep  9 06:34:36 masteur kernel: kernel BUG at slab.c:815!
Sep  9 06:34:36 masteur kernel: invalid operand: 0000
Sep  9 06:34:36 masteur kernel: CPU:    0
Sep  9 06:34:36 masteur kernel: EIP:    0010:[kmem_cache_create+573/912]    
Tain
ted: P
Sep  9 06:34:36 masteur kernel: EIP:    0010:[<c01f69bd>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Sep  9 06:34:36 masteur kernel: EFLAGS: 00010246
Sep  9 06:34:36 masteur kernel: eax: 00000000   ebx: c184add4   ecx: c184acf4
edx: c184acf4
Sep  9 06:34:36 masteur kernel: esi: c184acee   edi: f0839dc8   ebp: c015d538
esp: d98cfee4
Sep  9 06:34:36 masteur kernel: ds: 0018   es: 0018   ss: 0018
Sep  9 06:34:36 masteur kernel: Process insmod (pid: 6338, stackpage=d98cf000)
Sep  9 06:34:36 masteur kernel: Stack: fffffffc 0000001c fffffff4 f083ad08 
00000
019 ffffffea f083986a f0839dba
Sep  9 06:34:36 masteur kernel:        0000003c 00000020 00000000 00000000 
00000
000 f0835000 c01d7b90 f083acfc
Sep  9 06:34:36 masteur kernel:        00000001 081419b8 00005c30 00000060 
00000
060 00000004 00000001 ef344bc0
Sep  9 06:34:36 masteur kernel: Call Trace:
Sep  9 06:34:37 masteur kernel:  [<f083ad08>] __ksymtab+0x0/0x28 [uhci]
Sep  9 06:34:37 masteur kernel:  [<f083986a>] uhci_hcd_init+0x6a/0xf0 [uhci]
Sep  9 06:34:37 masteur kernel:  [<f0839dba>] .rodata.str1.1+0x3e1/0x407 
[uhci]
Sep  9 06:34:37 masteur kernel:  [<c01d7b90>] sys_init_module+0x610/0x680 
[kerne                l]
Sep  9 06:34:37 masteur kernel:  [<f083acfc>] .kmodtab+0x0/0xc [uhci]
Sep  9 06:34:37 masteur kernel:  [<f0835060>] uhci_show_td+0x0/0x1a0 [uhci]
Sep  9 06:34:37 masteur kernel:  [<c01c3093>] system_call+0x33/0x40 [kernel]
Sep  9 06:34:37 masteur kernel: Code: 0f 0b 2f 03 6b b0 34 c0 8b 12 81 fa e4 
38                 10 c0 75 d3 8d 43


>>EIP; c01f69bd <kmem_cache_create+23d/390>   <=====

>>ebx; c184add4 <_end+1430cbb/303e7f47>
>>ecx; c184acf4 <_end+1430bdb/303e7f47>
>>edx; c184acf4 <_end+1430bdb/303e7f47>
>>esi; c184acee <_end+1430bd5/303e7f47>
>>edi; f0839dc8 <[uhci].text.end+3f0/11a8>
>>ebp; c015d538 <cache_chain_sem+0/10>
>>esp; d98cfee4 <_end+194b5dcb/303e7f47>

Trace; f083ad08 <[uhci]__module_license+4d/d25>
Trace; f083986a <[uhci]uhci_hcd_init+6a/f0>
Trace; f0839dba <[uhci].text.end+3e2/11a8>
Trace; c01d7b90 <sys_init_module+610/680>
Trace; f083acfc <[uhci]__module_license+41/d25>
Trace; f0835060 <[uhci]uhci_show_td+0/1a0>
Trace; c01c3093 <system_call+33/40>

Code;  c01f69bd <kmem_cache_create+23d/390>
00000000 <_EIP>:
Code;  c01f69bd <kmem_cache_create+23d/390>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01f69bf <kmem_cache_create+23f/390>
   2:   2f                        das
Code;  c01f69c0 <kmem_cache_create+240/390>
   3:   03 6b b0                  add    0xffffffb0(%ebx),%ebp
Code;  c01f69c3 <kmem_cache_create+243/390>
   6:   34 c0                     xor    $0xc0,%al
Code;  c01f69c5 <kmem_cache_create+245/390>
   8:   8b 12                     mov    (%edx),%edx
Code;  c01f69c7 <kmem_cache_create+247/390>
   a:   81 fa e4 38 10 c0         cmp    $0xc01038e4,%edx
Code;  c01f69cd <kmem_cache_create+24d/390>
  10:   75 d3                     jne    ffffffe5 <_EIP+0xffffffe5>
Code;  c01f69cf <kmem_cache_create+24f/390>
  12:   8d 43 00                  lea    0x0(%ebx),%eax


2 warnings issued.  Results may not be reliable.

