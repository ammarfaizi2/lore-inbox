Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKOIYA>; Wed, 15 Nov 2000 03:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQKOIXv>; Wed, 15 Nov 2000 03:23:51 -0500
Received: from 13dyn206.delft.casema.net ([212.64.76.206]:3847 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129091AbQKOIXf>; Wed, 15 Nov 2000 03:23:35 -0500
Message-Id: <200011150753.IAA05451@cave.bitwizard.nl>
Subject: 2.4. continues after Aieee...
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Nov 2000 08:53:23 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shouldn't the system be "halted" after an "Aiee, killing interrupt
handler"?


Modem status change from 0x63 to 0xf3
Unable to handle kernel NULL pointer dereference at virtual address 00000629
 printing eip:
c4854fcc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c4854fcc>]
EFLAGS: 00010002
eax: 00000620   ebx: c1e80000   ecx: c1f28000   edx: 00000000
esi: c2749800   edi: 000000f3   ebp: c3ba6000   esp: c26d7dc0
ds: 0018   es: 0018   ss: 0018
Process agetty (pid: 299, stackpage=c26d7000)
Stack: c487f3e3 c3ba6578 c487f3e2 00000212 00000145 00010082 c487f3e9 00000246 
       c3ba6578 c487f3e8 c4855603 c1e80000 00000002 c3ba6000 c487f3e2 c3ba6000 
       0000000b c3ba6000 c26d7eb4 c0274400 00000002 0002001d c4859d8f c1e80000 
Call Trace: [<c487f3e3>] [<c487f3e2>] [<c487f3e9>] [<c487f3e8>] [<c4855603>] [<c487f3e2>] [<c4859d8f>] 
       [<c484f358>] [<c484f471>] [<c010b681>] [<c010b7f2>] [<c010a4e0>] [<c0116ce9>] [<c0122a4d>] [<c01233ed>] 
       [<c0123683>] [<c01235bc>] [<c014c87c>] [<c012e032>] [<c010a423>] 
Code: f6 40 09 08 0f 85 22 01 00 00 8b 86 bc 00 00 00 a8 06 0f 84 
Aiee, killing interrupt handler
Scheduling in interrupt
kernel BUG at sched.c:692!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0116019>]
EFLAGS: 00010292
eax: 0000001b   ebx: 00000000   ecx: c1f28000   edx: 00000000
esi: 00000000   edi: 0000000b   ebp: c26d7cb8   esp: c26d7c68
ds: 0018   es: 0018   ss: 0018
Process agetty (pid: 299, stackpage=c26d7000)
Stack: c01eb041 c01eb216 000002b4 c1172160 c26d6000 0000000b 00000282 c26d6000 
       00000020 00000086 00000000 c3fca000 c26d6000 c26d6000 c011a9cf c26d6000 
       c1172160 00000000 c26d6000 00000629 00000629 c011abca 00000000 00000000 
Call Trace: [<c01eb041>] [<c01eb216>] [<c011a9cf>] [<c011abca>] [<c0111a88>] [<c010a956>] [<c0111da6>] 
       [<c01ea15e>] [<c0111a88>] [<c010e586>] [<c010b681>] [<c01e16c1>] [<c01e16c1>] [<c0188b92>] [<c010a564>] 
       [<c4854fcc>] [<c487f3e3>] [<c487f3e2>] [<c487f3e9>] [<c487f3e8>] [<c4855603>] [<c487f3e2>] [<c4859d8f>] 
       [<c484f358>] [<c484f471>] [<c010b681>] [<c010b7f2>] [<c010a4e0>] [<c0116ce9>] [<c0122a4d>] [<c01233ed>] 
       [<c0123683>] [<c01235bc>] [<c014c87c>] [<c012e032>] [<c010a423>] 
Code: 0f 0b 90 8d 65 bc 5b 5e 5f 89 ec 5d c3 89 f6 55 89 e5 83 ec 
Aiee, killing interrupt handler
Scheduling in interrupt
kernel BUG at sched.c:692!
invalid operand: 0000


After this, the call trace becomes longer and longer, but the system
keeps on oopsing... 

				Roger.




-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
