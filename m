Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbRBBVlk>; Fri, 2 Feb 2001 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129586AbRBBVla>; Fri, 2 Feb 2001 16:41:30 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:57303 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129419AbRBBVlN>; Fri, 2 Feb 2001 16:41:13 -0500
From: anders.karlsson@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, anders.karlsson@meansolutions.com
Message-ID: <802569E7.00771C4D.00@d06mta03.portsmouth.uk.ibm.com>
Date: Fri, 2 Feb 2001 21:40:56 +0000
Subject: Oops - 2.4.0-ac12
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Finally, after many crashes which I have not been able to capture,
here is two Oops'es which I have transfered by hand from my one
machine to another. Solid lockup I am afraid, only thing working
was Alt-SysRq keys.

# Oops #1 follows

Unable to handle kernel paging request at virtual address 5b919ba8
 printing eip:
c01a66c2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a66c2>]
EFLAGS: 00013086
eax: c5d0a200   ebx: 0000200a   ecx: 00008028    edx: 5b919aa8
esi: 0000200a   edi: 00000001   ebp: c02d4820    esp: c5061f4c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 800, stackpage=c5061000)
Stack: c02d4120 00000001 00000000 bffff634 00000001 c01a437a 00000001
00000001
       00000001 c02d4120 002d4820 c01a446d 00000001 00000000 c02ab580
c01a965f
       00000001 00000006 00000000 c011984c 00000000 00000001 c02ab5d8
00000007
Call Trace: [<c01a437a>] [<c01a446d>] [<c01a965f>] [<c011984c>]
[<c01197af>] [<c0108e2d>]

Code: 8b 82 00 01 00 00 89 3d 28 46 2d c0 39 10 74 21 8b 81 20 48
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

# Then I did Alt-SysRq-U and got the following

SysRq: Emergency Remount R/O
Remounting device 03:03 ... Scheduling in interrupt
Kernel BUG at sched.c:688!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113e74>]
EFLAGS: 00013286
eax: 0000001b   ebx: c5061dd8   ecx: 00000001    edx: c0263b88
esi: c11fc240   edi: c5060000   ebp: c5061dc4    esp: c5061d94
ds: 0018   es: 0018   ss: 0018
Process X (pid: 800, stackpage=c5061000)
Stack: c021c765 c021c8b6 000002b0 c5061dd8 c11fc240 c5060000 c0119a44
c02d5b60
       c5061dd8 c11fc240 00000000 c02d5bc4 00000000 c013106a c39a7240
00000303
       00000001 00000000 c5060000 c11fc28c c11fc28c c0131114 c11fc240
00000303
Call Trace: [<c0119a44>] [<c013106a>] [<c0131114>] [<c0131288>]
[<c01b0b64>]
            [<c01b0c2b>] [<c0115cae>] [<c011865f>] [<c010923e>]
[<c0113447>]
            [<c0113124>] [<c0131ee3>] [<c0131f53>] [<c014cb63>]
[<c0121e7f>]
            [<c0108e7c>] [<c01a66c2>] [<c01a437a>] [<c01a446d>]
[<c01a965f>]
            [<c011984c>] [<c01197af>] [<c0108e2d>]

Code: 0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 55 89 e5 83 ec 10 57 56
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing



This should be fairly accurate. I did my best to copy it across w/o
mistakes. After rebooting I got these stats out.

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux alien 2.4.0-ac12 #2 Thu Feb 1 11:51:08 GMT 2001 i686 unknown
Kernel modules         2.3.17
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.0.26
Linux C Library        2.1.3
Dynamic Linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         tulip_cb cb_enabler ibmtr_cs ds i82365 pcmcia_core
                       ipt_REDIRECT ipt_MASQUERADE ip_nat_ftp iptable_nat
                       iptable_mangle iptable_filter ipt_unclean ipt_tos
                       ipt_state ipt_owner ipt_multiport ipt_mark ipt_mac
                       ipt_limit ipt_TOS ipt_REJECT ipt_MIRROR ipt_MARK
                       ipt_LOG ip_tables ip_conntrack_ftp ip_conntrack
                       mpu401 sb sb_lib uart401 sound soundcore


If any more details should be required, I will be more than happy to
try and get them. The interesting thing was that the system reported
all filesystems clean upon boot. (!)


      /Anders



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
