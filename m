Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTETPIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTETPIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:08:05 -0400
Received: from pcp02462394pcs.chrchv01.md.comcast.net ([68.33.20.149]:31493
	"EHLO mail.jettisonnetworks.com") by vger.kernel.org with ESMTP
	id S263844AbTETPIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:08:02 -0400
From: "David Lewis" <dlewis@vnxsolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: Third  OOPS report and ksymoops output 2.4.20
Date: Tue, 20 May 2003 11:20:58 -0400
Message-ID: <EMEOIBCHEHCPNABJGHGOEEHOCNAA.dlewis@vnxsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <EMEOIBCHEHCPNABJGHGOGEFPCNAA.dlewis@vnxsolutions.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another one from the same machine. If this is not the place to be
posting these please let me know. The list FAQ indicated that posting these
is appropriate, but I have not seen any responses which leads me to believe
that it is not the correct place.

ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May 20 09:45:47 nicebox kernel: Unable to handle kernel paging request at
virtual address 292b2b34
May 20 09:45:47 nicebox kernel: c013593c
May 20 09:45:47 nicebox kernel: *pde = 00000000
May 20 09:45:47 nicebox kernel: Oops: 0002
May 20 09:45:47 nicebox kernel: CPU:    1
May 20 09:45:47 nicebox kernel: EIP:    0010:[<c013593c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May 20 09:45:47 nicebox kernel: EFLAGS: 00210056
May 20 09:45:47 nicebox kernel: eax: c1573088   ebx: c775a100   ecx:
c775a000   edx: 292b2b30
May 20 09:45:47 nicebox kernel: esi: 00000008   edi: 00000075   ebp:
c1573080   esp: d6097f1c
May 20 09:45:47 nicebox kernel: ds: 0018   es: 0018   ss: 0018
May 20 09:45:47 nicebox kernel: Process ffnext (pid: 1911,
stackpage=d6097000)
May 20 09:45:47 nicebox kernel: Stack: c1573088 c1573090 c1573080 00200246
000001f0 bfff8f5c c01365bb c1573080
May 20 09:45:47 nicebox kernel:        df6d7400 000001f0 fffffff4 00000001
d6096000 bfff8f5c c0150b7c c1573080
May 20 09:45:47 nicebox kernel:        000001f0 c0150c92 00000004 cde6d300
40980000 409f1000 dbd97580 409f1000
May 20 09:45:47 nicebox kernel: Call Trace:    [<c01365bb>] [<c0150b7c>]
[<c0150c92>] [<c012e173>] [<c010770f>]
May 20 09:45:47 nicebox kernel: Code: 89 42 04 8b 45 00 89 48 04 89 01 89 69
04 89 4d 00 eb b1 8b


>>EIP; c013593c <kmem_cache_alloc_batch+9c/e0>   <=====

>>eax; c1573088 <_end+120cb30/1fea4b08>
>>ebx; c775a100 <_end+73f3ba8/1fea4b08>
>>ecx; c775a000 <_end+73f3aa8/1fea4b08>
>>edx; 292b2b30 Before first symbol
>>ebp; c1573080 <_end+120cb28/1fea4b08>
>>esp; d6097f1c <_end+15d319c4/1fea4b08>

Trace; c01365bb <__kmem_cache_alloc+5b/140>
Trace; c0150b7c <select_bits_alloc+1c/20>
Trace; c0150c92 <sys_select+102/4e0>
Trace; c012e173 <sys_munmap+43/70>
Trace; c010770f <system_call+33/38>

Code;  c013593c <kmem_cache_alloc_batch+9c/e0>
00000000 <_EIP>:
Code;  c013593c <kmem_cache_alloc_batch+9c/e0>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c013593f <kmem_cache_alloc_batch+9f/e0>
   3:   8b 45 00                  mov    0x0(%ebp),%eax
Code;  c0135942 <kmem_cache_alloc_batch+a2/e0>
   6:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0135945 <kmem_cache_alloc_batch+a5/e0>
   9:   89 01                     mov    %eax,(%ecx)
Code;  c0135947 <kmem_cache_alloc_batch+a7/e0>
   b:   89 69 04                  mov    %ebp,0x4(%ecx)
Code;  c013594a <kmem_cache_alloc_batch+aa/e0>
   e:   89 4d 00                  mov    %ecx,0x0(%ebp)
Code;  c013594d <kmem_cache_alloc_batch+ad/e0>
  11:   eb b1                     jmp    ffffffc4 <_EIP+0xffffffc4>
Code;  c013594f <kmem_cache_alloc_batch+af/e0>
  13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.

David Lewis
Senior Security Engineer
VNX Solutions, Inc <http://www.vnxsolutions.com>
dlewis@vnxsolutions.com <mailto:dlewis@vnxsolutions.com>
410-459-7428 Cell



