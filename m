Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317668AbSHCS37>; Sat, 3 Aug 2002 14:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317675AbSHCS37>; Sat, 3 Aug 2002 14:29:59 -0400
Received: from mout0.freenet.de ([194.97.50.131]:32427 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S317668AbSHCS34>;
	Sat, 3 Aug 2002 14:29:56 -0400
Date: Sat, 3 Aug 2002 20:33:20 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.30: kernel BUG at slab.c:1290!
Message-ID: <20020803183320.GA283@prester.freenet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

following oops occured during normal operation.
Gzipped .config attached.

kernel BUG at slab.c:1290!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0136e31>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013
eax: cb840fff   ebx: cb840c00   ecx: cb840c00   edx: 00012800
esi: c11e36f8   edi: 00000400   ebp: 00000000   esp: c8323e7c
ds: 0018   es: 0018   ss: 0018
Stack: 0000007b 00000400 cb840c00 00000246 c11e36f8 c11e3700 000001d0
c0136b2a
       c11e36f8 cbadb614 000000ff fffffff4 c98913cc 00000100 c015a261
c11e36f8
       000001d0 c015a332 00000100 c11e20c8 000001d0 00000246 c11e20c0
c9891040
Call Trace: [<c0136b2a>] [<c015a261>] [<c015a332>] [<c0118449>] [<c0117dd3>]
   [<c0118911>] [<c0122aaa>] [<c0122866>] [<c01233d0>] [<c0118d0f>]
[<c0141f57>]
   [<c0105cd7>] [<c010762f>]
Code: 0f 0b 0a 05 aa eb 27 c0 81 e2 00 04 00 00 74 37 b8 a5 c2 0f


>>EIP; c0136e31 <kmem_cache_alloc_one_tail+a1/113>   <=====

>>eax; cb840fff <_end+b510a5b/c5e5a5c>
>>ebx; cb840c00 <_end+b51065c/c5e5a5c>
>>ecx; cb840c00 <_end+b51065c/c5e5a5c>
>>esi; c11e36f8 <_end+eb3154/c5e5a5c>
>>esp; c8323e7c <_end+7ff38d8/c5e5a5c>

Trace; c0136b2a <__kmem_cache_alloc+4a/b0>
Trace; c015a261 <alloc_fd_array+21/30>
Trace; c015a332 <expand_fd_array+72/190>
Trace; c0118449 <copy_files+129/300>
Trace; c0117dd3 <dup_task_struct+43/b0>
Trace; c0118911 <copy_process+2f1/6c0>
Trace; c0122aaa <do_timer+7a/80>
Trace; c0122866 <update_wall_time+16/40>
Trace; c01233d0 <update_times+f0/100>
Trace; c0118d0f <do_fork+2f/c0>
Trace; c0141f57 <sys_llseek+d7/f0>
Trace; c0105cd7 <sys_fork+27/40>
Trace; c010762f <syscall_call+7/b>

Code;  c0136e31 <kmem_cache_alloc_one_tail+a1/113>
00000000 <_EIP>:
Code;  c0136e31 <kmem_cache_alloc_one_tail+a1/113>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0136e33 <kmem_cache_alloc_one_tail+a3/113>
   2:   0a 05 aa eb 27 c0         or     0xc027ebaa,%al
Code;  c0136e39 <kmem_cache_alloc_one_tail+a9/113>
   8:   81 e2 00 04 00 00         and    $0x400,%edx
Code;  c0136e3f <kmem_cache_alloc_one_tail+af/113>
   e:   74 37                     je     47 <_EIP+0x47> c0136e78
<kmem_cache_alloc_one_tail+e8/113>
Code;  c0136e41 <kmem_cache_alloc_one_tail+b1/113>
  10:   b8 a5 c2 0f 00            mov    $0xfc2a5,%eax


Regards,
Axel Siebenwirth

--T4sUOijqQbZv57TR
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config-2.5.30.gz"
Content-Transfer-Encoding: base64

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

--T4sUOijqQbZv57TR--
