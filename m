Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTLJItU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 03:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTLJItU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 03:49:20 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:65514 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S263478AbTLJItP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 03:49:15 -0500
Date: Wed, 10 Dec 2003 09:48:27 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 Oops in journal_try_to_free_buffers
Message-ID: <20031210084827.GA27823@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.9 on i686 2.4.23-x91.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-x91/ (default)
     -m /boot/System.map-2.4.23-x91 (specified)

kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
kernel: c0163f32
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[<c0163f32>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
kernel: EFLAGS: 00010217
kernel: eax: 00000050   ebx: 00000000   ecx: 000001d0   edx: 00000000
kernel: esi: c37070c4   edi: 00000001   ebp: c11cbf00   esp: c11cbeec
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process kswapd (pid: 4, stackpage=c11cb000)
kernel: Stack: c104c370 000001d0 00000010 00000050 00000000 c11cbf14 c015ba53 c7e5aa00
kernel:        c104c370 000001d0 c11cbf2c c0138cdc c104c370 000001d0 c37070c4 c104c370
kernel:        c11cbf5c c012fa81 c104c370 000001d0 0000001f 000001d0 c03b4d7c c11ca000
kernel: Call Trace:    [<c015ba53>] [<c0138cdc>] [<c012fa81>] [<c012fd95>] [<c012fdf8>]
kernel:   [<c012ff9b>] [<c0130007>] [<c013013d>] [<c01073b4>]
kernel: Code: 8b 5b 28 f6 42 19 04 74 13 8d 45 fc 50 52 e8 f3 fe ff ff 83


>>EIP; c0163f32 <journal_try_to_free_buffers+5e/9c>   <=====

>>esi; c37070c4 <_end+327d044/846ffe0>
>>ebp; c11cbf00 <_end+d41e80/846ffe0>
>>esp; c11cbeec <_end+d41e6c/846ffe0>

Trace; c015ba53 <ext3_releasepage+23/28>
Trace; c0138cdc <try_to_release_page+34/54>
Trace; c012fa81 <shrink_cache+1f5/368>
Trace; c012fd95 <shrink_caches+31/40>
Trace; c012fdf8 <try_to_free_pages_zone+54/d8>
Trace; c012ff9b <kswapd_balance_pgdat+5f/b4>
Trace; c0130007 <kswapd_balance+17/34>
Trace; c013013d <kswapd+9d/c0>
Trace; c01073b4 <arch_kernel_thread+28/38>

Code;  c0163f32 <journal_try_to_free_buffers+5e/9c>
00000000 <_EIP>:
Code;  c0163f32 <journal_try_to_free_buffers+5e/9c>   <=====
   0:   8b 5b 28                  mov    0x28(%ebx),%ebx   <=====
Code;  c0163f35 <journal_try_to_free_buffers+61/9c>
   3:   f6 42 19 04               testb  $0x4,0x19(%edx)
Code;  c0163f39 <journal_try_to_free_buffers+65/9c>
   7:   74 13                     je     1c <_EIP+0x1c>
Code;  c0163f3b <journal_try_to_free_buffers+67/9c>
   9:   8d 45 fc                  lea    0xfffffffc(%ebp),%eax
Code;  c0163f3e <journal_try_to_free_buffers+6a/9c>
   c:   50                        push   %eax
Code;  c0163f3f <journal_try_to_free_buffers+6b/9c>
   d:   52                        push   %edx
Code;  c0163f40 <journal_try_to_free_buffers+6c/9c>
   e:   e8 f3 fe ff ff            call   ffffff06 <_EIP+0xffffff06>
Code;  c0163f45 <journal_try_to_free_buffers+71/9c>
  13:   83 00 00                  addl   $0x0,(%eax)


gcc version 2.95.4 20011002 (Debian prerelease)


-- 
Frank
