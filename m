Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132348AbRAUSmI>; Sun, 21 Jan 2001 13:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132351AbRAUSl6>; Sun, 21 Jan 2001 13:41:58 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:22590 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132348AbRAUSlq>; Sun, 21 Jan 2001 13:41:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jeff Lightfoot <jeffml@pobox.com>
Reply-To: jeffml@pobox.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.1pre8 Oops
Date: Sun, 21 Jan 2001 11:41:41 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01012111414100.15973@earth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing special with this box.  SMP no modules, Squid proxy and 
running VNC/Pan at the time.  Using kernel version of reiserfs on 
filesystems other than root.

Be glad to offer any other info if needed.

EIP:    0010:[<c01c36a7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000002
eax: 00000300   ebx: 000f41fb   ecx: 00004000   edx: 000003fd
esi: c02ed380   edi: c0303da0   ebp: c02ed381   esp: c992fe9c
ds: 0018   es: 0018   ss: 0018
Process pan (pid: 23322, stackpage=c992f000)
Stack: c01c7858 c0303da0 00000005 c02a61a0 0000001b c02ed366 c02ed381 
0000001b
       0000000d c0116e42 c02a61a0 c02ed366 0000001b 00000001 c02ea068 
00000020
       0000000d 00000082 00000001 c02ed381 0000001e c01125bf c023d0a0 
00000001
Call Trace: [<c01c7858>] [<c0116e42>] [<c01125bf>] [<c0100018>] 
[<c01f2aa5>] [<c011aafc>] [<c010a8c5>] [<c0109014>] [<c0130018>] 
[<c0132a30>] [<c0108f53>]
Code: 0f b6 c0 c3 90 53 8b 54 24 08 8b 44 24 0c 8b 5c 24 10 83 7a

>>EIP; c01c36a7 <serial_in+37/3c>   <=====
Trace; c01c7858 <serial_console_write+5c/134>
Trace; c0116e42 <printk+12a/17c>
Trace; c01125bf <smp_error_interrupt+43/48>
Trace; c0100018 <startup_32+18/cb>
Trace; c01f2aa5 <net_tx_action+5/118>
Trace; c011aafc <do_softirq+5c/8c>
Trace; c010a8c5 <do_IRQ+e5/f4>
Trace; c0109014 <ret_from_intr+0/20>
Trace; c0130018 <shmem_truncate+2c/11c>
Trace; c0132a30 <sys_read+a8/c4>
Trace; c0108f53 <system_call+33/38>
Code;  c01c36a7 <serial_in+37/3c>
00000000 <_EIP>:
Code;  c01c36a7 <serial_in+37/3c>   <=====
   0:   0f b6 c0                  movzbl %al,%eax   <=====
Code;  c01c36aa <serial_in+3a/3c>
   3:   c3                        ret    
Code;  c01c36ab <serial_in+3b/3c>
   4:   90                        nop    
Code;  c01c36ac <serial_out+0/40>
   5:   53                        push   %ebx
Code;  c01c36ad <serial_out+1/40>
   6:   8b 54 24 08               mov    0x8(%esp,1),%edx
Code;  c01c36b1 <serial_out+5/40>
   a:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c01c36b5 <serial_out+9/40>
   e:   8b 5c 24 10               mov    0x10(%esp,1),%ebx
Code;  c01c36b9 <serial_out+d/40>
  12:   83 7a 00 00               cmpl   $0x0,0x0(%edx)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
