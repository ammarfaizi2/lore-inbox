Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbRATCIp>; Fri, 19 Jan 2001 21:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbRATCIe>; Fri, 19 Jan 2001 21:08:34 -0500
Received: from [63.95.87.168] ([63.95.87.168]:7176 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129870AbRATCIb>;
	Fri, 19 Jan 2001 21:08:31 -0500
Date: Fri, 19 Jan 2001 21:08:30 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 repeatable opps
Message-ID: <20010119210830.A21243@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After starting X I get a kernel opps always on the xfs process,

System is RedHat 7.0+patches+linus 2.4.0 compiled with 'kgcc' (egcs-2.91.66)
Linux limelight 2.4.0 #1 Sat Jan 6 23:05:38 EST 2001 i686 unknown
  9:06pm  up  4:34,  6 users,  load average: 0.08, 0.16, 0.09
^was stable since compiled, applied some RedHat upgrades and rebooted to add
a second 3Com PCI 3c905 Boomerang. After rebooting, and changing some
service configuration (turning off telnet that a house guest turned on;
lazy bastard), I found xfs not running once I started X.

Linux version 2.4.0 (root@limelight) (gcc version 2.96 20000731 (Red Hat
Linux 7.0)) #1 Sat Jan 6 23:05:38 EST 2001

ksymoops 2.3.4 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /usr/src/linux/System.map (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012a974>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001b   ebx: da289300   ecx: 00000005   edx: 00000000
esi: 00000003   edi: 00027fed   ebp: d89a4000   esp: d89a5db0
ds: 0018   es: 0018   ss: 0018
Process xfs (pid: 1841, stackpage=d89a5000)
Stack: c02af7a5 c02af825 00000607 d89a5dc8 00000286 d8f1a000 000007af
da289300 
       00000003 c022f747 00027ff4 00000003 dfb1d7a0 00000ff0 c022ee72
00027ff0 
       00000003 d89a5e34 00027fed 00000000 dfb1d0f4 c027ae14 dfb1d7a0
00027fed 
Call Trace: [<c022f747>] [<c022ee72>] [<c027ae14>] [<c022cd5e>] [<c01239a2>]
[<c022d015>] [<c022d0ab>] 
       [<c01327bc>] [<c018c323>] [<c011ad29>] [<c011d804>] [<c011ac4c>]
[<c011ab58>] [<c0132933>] [<c0108f77>] 
Code: 0f 0b 83 c4 0c 31 c0 83 c4 10 5b 5e c3 eb 0d 90 90 90 90 90 

>>EIP; c012a974 <kmalloc+94/b0>   <=====
Trace; c022f747 <alloc_skb+e7/190>
Trace; c022ee72 <sock_alloc_send_skb+72/120>
Trace; c027ae14 <unix_stream_sendmsg+104/2b0>
Trace; c022cd5e <sock_sendmsg+6e/90>
Trace; c01239a2 <do_anonymous_page+32/80>
Trace; c022d015 <sock_readv_writev+95/a0>
Trace; c022d0ab <sock_writev+3b/50>
Trace; c01327bc <do_readv_writev+18c/260>
Trace; c018c323 <batch_entropy_process+b3/c0>
Trace; c011ad29 <__run_task_queue+49/60>
Trace; c011d804 <timer_bh+24/250>
Trace; c011ac4c <bh_action+1c/60>
Trace; c011ab58 <tasklet_hi_action+38/60>
Trace; c0132933 <sys_writev+43/60>
Trace; c0108f77 <system_call+33/38>
Code;  c012a974 <kmalloc+94/b0>
00000000 <_EIP>:
Code;  c012a974 <kmalloc+94/b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a976 <kmalloc+96/b0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012a979 <kmalloc+99/b0>
   5:   31 c0                     xor    %eax,%eax
Code;  c012a97b <kmalloc+9b/b0>
   7:   83 c4 10                  add    $0x10,%esp
Code;  c012a97e <kmalloc+9e/b0>
   a:   5b                        pop    %ebx
Code;  c012a97f <kmalloc+9f/b0>
   b:   5e                        pop    %esi
Code;  c012a980 <kmalloc+a0/b0>
   c:   c3                        ret    
Code;  c012a981 <kmalloc+a1/b0>
   d:   eb 0d                     jmp    1c <_EIP+0x1c> c012a990
<kmem_cache_free+0/b0>
Code;  c012a983 <kmalloc+a3/b0>
   f:   90                        nop    
Code;  c012a984 <kmalloc+a4/b0>
  10:   90                        nop    
Code;  c012a985 <kmalloc+a5/b0>
  11:   90                        nop    
Code;  c012a986 <kmalloc+a6/b0>
  12:   90                        nop    
Code;  c012a987 <kmalloc+a7/b0>
  13:   90                        nop    

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
