Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290454AbSAXW6d>; Thu, 24 Jan 2002 17:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290459AbSAXW6Z>; Thu, 24 Jan 2002 17:58:25 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:13253 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S290454AbSAXW6R>;
	Thu, 24 Jan 2002 17:58:17 -0500
To: linux-kernel@vger.kernel.org
Subject: oops with 2.4.18-pre6
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: 24 Jan 2002 14:58:15 -0800
Message-ID: <87vgdr4arc.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i just got the following oops while running 2.4.18-pre6:

ksymoops 2.4.3 on i686 2.4.18-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre6/ (default)
     -m /boot/System.map-2.4.18-pre6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan 24 14:46:49 caliban kernel: Unable to handle kernel paging request at virtual address 0017e980
Jan 24 14:46:49 caliban kernel: c0129b50
Jan 24 14:46:49 caliban kernel: *pde = 00000000
Jan 24 14:46:49 caliban kernel: Oops: 0002
Jan 24 14:46:49 caliban kernel: CPU:    0
Jan 24 14:46:49 caliban kernel: EIP:    0010:[kmem_cache_free+352/608]    Tainted: P 
Jan 24 14:46:49 caliban kernel: EFLAGS: 00013092
Jan 24 14:46:49 caliban kernel: eax: 5a2c7471   ebx: c5fa6000   ecx: 00000000   edx: c5fa6670
Jan 24 14:46:49 caliban kernel: esi: c5fa6608   edi: 0017e980   ebp: c1806258   esp: c1837ee8
Jan 24 14:46:49 caliban kernel: ds: 0018   es: 0018   ss: 0018
Jan 24 14:46:49 caliban kernel: Process kswapd (pid: 4, stackpage=c1837000)
Jan 24 14:46:49 caliban kernel: Stack: c5fa660c c5fa660c c5fa660c c135adc0 c0129bca c18071d0 00003282 00003246 
Jan 24 14:46:49 caliban kernel:        c0132f46 c1806258 c5fa660c c5fa660c c0134ba2 c5fa660c c5fa660c c135adc0 
Jan 24 14:46:49 caliban kernel:        000001d0 00000000 0000000c c01331fe c135adc0 000001d0 c135addc c135adc0 
Jan 24 14:46:49 caliban kernel: Call Trace: [kmem_cache_free+474/608] [__put_unused_buffer_head+54/112] [try_to_free_buffers+114/256] [try_to_release_page+7
Jan 24 14:46:49 caliban kernel: Code: 87 42 fc 3d a5 c2 0f 17 74 16 68 8f 05 00 00 68 8b 2a 25 c0 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   87 42 fc                  xchg   %eax,0xfffffffc(%edx)
Code;  00000002 Before first symbol
   3:   3d a5 c2 0f 17            cmp    $0x170fc2a5,%eax
Code;  00000008 Before first symbol
   8:   74 16                     je     20 <_EIP+0x20> 00000020 Before first symbol
Code;  0000000a Before first symbol
   a:   68 8f 05 00 00            push   $0x58f
Code;  0000000e Before first symbol
   f:   68 8b 2a 25 c0            push   $0xc0252a8b


1 warning issued.  Results may not be reliable.

the system is a 1.4GHZ Athlon, 512MB of memory, ide. i am running the
nvidia binary driver.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
