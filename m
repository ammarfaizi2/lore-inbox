Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281212AbRKEQ2S>; Mon, 5 Nov 2001 11:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281211AbRKEQ2J>; Mon, 5 Nov 2001 11:28:09 -0500
Received: from [203.177.34.73] ([203.177.34.73]:25582 "EHLO
	maravillo.q-linux.com") by vger.kernel.org with ESMTP
	id <S281212AbRKEQ15>; Mon, 5 Nov 2001 11:27:57 -0500
Date: Tue, 6 Nov 2001 00:25:04 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac6: kmem_cache_reap oops!
Message-ID: <20011106002504.A6804@maravillo.q-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Q Linux Solutions, Inc.
X-Accepted-File-Formats: ASCII .rtf .ps - *NO* MS Office files please
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0128720
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0128720>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c1427760
esi: 0000005a   edi: c14277c0   ebp: 00000009   esp: c14c1fac
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c14c1000)
Stack: c1427750 00000002 00000002 000066f9 000000c0 00000000 0008e000 c012a1b5 
       000000c0 00000006 000000c0 c012a227 000000c0 00000000 00010f00 c1439fb8 
       c0105000 c01054f6 00000000 c012a1c0 c024dfd8 
Call Trace: [<c012a1b5>] [<c012a227>] [<c0105000>] [<c01054f6>] [<c012a1c0>] 
Code: 8b 48 10 85 c9 74 02 0f 0b 8b 00 46 39 d0 75 f0 8b 04 24 89 

>>EIP; c0128720 <kmem_cache_reap+d0/1c0>   <=====
Trace; c012a1b5 <do_try_to_free_pages+45/50>
Trace; c012a227 <kswapd+67/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01054f6 <kernel_thread+26/30>
Trace; c012a1c0 <kswapd+0/c0>
Code;  c0128720 <kmem_cache_reap+d0/1c0>
00000000 <_EIP>:
Code;  c0128720 <kmem_cache_reap+d0/1c0>   <=====
   0:   8b 48 10                  mov    0x10(%eax),%ecx   <=====
Code;  c0128723 <kmem_cache_reap+d3/1c0>
   3:   85 c9                     test   %ecx,%ecx
Code;  c0128725 <kmem_cache_reap+d5/1c0>
   5:   74 02                     je     9 <_EIP+0x9> c0128729 <kmem_cache_reap+d9/1c0>
Code;  c0128727 <kmem_cache_reap+d7/1c0>
   7:   0f 0b                     ud2a   
Code;  c0128729 <kmem_cache_reap+d9/1c0>
   9:   8b 00                     mov    (%eax),%eax
Code;  c012872b <kmem_cache_reap+db/1c0>
   b:   46                        inc    %esi
Code;  c012872c <kmem_cache_reap+dc/1c0>
   c:   39 d0                     cmp    %edx,%eax
Code;  c012872e <kmem_cache_reap+de/1c0>
   e:   75 f0                     jne    0 <_EIP>
Code;  c0128730 <kmem_cache_reap+e0/1c0>
  10:   8b 04 24                  mov    (%esp,1),%eax
Code;  c0128733 <kmem_cache_reap+e3/1c0>
  13:   89 00                     mov    %eax,(%eax)

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
