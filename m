Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbRBZQHZ>; Mon, 26 Feb 2001 11:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130309AbRBZQHP>; Mon, 26 Feb 2001 11:07:15 -0500
Received: from andromeda.roque.ing.iac.es ([161.72.6.232]:63161 "EHLO
	andromeda.roque.ing.iac.es") by vger.kernel.org with ESMTP
	id <S130307AbRBZQG4>; Mon, 26 Feb 2001 11:06:56 -0500
To: linux-kernel@vger.kernel.org
Subject: oops in __kfree_skb with 2.4.0-ac4
Message-Id: <E14XQAk-00019j-00@andromeda.roque.ing.iac.es>
From: Robert Greimel <greimel@ing.iac.es>
Date: Mon, 26 Feb 2001 16:06:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following oops yesterday evening - below is the ksymoops output
of the hand typed oops report.
As the kernel is "relatively" old this oops might not be of much interest.
If someone is interested however, shout, and I will provide more info about
the system etc.
I am going to upgrade to the current kernel now.

Greetings

Robert

ksymoops 2.3.5 on i686 2.4.0-ac4-PII.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-ac4-PII/ (default)
     -m /lib/modules/2.4.0-ac4-PII/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 40270974
c011ab81
*pde = 06d70067
Oops: 0000
CPU: 0
EFLAGS: 00010887
eax: 000000e0 ebx: 0000001c ecx: 40270964 edx: c0270964
esi: c02695a0 edi: 00000000 ebp: c0239fa4 esp: c0239f44
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c0239000)
Stack: 00000000 c02695a0 00000000 c0239fa4 c766c840 c01a4755 c766c840 c0117bb3
       00000000 c0117aec 00000000 00000001 c02695c0 0000000c c01179f6 c02695c0
       00000260 c0267b60 00000013 c010a155 c0107118 c0238000 c0107118 c78df3a0
Call Trace: [<c01a4755>] [<c0117bb3>] [<c0117aec>] [<c01179f6>] [<c010a155>] [<c0107118>] [<c0107118>]
            [<c0108dcc>] [<c0107118>] [<c0107118>] [<c0100018>] [<c010713b>] [<c010719e>] [<c0105000>] [<c0100191>]
Code: 8b 71 10 8b 59 0c 8b 11 85 d2 74 08 8b 41 04 89 42 04 89 10
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c01a4755 <__kfree_skb+e9/f0>
Trace; c0117bb3 <bh_action+1b/60>
Trace; c0117aec <tasklet_hi_action+38/5c>
Trace; c01179f6 <do_softirq+42/64>
Trace; c010a155 <do_IRQ+9d/b0>
Trace; c0107118 <default_idle+0/28>
Trace; c0107118 <default_idle+0/28>
Trace; c0108dcc <ret_from_intr+0/20>
Trace; c0107118 <default_idle+0/28>
Trace; c0107118 <default_idle+0/28>
Trace; c0100018 <startup_32+18/139>
Trace; c010713b <default_idle+23/28>
Trace; c010719e <cpu_idle+3e/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 71 10                  mov    0x10(%ecx),%esi
Code;  00000003 Before first symbol
   3:   8b 59 0c                  mov    0xc(%ecx),%ebx
Code;  00000006 Before first symbol
   6:   8b 11                     mov    (%ecx),%edx
Code;  00000008 Before first symbol
   8:   85 d2                     test   %edx,%edx
Code;  0000000a Before first symbol
   a:   74 08                     je     14 <_EIP+0x14> 00000014 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   89 42 04                  mov    %eax,0x4(%edx)
Code;  00000012 Before first symbol
  12:   89 10                     mov    %edx,(%eax)

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
