Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTKAIcI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 03:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTKAIcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 03:32:08 -0500
Received: from s4.uklinux.net ([80.84.72.14]:18326 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S262745AbTKAIcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 03:32:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16291.28455.449954.812498@titan.home.hindley.uklinux.net>
Date: Sat, 1 Nov 2003 08:30:31 +0000
X-MailScanner-Titan: Found to be clean, Found to be clean
From: Mark Hindley <mark@hindley.uklinux.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.3.7 on i586 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map (specified)
     -1

Got this oops last night. Seemed to happen when htdig ran to update
its index and used lots of memory

Box is AMD K6. TX MB. 64MB SDRAM. 2 partition swapfiles

Let me know if you need any more info./

Mark

Nov  1 03:07:33 titan kernel: c013c4e0
Nov  1 03:07:33 titan kernel: Oops: 0002
Nov  1 03:07:33 titan kernel: CPU:    0
Nov  1 03:07:33 titan kernel: EIP:    0010:[d_lookup+176/256]    Not tainted
Nov  1 03:07:33 titan kernel: EFLAGS: 00010246
Nov  1 03:07:33 titan kernel: eax: 00000000   ebx: c3cdc1e0   ecx: 0000000d   edx: 00000003
Nov  1 03:07:33 titan kernel: esi: c3cdc23c   edi: c2ad5001   ebp: c10f8220   esp: c3955ed0
Nov  1 03:07:33 titan kernel: ds: 0018   es: 0018   ss: 0018
Nov  1 03:07:33 titan kernel: Process htdig (pid: 16342, stackpage=c3955000)
Nov  1 03:07:33 titan kernel: Stack: c3955f30 00000000 c3955f8c c117d880 c10f8220 c2ad5001 0029ab98 00000003 
Nov  1 03:07:33 titan kernel:        c0134272 c10ec7a0 c3955f30 c3955f30 c01346bf c10ec7a0 c3955f30 00000004 
Nov  1 03:07:33 titan kernel:        c3955f8c c2ad5000 00000000 00000442 00000400 00000010 c2ad5005 00000000 
Nov  1 03:07:33 titan kernel: Call Trace:    [cached_lookup+14/80] [link_path_walk+599/2084] [path_walk+26/28] [path_lookup+27/36] [open_namei+129/1212]
Nov  1 03:07:33 titan kernel: Code: 89 d1 fc a8 00 f3 a6 75 2f ff 03 8b 03 83 f8 01 75 1e ff 0d 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 d1                     mov    %edx,%ecx
Code;  00000002 Before first symbol
   2:   fc                        cld    
Code;  00000003 Before first symbol
   3:   a8 00                     test   $0x0,%al
Code;  00000005 Before first symbol
   5:   f3 a6                     repz cmpsb %es:(%edi),%ds:(%esi)
Code;  00000007 Before first symbol
   7:   75 2f                     jne    38 <_EIP+0x38>
Code;  00000009 Before first symbol
   9:   ff 03                     incl   (%ebx)
Code;  0000000b Before first symbol
   b:   8b 03                     mov    (%ebx),%eax
Code;  0000000d Before first symbol
   d:   83 f8 01                  cmp    $0x1,%eax
Code;  00000010 Before first symbol
  10:   75 1e                     jne    30 <_EIP+0x30>
Code;  00000012 Before first symbol
  12:   ff 0d 00 00 00 00         decl   0x0


