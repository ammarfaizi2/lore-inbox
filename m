Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270227AbRHRPli>; Sat, 18 Aug 2001 11:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270228AbRHRPl3>; Sat, 18 Aug 2001 11:41:29 -0400
Received: from runningman.mobilixnet.dk ([212.97.204.27]:52750 "EHLO
	runningman.mobilixnet.dk") by vger.kernel.org with ESMTP
	id <S270227AbRHRPlU>; Sat, 18 Aug 2001 11:41:20 -0400
Date: Sat, 18 Aug 2001 17:41:32 +0200
From: Eirikur Hjartarson <eiki.hjartarson@wanadoo.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8-ac6 panic in schedule
Message-ID: <20010818174132.A444@pluto.home>
Reply-To: eiki.hjartarson@wanadoo.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got a kernel panic.  The machine froze so I had to
hand copy the oops from the screen!

At the time I was initiating isdn callout ("isdnctrl dial ippp0").
Otherwise the machine has been stable for a long time.

=========================================================================
isdn_ppp_xmit: lp->ppp_slot -1
invalid operand: 0000
CPU:	0
EIP:	0010:[<c0111a80>]
EFLAGS:	00010296
eax: 00000018 ebx: c166c000 ecx: c1860000 edx: 00000001
esi: 00000000 edi: c11d57a0 ebp: c166df98 esp: c166df74
ds: 0000 es: 0018 ss: 0018
Process named (pid: 296, stackpage=c166d000)
Stack: c01ed1d6 00000004 c166c000 00000000 c166c000 40640654 c166c000 00000000
       00000000 c166dfc4 c0105dcb 80004003 00000000 00004003 00000000 c166c000
       406409ac 400575e8 40640994 c0106d1b 406409ac 00000008 403ee264 406409ac
Code: 0f 0b 8d 65 f4 5b 5e 5f 5d c3 8d b6 00 00 00 00 8b 45 e8 c1
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
=========================================================================

The output from ksymoops follows.

=========================================================================
ksymoops 2.4.1 on i686 2.4.8-ac6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac6/ (default)
     -m /boot/System.map-2.4.8-ac6 (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111a80>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000018 ebx: c166c000 ecx: c1860000 edx: 00000001
esi: 00000000 edi: c11d57a0 ebp: c166df98 esp: c166df74
ds: 0000 es: 0018 ss: 0018
Process named (pid: 296, stackpage=c166d000)
Stack:  c01ed1d6 00000004 c166c000 00000000 c166c000 40640654 c166c000 00000000
        00000000 c166dfc4 c0105dcb 80004003 00000000 00004003 00000000 c166c000
        406409ac 400575e8 40640994 c0106d1b 406409ac 00000008 403ee264 406409ac
Code: 0f 0b 8d 65 f4 5b 5e 5f 5d c3 8d b6 00 00 00 00 8b 45 e8 c1

>>EIP; c0111a80 <schedule+50/3a0>   <=====
Code;  c0111a80 <schedule+50/3a0>
00000000 <_EIP>:
Code;  c0111a80 <schedule+50/3a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0111a82 <schedule+52/3a0>
   2:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp
Code;  c0111a85 <schedule+55/3a0>
   5:   5b                        pop    %ebx
Code;  c0111a86 <schedule+56/3a0>
   6:   5e                        pop    %esi
Code;  c0111a87 <schedule+57/3a0>
   7:   5f                        pop    %edi
Code;  c0111a88 <schedule+58/3a0>
   8:   5d                        pop    %ebp
Code;  c0111a89 <schedule+59/3a0>
   9:   c3                        ret    
Code;  c0111a8a <schedule+5a/3a0>
   a:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c0111a90 <schedule+60/3a0>
  10:   8b 45 e8                  mov    0xffffffe8(%ebp),%eax
Code;  c0111a93 <schedule+63/3a0>
  13:   c1 00 00                  roll   $0x0,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!
=========================================================================

If I can supply any more information, please let me know.

Regards,
-- 
Eiki
