Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSG2PDQ>; Mon, 29 Jul 2002 11:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSG2PDQ>; Mon, 29 Jul 2002 11:03:16 -0400
Received: from mout0.freenet.de ([194.97.50.131]:33411 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S317473AbSG2PDP>;
	Mon, 29 Jul 2002 11:03:15 -0400
Date: Mon, 29 Jul 2002 17:06:34 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@austin.ibm.com>
Subject: 2.5.27: JFS oops
Message-ID: <20020729150634.GA661@prester.freenet.de>
Mail-Followup-To: JFS-Discussion <jfs-discussion@www-124.ibm.com>,
	linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

here goes another jfsCommit oops from kernel 2.5.27.

Distribution: Slackware 8.1
Kernel      : 2.5.27
JFS utils   : 1.0.20

Filesystems were created with jfs-utils 1.0.18 / kernel 2.4.18 by slackware
installation.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0184da8>]       Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000 ebx: c880a08c ecx: c7ea0800 edx: c7d5f668
esi: c7cee000 edi: 00000000 ebp: c880a080 esp: c7cee000
ds: 0018   es: 0018   ss: 0018
Stack: c7c7b86c 00000030 00001000 00000000 00000000 c7cee000 c7d5f65c
c7cee000
       c7cee000 00000000 c01924bb c7d5f65c c7d62b98 00000000 00038da8
00c2a128
       c7ea0800 c7d5f65c c6008000 00000030 00000000 00000001 00000000
00000030
Call Trace: [<c01924bb>] [<c019875f>] [<c0197fc0>] [<c01161e4>] [c0198c15>]
[<c0198ec4>] [<c0116350>] [<c0116350>] [<c0105000>] [<c0105000>]
[<c01057de>]
        [<c0198d10>]
Code: 89 50 04 8b 4c 24 44 89 5a 04 89 41 0c 8b 45 30 89 55 0c 89


>>EIP; c0184da8 <dbUpdatePMap+458/540>   <=====

>>ebx; c880a08c <_end+84d9ca8/85e5c1c>
>>ecx; c7ea0800 <_end+7b7041c/85e5c1c>
>>edx; c7d5f668 <_end+7a2f284/85e5c1c>
>>esi; c7cee000 <_end+79bdc1c/85e5c1c>
>>ebp; c880a080 <_end+84d9c9c/85e5c1c>
>>esp; c7cee000 <_end+79bdc1c/85e5c1c>

Trace; c01924bb <release_metapage+19b/270>
Trace; c019875f <txFreeMap+2ef/490>
Trace; c0197fc0 <txUpdateMap+100/370>
Trace; c01161e4 <schedule+1d4/300>
Trace; c0198ec4 <jfs_lazycommit+1b4/300>
Trace; c0116350 <default_wake_function+0/40>
Trace; c0116350 <default_wake_function+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01057de <kernel_thread+2e/40>
Trace; c0198d10 <jfs_lazycommit+0/300>

Code;  c0184da8 <dbUpdatePMap+458/540>
00000000 <_EIP>:
Code;  c0184da8 <dbUpdatePMap+458/540>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0184dab <dbUpdatePMap+45b/540>
   3:   8b 4c 24 44               mov    0x44(%esp,1),%ecx
Code;  c0184daf <dbUpdatePMap+45f/540>
   7:   89 5a 04                  mov    %ebx,0x4(%edx)
Code;  c0184db2 <dbUpdatePMap+462/540>
   a:   89 41 0c                  mov    %eax,0xc(%ecx)
Code;  c0184db5 <dbUpdatePMap+465/540>
   d:   8b 45 30                  mov    0x30(%ebp),%eax
Code;  c0184db8 <dbUpdatePMap+468/540>
  10:   89 55 0c                  mov    %edx,0xc(%ebp)
Code;  c0184dbb <dbUpdatePMap+46b/540>
  13:   89 00                     mov    %eax,(%eax)


Can I use jfs from cvs with current kernels (2.5.29/2.4.19-rc3-ac3) 
to see how latest changes work?

Best regards,
Axel Siebenwirth
