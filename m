Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTJaBky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 20:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTJaBky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 20:40:54 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:25942 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262611AbTJaBku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 20:40:50 -0500
Date: Thu, 30 Oct 2003 22:38:47 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 OOPS! kswapd0 exited with preempt_count 1
Message-Id: <20031030223847.7068ebea.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20031030054548.1644d861.vmlinuz386@yahoo.com.ar>
References: <20031030054548.1644d861.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 05:45:48 -0300, Gerardo Exequiel Pozzi wrote:
>Hi, people 
>
>This is my first oops since testing 2.6.0-testX.
>This oops appears first and one time (not repetable), when gzipping a directory in /tmp (ext3).
>If you need more info, please tell me.
>
>Apps running: X,blackbox,vnc,wmaker,nicotine (p2p +- 25 threads), Mozilla Firebird.  
>
>
>ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
>     -V (default)
>     -k /proc/ksyms (default)
>     -l /proc/modules (default)
>     -o /lib/modules/2.6.0-test9/ (default)
>     -m /boot/System.map-2.6.0-test9 (specified)
>
>Error (regular_file): read_ksyms stat /proc/ksyms failed
>No modules in ksyms, skipping objects
>No ksyms, skipping lsmod
>Oct 30 05:06:31 djgera kernel: Unable to handle kernel paging request at virtual address 540092c4
>Oct 30 05:06:31 djgera kernel: c0156a57
>Oct 30 05:06:31 djgera kernel: *pde = 00000000
>Oct 30 05:06:31 djgera kernel: Oops: 0000 [#1]
>Oct 30 05:06:31 djgera kernel: CPU:    0
>Oct 30 05:06:31 djgera kernel: EIP:    0060:[<c0156a57>]    Not tainted
>Using defaults from ksymoops -t elf32-i386 -a i386
>Oct 30 05:06:31 djgera kernel: EFLAGS: 00010a87
>Oct 30 05:06:31 djgera kernel: eax: 540092ec   ebx: d40092ec   ecx: 540092ec   edx: d40091f8
>Oct 30 05:06:31 djgera kernel: esi: d40091f8   edi: 00000001   ebp: dfdda000   esp: dfddbe58
>Oct 30 05:06:31 djgera kernel: ds: 007b   es: 007b   ss: 0068
>Oct 30 05:06:31 djgera kernel: Stack: d40091f8 d4009200 d40091f8 00000024 c016d927 d40091f8 dfdda000 00000008 
>Oct 30 05:06:31 djgera kernel:        00000024 d4009500 c63bd400 00000026 dfdda000 00000000 dffeeb20 c016da08 
>Oct 30 05:06:31 djgera kernel:        00000026 c01422b2 00000026 000000d0 0001a2d8 010ffe84 00000000 000000a6 
>Oct 30 05:06:31 djgera kernel: Call Trace:
>Oct 30 05:06:31 djgera kernel:  [<c016d927>] prune_icache+0x147/0x200
>Oct 30 05:06:31 djgera kernel:  [<c016da08>] shrink_icache_memory+0x28/0x30
>Oct 30 05:06:31 djgera kernel:  [<c01422b2>] shrink_slab+0x112/0x160
>Oct 30 05:06:31 djgera kernel:  [<c01436f2>] balance_pgdat+0x1d2/0x200
>Oct 30 05:06:31 djgera kernel:  [<c0143863>] kswapd+0x143/0x150
>Oct 30 05:06:31 djgera kernel:  [<c011d550>] autoremove_wake_function+0x0/0x50
>Oct 30 05:06:31 djgera kernel:  [<c010b38e>] ret_from_fork+0x6/0x14
>Oct 30 05:06:31 djgera kernel:  [<c011d550>] autoremove_wake_function+0x0/0x50
>Oct 30 05:06:31 djgera kernel:  [<c0143720>] kswapd+0x0/0x150
>Oct 30 05:06:31 djgera kernel:  [<c01092c9>] kernel_thread_helper+0x5/0xc
>Oct 30 05:06:31 djgera kernel: Code: 8b 41 d8 83 e0 02 75 39 8b 01 8b 51 04 89 50 04 89 02 89 49 
>
>
>>>EIP; c0156a57 <remove_inode_buffers+37/80>   <=====
>
>>>eax; 540092ec <__crc_sk_chk_filter+401c70/4d197c>
>>>ebx; d40092ec <__crc_acpi_bus_register_driver+9d0e8/bdacc>
>>>ecx; 540092ec <__crc_sk_chk_filter+401c70/4d197c>
>>>edx; d40091f8 <__crc_acpi_bus_register_driver+9cff4/bdacc>
>>>esi; d40091f8 <__crc_acpi_bus_register_driver+9cff4/bdacc>
>>>ebp; dfdda000 <__crc_tcp_cwnd_application_limited+28afe/6714e1>
>>>esp; dfddbe58 <__crc_tcp_cwnd_application_limited+2a956/6714e1>
>
>Trace; c016d927 <prune_icache+147/200>
>Trace; c016da08 <shrink_icache_memory+28/30>
>Trace; c01422b2 <shrink_slab+112/160>
>Trace; c01436f2 <balance_pgdat+1d2/200>
>Trace; c0143863 <kswapd+143/150>
>Trace; c011d550 <autoremove_wake_function+0/50>
>Trace; c010b38e <ret_from_fork+6/14>
>Trace; c011d550 <autoremove_wake_function+0/50>
>Trace; c0143720 <kswapd+0/150>
>Trace; c01092c9 <kernel_thread_helper+5/c>
>
>Code;  c0156a57 <remove_inode_buffers+37/80>
>00000000 <_EIP>:
>Code;  c0156a57 <remove_inode_buffers+37/80>   <=====
>   0:   8b 41 d8                  mov    0xffffffd8(%ecx),%eax   <=====
>Code;  c0156a5a <remove_inode_buffers+3a/80>
>   3:   83 e0 02                  and    $0x2,%eax
>Code;  c0156a5d <remove_inode_buffers+3d/80>
>   6:   75 39                     jne    41 <_EIP+0x41>
>Code;  c0156a5f <remove_inode_buffers+3f/80>
>   8:   8b 01                     mov    (%ecx),%eax
>Code;  c0156a61 <remove_inode_buffers+41/80>
>   a:   8b 51 04                  mov    0x4(%ecx),%edx
>Code;  c0156a64 <remove_inode_buffers+44/80>
>   d:   89 50 04                  mov    %edx,0x4(%eax)
>Code;  c0156a67 <remove_inode_buffers+47/80>
>  10:   89 02                     mov    %eax,(%edx)
>Code;  c0156a69 <remove_inode_buffers+49/80>
>  12:   89 49 00                  mov    %ecx,0x0(%ecx)
>
>
>1 error issued.  Results may not be reliable.
>

Well,

I recently runned the memtest86 and detected varius bits error around 372MiB, (512MiB total).
Posibly this OOPS was by this problem. 

The memories had bought them does few days, when installing did not give them error,
but apparently they failed with the little use. :). With the previous memories I had a
similar problem but an error in 1 bit (it detects thanks to it to a general control,
since I did not have any oops.

Now booted temporarily with mem=256m. 

Linux version 2.6.0-test9-mm1 (root@djgera) (gcc version 3.2.3) #1 Thu Oct 30 14:03:22 ART 2003

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
