Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130531AbQK2OqP>; Wed, 29 Nov 2000 09:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130579AbQK2OqG>; Wed, 29 Nov 2000 09:46:06 -0500
Received: from mail.iex.net ([192.156.196.5]:55944 "EHLO mail.iex.net")
        by vger.kernel.org with ESMTP id <S130531AbQK2OqA>;
        Wed, 29 Nov 2000 09:46:00 -0500
Message-ID: <3A250F85.EF1FD067@iex.net>
Date: Wed, 29 Nov 2000 07:15:33 -0700
From: Tim Sullivan <tsulliva@iex.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test12-pre3: paging problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following occurred during startup using test12-pre3. test12-pre2
does not exhibit the problem.

regards,

-tim


kernel: Unable to handle kernel paging request at virtual address
fffffffc
kernel:  printing eip:
kernel: c011a41f
kernel: *pde = 00001063
kernel: *pte = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[sys_setitimer+191/208]
kernel: EFLAGS: 00010246
kernel: eax: 00000000   ebx: cf4e1fb0   ecx: 00000000   edx: c027169d
kernel: esi: bffffc68   edi: cf4e1fc0   ebp: 00000000   esp: cf4e1f88
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ntpdate (pid: 451, stackpage=cf4e1000)
kernel: Stack: cf4e0000 bffffd1c 00000009 bffffc70 00000000 cf4e0000
400538e8 00000000 
kernel:        00000000 40166214 00000000 00030d40 00000000 000186a0
c010a847 00000000 
kernel:        bffffc58 00000000 bffffd1c 00000009 bffffc70 00000068
0000002b 0000002b 
kernel: Call Trace: [system_call+51/56] 
kernel: Code: c8 5d 83 c4 28 c3 90 90 90 90 90 90 90 90 90 90 90 83 ec
44 


kernel: Unable to handle kernel paging request at virtual address
fffffffc
kernel:  printing eip:
kernel: c011a41f
kernel: *pde = 00001063
kernel: *pte = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[sys_setitimer+191/208]
kernel: EFLAGS: 00010246
kernel: eax: 00000000   ebx: cf301fb0   ecx: 00000000   edx: c027139d
kernel: esi: bffffc28   edi: cf301fc0   ebp: 00000000   esp: cf301f88
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ntpd (pid: 460, stackpage=cf301000)
kernel: Stack: cf300000 bffffd6c 00000002 bffffc30 00000000 cf300000
400538e8 00000000 
kernel:        00000000 40185214 00000001 00000000 00000001 00000000
c010a847 00000000 
kernel:        bffffc18 00000000 bffffd6c 00000002 bffffc30 00000068
0000002b 0000002b 
kernel: Call Trace: [system_call+51/56] 
kernel: Code: c8 5d 83 c4 28 c3 90 90 90 90 90 90 90 90 90 90 90 83 ec
44 


kernel: Unable to handle kernel paging request at virtual address
fffffffc
kernel:  printing eip:
kernel: c011a41f
kernel: *pde = 00001063
kernel: *pte = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[sys_setitimer+191/208]
kernel: EFLAGS: 00010246
kernel: eax: 00000000   ebx: cdc65fb0   ecx: 00000000   edx: c027169d
kernel: esi: bfffe8d8   edi: cdc65fc0   ebp: 00000000   esp: cdc65f88
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process X (pid: 853, stackpage=cdc65000)
kernel: Stack: cdc64000 bfffe8f8 00000000 bfffe8e0 cfae5000 cdc64000
000fae50 c012cd2c 
kernel:        c1447d40 080d78b0 00000000 00004e20 00000000 00004e20
c010a847 00000000 
kernel:        bfffe8c8 00000000 bfffe8f8 00000000 bfffe8e0 00000068
0000002b 0000002b 
kernel: Call Trace: [sys_open+136/180] [system_call+51/56] 
kernel: Code: c8 5d 83 c4 28 c3 90 90 90 90 90 90 90 90 90 90 90 83 ec
44
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
