Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279909AbRJ3KSV>; Tue, 30 Oct 2001 05:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279911AbRJ3KSM>; Tue, 30 Oct 2001 05:18:12 -0500
Received: from lambik.cc.kuleuven.ac.be ([134.58.10.1]:36365 "EHLO
	lambik.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S279909AbRJ3KSF>; Tue, 30 Oct 2001 05:18:05 -0500
Message-Id: <200110301018.LAA17404@lambik.cc.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14-pre4 tainted + preempt oops...
Date: Tue, 30 Oct 2001 11:18:40 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i know oopses from tainted kernels are probably the result of a broken 
proprietary module, but this oops seems related with VM or preempt or so..
the kernel was tainted with vmware and nvidia modules, i'll try to reproduce 
without them now.

invalid operand: 0000
CPU:    0
EIP:    0010:[do_swap_page+211/352]   Tainted: PF
EFLAGS: 00010246
eax: 00000000   ebx: c13b1e80   ecx: d759e000  edx: c13b1ea8
esi: d759e000   edi: 00542800   ebp: d74c81f0  esp: d759fecc
ds: 0018   es: 0018   ss: 0018
Process icecast (pid: 276, stackpage=d759f000)
Stack: 4007c4d4 c170b740 00000000 d74852c0 00000001 c0123dc0 c170b740 d74852c0
        4007c4d4 d74c81f0 00542800 00000000 d759e000 c170b740 00000000 
d74852c0
        c011197d c170b740 d74852c0 4007c4d4 00000000 d759e000 00000004 
c0111800

Call Trace: [handle_mm_fault+112/240] [do_page_fault+381/1200] 
[do_page_fault+0/1200] [schedule+656/1024] [schedule_timeout+128/160]
Oct 30 11:00:18 bakvis kernel:    [process_timeout+0/112] 
[sys_nanosleep+278/496] [error_code+52/64]

Code: 0f 0b 8d 7b 24 8d 43 28 39 43 28 74 11 
b9 01 00 00 00 ba 03

greetings,
Frank
