Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267838AbTCFGFl>; Thu, 6 Mar 2003 01:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267835AbTCFGFl>; Thu, 6 Mar 2003 01:05:41 -0500
Received: from flrtn-2-m1-133.vnnyca.adelphia.net ([24.55.67.133]:19328 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S267838AbTCFGFD>;
	Thu, 6 Mar 2003 01:05:03 -0500
Message-ID: <3E66E782.5010502@tmsusa.com>
Date: Wed, 05 Mar 2003 22:15:30 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01 (NSCD7.01)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops in 2.5.64
Content-Type: multipart/mixed;
 boundary="------------010408090700090206070909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010408090700090206070909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings -

2.5.64 was running well, but after a day
or so of uptime, in fairly busy use (squid,
postfix, dhcp server, iptables, X desktop)
I ssh'd in as root, issued an init 3, then
a moment later, init 5. A moment after
that, the ssh session froze and all internet
access stopped as well.

The console was frozen, with an oops -

Configuration:
--------------------
Red Hat 8.0 + updates
kernel 2.5.64 and module-init-tools 0.9.10
Celeron 1.2 GHz on Intel mobo

The oops and .config are attached -

Joe





--------------010408090700090206070909
Content-Type: text/plain;
 name="oops-2.5.64"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-2.5.64"

Mar  5 21:17:41 jyro init: Switching to runlevel: 3
Mar  5 21:17:42 jyro kernel: mtrr: MTRR 2 not used
Mar  5 21:17:43 jyro microcode_ctl: microcode_ctl startup succeeded
Mar  5 21:17:44 jyro kernel: Unable to handle kernel paging request at virtual address d85b0000
Mar  5 21:17:44 jyro kernel:  printing eip:
Mar  5 21:17:44 jyro kernel: c013ce25
Mar  5 21:17:44 jyro kernel: *pde = 185b1163
Mar  5 21:17:44 jyro kernel: *pte = 6c69614d
Mar  5 21:17:44 jyro kernel: Oops: 0003
Mar  5 21:17:44 jyro kernel: CPU:    0
Mar  5 21:17:44 jyro kernel: EIP:    0060:[<c013ce25>]    Not tainted
Mar  5 21:17:44 jyro kernel: EFLAGS: 00010216
Mar  5 21:17:44 jyro kernel: EIP is at __constant_c_and_count_memset+0x85/0xa0
Mar  5 21:17:44 jyro kernel: eax: 00000000   ebx: 00000000   ecx: 00000400   edx: d85b0000
Mar  5 21:17:44 jyro kernel: esi: d3520000   edi: d85b0000   ebp: d3521eb4   esp: d3521eac
Mar  5 21:17:44 jyro kernel: ds: 007b   es: 007b   ss: 0068
Mar  5 21:17:44 jyro kernel: Process spamd (pid: 10385, threadinfo=d3520000 task=d7c70760)
Mar  5 21:17:44 jyro kernel: Stack: c042faf4 c13ce380 d3521ed8 c013c5b0 d85b0000 00000000 00001000 d4e21cc0 
Mar  5 21:17:44 jyro kernel:        d40c3088 d6d8a1e0 089d702c d3521f04 c013cace d6d8a1e0 d9b8d560 d3dfd75c 
Mar  5 21:17:44 jyro kernel:        d40c3088 00000001 089d702c d6d8a1e0 d6d8a200 d7c70760 d3521fb4 c0115096 
Mar  5 21:17:44 jyro kernel: Call Trace:
Mar  5 21:17:44 jyro kernel:  [<c013c5b0>] do_anonymous_page+0xd0/0x280
Mar  5 21:17:44 jyro kernel:  [<c013cace>] handle_mm_fault+0x6e/0xa0
Mar  5 21:17:44 jyro kernel:  [<c0115096>] do_page_fault+0x286/0x4e4
Mar  5 21:17:44 jyro kernel:  [<c013f11d>] do_brk+0x13d/0x210
Mar  5 21:17:44 jyro kernel:  [<c013dbe7>] sys_brk+0x107/0x130
Mar  5 21:17:44 jyro kernel:  [<c0114e10>] do_page_fault+0x0/0x4e4
Mar  5 21:17:44 jyro kernel:  [<c01099dd>] error_code+0x2d/0x38
Mar  5 21:17:44 jyro kernel: 
Mar  5 21:17:44 jyro kernel: Code: f3 ab eb a7 8d b4 26 00 00 00 00 c1 e9 02 89 d7 f3 ab aa eb 
Mar  5 21:18:02 jyro init: Switching to runlevel: 5
Mar  5 21:18:02 jyro microcode_ctl: microcode_ctl startup succeeded
Mar  5 21:18:10 jyro kernel:  <4>mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
Mar  5 21:18:11 jyro kernel: mm/memory.c:379: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:379: bad pmd ceab4bf8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 98393bc0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 02000000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 87de0d00.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4040.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000002.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000003.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000004.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000005.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000006.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000007.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00004644.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00093dbc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00004648.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000012.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab40a8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab40a8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000004da.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab40bc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab40bc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab428c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfccde78.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab40d4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab40d4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000476ac.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000081ed.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000004da.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da957d5.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3d36f23a.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da924c0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000000c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00001000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4134.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4134.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bfe0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bf80.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfabe400.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4150.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab40c4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4160.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4160.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4170.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4170.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4178.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4178.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039c080.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4188.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4188.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4190.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4190.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab41a0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab41a0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000000d2.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c0443168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab41b4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab41b4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab41c8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab41c8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 001be57b.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00093dbb.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 02682e6e.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000012.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4268.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4268.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000369.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab427c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab427c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab444c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfccde78.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4294.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4294.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000476ab.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000081ed.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000369.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da957d5.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3d36f23a.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da924c0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000000c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00001000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab42f4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab42f4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bfe0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bf80.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfabe400.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4310.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4284.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4320.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4320.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4328.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4328.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4330.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4330.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4338.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4338.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039c080.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4348.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4348.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4350.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4350.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4360.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4360.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000000d2.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c0443168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4374.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4374.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4388.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4388.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 001be575.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00093dba.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 4201666d.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000012.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4428.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4428.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000030f.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab443c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab443c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab460c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfccde78.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4454.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4454.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000476aa.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000081ed.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000030f.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da957d5.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3d36f23a.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da924c0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000000c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00001000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44b4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44b4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bfe0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bf80.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfabe400.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44d0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4444.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44e0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44e0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44e8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44e8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44f0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44f0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44f8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab44f8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039c080.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4508.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4508.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4510.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4510.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4520.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4520.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000000d2.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c0443168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4534.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4534.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4548.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4548.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 001be56f.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00093db9.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 01000006.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000012.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab45e8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab45e8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000453.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab45fc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab45fc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47cc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfccde78.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4614.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4614.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000476a9.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000081ed.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000453.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da957d5.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3d36f23a.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da924c0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000000c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00001000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4674.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4674.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bfe0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bf80.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfabe400.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4690.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4604.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46a0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46a0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46a8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46a8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46b0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46b0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46b8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46b8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039c080.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46c8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46c8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46d0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46d0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46e0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46e0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000000d2.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c0443168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46f4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab46f4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4708.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4708.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 001be569.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00093db8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 75736269.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000012.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47a8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47a8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000499.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47bc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47bc.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab498c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfccde78.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47d4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47d4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000476a8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000081ed.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000499.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da957d5.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3d36f23a.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da924c0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000000c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00001000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4834.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4834.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bfe0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bf80.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfabe400.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4850.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab47c4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4860.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4860.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4868.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4868.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4870.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4870.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4878.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4878.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039c080.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4888.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4888.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4890.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4890.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab48a0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab48a0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000000d2.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c0443168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab48b4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab48b4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab48c8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab48c8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 001be563.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00093db7.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000005da.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000012.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4968.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4968.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000442.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab497c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab497c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b4c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfccde78.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4994.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4994.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000476a7.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000081ed.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000442.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da957d5.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3d36f23a.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da924c0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000000c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00001000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab49f4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab49f4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bfe0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bf80.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfabe400.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a10.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4984.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a20.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a20.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a28.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a28.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a30.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a30.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a38.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a38.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039c080.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a48.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a48.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a50.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a50.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a60.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a60.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000000d2.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c0443168.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a74.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a74.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a88.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4a88.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 001be55d.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00093db6.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000000d6.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000012.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ffffffff.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b28.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b28.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000742.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b3c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b3c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4d0c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfccde78.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b54.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b54.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000476a6.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 000081ed.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000742.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da957d5.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3d36f23a.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 3da924c0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 0000000c.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00001000.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000008.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000001.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4bb4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4bb4.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bfe0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd c039bf80.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd dfabe400.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4bd0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4b44.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd 00000020.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4be0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4be0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4be8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4be8.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4bf0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4bf0.
Mar  5 21:18:11 jyro kernel: mm/memory.c:92: bad pmd ceab4bf8.
Mar  5 21:18:11 jyro kernel: Unable to handle kernel paging request at virtual address 7200658b
Mar  5 21:18:11 jyro kernel:  printing eip:
Mar  5 21:18:11 jyro kernel: c0162ce0
Mar  5 21:18:11 jyro kernel: *pde = 00000000
Mar  5 21:18:11 jyro kernel: Oops: 0000
Mar  5 21:18:11 jyro kernel: CPU:    0
Mar  5 21:18:11 jyro kernel: EIP:    0060:[<c0162ce0>]    Not tainted
Mar  5 21:18:11 jyro kernel: EFLAGS: 00010202
Mar  5 21:18:11 jyro kernel: EIP is at find_inode_fast+0x20/0x40
Mar  5 21:18:11 jyro kernel: eax: 72006573   ebx: dfc28000   ecx: 00007db2   edx: 72006573
Mar  5 21:18:11 jyro kernel: esi: dfc28000   edi: 00007db2   ebp: d3365e48   esp: d3365e44
Mar  5 21:18:11 jyro kernel: ds: 007b   es: 007b   ss: 0068
Mar  5 21:18:11 jyro kernel: Process xsetroot (pid: 10474, threadinfo=d3364000 task=d7c71360)
Mar  5 21:18:11 jyro kernel: Stack: d3364000 d3365e64 c0163d0f dfc28000 c15662c0 00007db2 c15662c0 dfc28000 
Mar  5 21:18:11 jyro kernel:        d3365e84 c016323a dfc28000 c15662c0 00007db2 00007db2 dfc28000 cb1b76e0 
Mar  5 21:18:11 jyro kernel:        d3365ea4 c0189cc0 dfc28000 00007db2 dfc301c4 fffffff4 dfc424ac dfc42444 
Mar  5 21:18:11 jyro kernel: Call Trace:
Mar  5 21:18:11 jyro kernel:  [<c0163d0f>] ifind_fast+0x2f/0x87
Mar  5 21:18:11 jyro kernel:  [<c016323a>] iget_locked+0x4a/0x70
Mar  5 21:18:11 jyro kernel:  [<c0189cc0>] ext3_lookup+0x80/0xf0
Mar  5 21:18:11 jyro kernel:  [<c015761f>] real_lookup+0xcf/0x100
Mar  5 21:18:11 jyro kernel:  [<c0157889>] do_lookup+0x99/0xb0
Mar  5 21:18:11 jyro kernel:  [<c0157bf5>] link_path_walk+0x355/0x650
Mar  5 21:18:11 jyro kernel:  [<c01588e6>] open_namei+0x76/0x3d0
Mar  5 21:18:11 jyro kernel:  [<c0121ae6>] update_wall_time+0x16/0x40
Mar  5 21:18:11 jyro kernel:  [<c0148f51>] filp_open+0x41/0x70
Mar  5 21:18:11 jyro kernel:  [<c0157243>] getname+0x93/0xd0
Mar  5 21:18:11 jyro kernel:  [<c01493b5>] sys_open+0x55/0x90
Mar  5 21:18:11 jyro kernel:  [<c0109833>] syscall_call+0x7/0xb
Mar  5 21:18:11 jyro kernel: 
Mar  5 21:18:11 jyro kernel: Code: 39 48 18 8b 10 74 0b 85 d2 89 d0 75 f3 31 c0 5b 5d c3 39 98 
Mar  5 21:18:11 jyro kernel:  <6>note: xsetroot[10474] exited with preempt_count 2
Mar  5 21:18:11 jyro kernel: bad: scheduling while atomic!
Mar  5 21:18:11 jyro kernel: Call Trace:
Mar  5 21:18:11 jyro kernel:  [<c011666b>] schedule+0x22b/0x230
Mar  5 21:18:11 jyro kernel:  [<c013ce5e>] cond_resched_lock+0x1e/0x30
Mar  5 21:18:11 jyro kernel:  [<c013b374>] unmap_vmas+0x144/0x240
Mar  5 21:18:11 jyro kernel:  [<c013f2b6>] exit_mmap+0x76/0x190
Mar  5 21:18:11 jyro kernel:  [<c01183c5>] mmput+0x55/0xb0
Mar  5 21:18:11 jyro kernel:  [<c011be98>] do_exit+0x118/0x310
Mar  5 21:18:11 jyro kernel:  [<c0109f66>] die+0x86/0x90
Mar  5 21:18:11 jyro kernel:  [<c0114f6d>] do_page_fault+0x15d/0x4e4
Mar  5 21:18:11 jyro kernel:  [<c01854d5>] ext3_getblk+0x95/0x2e0
Mar  5 21:18:11 jyro kernel:  [<c022b562>] __copy_to_user_ll+0x72/0x80
Mar  5 21:18:11 jyro kernel:  [<c014b541>] wake_up_buffer+0x11/0x30
Mar  5 21:18:11 jyro kernel:  [<c014b595>] unlock_buffer+0x35/0x60
Mar  5 21:18:11 jyro kernel:  [<c014eb5d>] ll_rw_block+0x4d/0x90
Mar  5 21:18:11 jyro kernel:  [<c013021f>] do_generic_mapping_read+0x18f/0x390
Mar  5 21:18:11 jyro kernel:  [<c018992b>] ext3_find_entry+0x2db/0x3e0
Mar  5 21:18:11 jyro kernel:  [<c0114e10>] do_page_fault+0x0/0x4e4
Mar  5 21:18:11 jyro kernel:  [<c01099dd>] error_code+0x2d/0x38
Mar  5 21:18:11 jyro kernel:  [<c0162ce0>] find_inode_fast+0x20/0x40
Mar  5 21:18:11 jyro kernel:  [<c0163d0f>] ifind_fast+0x2f/0x87
Mar  5 21:18:11 jyro kernel:  [<c016323a>] iget_locked+0x4a/0x70
Mar  5 21:18:11 jyro kernel:  [<c0189cc0>] ext3_lookup+0x80/0xf0
Mar  5 21:18:11 jyro kernel:  [<c015761f>] real_lookup+0xcf/0x100
Mar  5 21:18:11 jyro kernel:  [<c0157889>] do_lookup+0x99/0xb0
Mar  5 21:18:11 jyro kernel:  [<c0157bf5>] link_path_walk+0x355/0x650
Mar  5 21:18:11 jyro kernel:  [<c01588e6>] open_namei+0x76/0x3d0
Mar  5 21:18:11 jyro kernel:  [<c0121ae6>] update_wall_time+0x16/0x40
Mar  5 21:18:11 jyro kernel:  [<c0148f51>] filp_open+0x41/0x70
Mar  5 21:18:11 jyro kernel:  [<c0157243>] getname+0x93/0xd0
Mar  5 21:18:11 jyro kernel:  [<c01493b5>] sys_open+0x55/0x90
Mar  5 21:18:11 jyro kernel:  [<c0109833>] syscall_call+0x7/0xb
Mar  5 21:18:11 jyro kernel: 
Mar  5 21:18:11 jyro kernel: Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Mar  5 21:18:11 jyro kernel: Call Trace:
Mar  5 21:18:11 jyro kernel:  [<c013da79>] remove_shared_vm_struct+0x39/0xa0
Mar  5 21:18:11 jyro kernel:  [<c013f36b>] exit_mmap+0x12b/0x190
Mar  5 21:18:11 jyro kernel:  [<c01183c5>] mmput+0x55/0xb0
Mar  5 21:18:11 jyro kernel:  [<c011be98>] do_exit+0x118/0x310
Mar  5 21:18:11 jyro kernel:  [<c0109f66>] die+0x86/0x90
Mar  5 21:18:11 jyro kernel:  [<c0114f6d>] do_page_fault+0x15d/0x4e4
Mar  5 21:18:11 jyro kernel:  [<c01854d5>] ext3_getblk+0x95/0x2e0
Mar  5 21:18:11 jyro kernel:  [<c022b562>] __copy_to_user_ll+0x72/0x80
Mar  5 21:18:11 jyro kernel:  [<c014b541>] wake_up_buffer+0x11/0x30
Mar  5 21:18:11 jyro kernel:  [<c014b595>] unlock_buffer+0x35/0x60
Mar  5 21:18:11 jyro kernel:  [<c014eb5d>] ll_rw_block+0x4d/0x90
Mar  5 21:18:11 jyro kernel:  [<c013021f>] do_generic_mapping_read+0x18f/0x390
Mar  5 21:18:11 jyro kernel:  [<c018992b>] ext3_find_entry+0x2db/0x3e0
Mar  5 21:18:11 jyro kernel:  [<c0114e10>] do_page_fault+0x0/0x4e4
Mar  5 21:18:11 jyro kernel:  [<c01099dd>] error_code+0x2d/0x38
Mar  5 21:18:11 jyro kernel:  [<c0162ce0>] find_inode_fast+0x20/0x40
Mar  5 21:18:11 jyro kernel:  [<c0163d0f>] ifind_fast+0x2f/0x87
Mar  5 21:18:11 jyro kernel:  [<c016323a>] iget_locked+0x4a/0x70
Mar  5 21:18:11 jyro kernel:  [<c0189cc0>] ext3_lookup+0x80/0xf0
Mar  5 21:18:11 jyro kernel:  [<c015761f>] real_lookup+0xcf/0x100
Mar  5 21:18:11 jyro kernel:  [<c0157889>] do_lookup+0x99/0xb0
Mar  5 21:18:11 jyro kernel:  [<c0157bf5>] link_path_walk+0x355/0x650
Mar  5 21:18:11 jyro kernel:  [<c01588e6>] open_namei+0x76/0x3d0
Mar  5 21:18:11 jyro kernel:  [<c0121ae6>] update_wall_time+0x16/0x40
Mar  5 21:18:11 jyro kernel:  [<c0148f51>] filp_open+0x41/0x70
Mar  5 21:18:11 jyro kernel:  [<c0157243>] getname+0x93/0xd0
Mar  5 21:18:11 jyro kernel:  [<c01493b5>] sys_open+0x55/0x90
Mar  5 21:18:11 jyro kernel:  [<c0109833>] syscall_call+0x7/0xb
Mar  5 21:18:11 jyro kernel: 
Mar  5 21:18:11 jyro kernel: general protection fault: 0000
Mar  5 21:18:11 jyro kernel: CPU:    0
Mar  5 21:18:11 jyro kernel: EIP:    0060:[<c014108d>]    Not tainted
Mar  5 21:18:11 jyro kernel: EFLAGS: 00010286
Mar  5 21:18:11 jyro kernel: EIP is at page_remove_rmap+0xcd/0x140
Mar  5 21:18:11 jyro kernel: eax: cc7d7ebc   ebx: c14bb950   ecx: 00000007   edx: ffffffff
Mar  5 21:18:11 jyro kernel: esi: ce59b0ac   edi: 00000000   ebp: d26cfb70   esp: d26cfb58
Mar  5 21:18:11 jyro kernel: ds: 007b   es: 007b   ss: 0068
Mar  5 21:18:11 jyro kernel: Process gdm-binary (pid: 10475, threadinfo=d26ce000 task=d9b7a680)
Mar  5 21:18:11 jyro kernel: Stack: d34a8400 ffffffff d6bd7ea0 ce59b0ac 00000000 00012000 d26cfb9c c013b0e5 
Mar  5 21:18:11 jyro kernel:        c12cd918 d26ce000 d26ce000 00000000 c14bb950 1e4a2025 d2815404 4042b000 
Mar  5 21:18:11 jyro kernel:        4003d000 d26cfbc4 c013b18e c0429d0c d2815400 4002b000 00012000 c0429d0c 
Mar  5 21:18:11 jyro kernel: Call Trace:
Mar  5 21:18:11 jyro kernel:  [<c013b0e5>] zap_pte_range+0x165/0x1c0
Mar  5 21:18:11 jyro kernel:  [<c013b18e>] zap_pmd_range+0x4e/0x70
Mar  5 21:18:11 jyro kernel:  [<c013b1fe>] unmap_page_range+0x4e/0x80
Mar  5 21:18:11 jyro kernel:  [<c013b30d>] unmap_vmas+0xdd/0x240
Mar  5 21:18:11 jyro kernel:  [<c013f2b6>] exit_mmap+0x76/0x190
Mar  5 21:18:11 jyro kernel:  [<c01183c5>] mmput+0x55/0xb0
Mar  5 21:18:11 jyro kernel:  [<c0154814>] exec_mmap+0xb4/0x130
Mar  5 21:18:11 jyro kernel:  [<c0154930>] flush_old_exec+0x20/0x190
Mar  5 21:18:11 jyro kernel:  [<c0170981>] load_elf_binary+0x2a1/0xd10
Mar  5 21:18:11 jyro kernel:  [<c0130752>] generic_file_aio_read+0x52/0x70
Mar  5 21:18:11 jyro kernel:  [<c01706e0>] load_elf_binary+0x0/0xd10
Mar  5 21:18:11 jyro kernel:  [<c0154de4>] search_binary_handler+0x84/0x1f0
Mar  5 21:18:11 jyro kernel:  [<c01550f9>] do_execve+0x1a9/0x200
Mar  5 21:18:11 jyro kernel:  [<c0107e7d>] sys_execve+0x4d/0x80
Mar  5 21:18:11 jyro kernel:  [<c0109833>] syscall_call+0x7/0xb
Mar  5 21:18:11 jyro kernel: 
Mar  5 21:18:11 jyro kernel: Code: 8b 02 31 c9 89 45 ec 8b 44 8a 04 85 c0 74 0a 83 ff ff 0f 44 
Mar  5 21:18:11 jyro kernel:  <6>note: gdm-binary[10475] exited with preempt_count 2
Mar  5 21:18:11 jyro kernel: mtrr: MTRR 2 not used
Mar  5 21:21:01 jyro syslogd 1.4.1: restart.

--------------010408090700090206070909
Content-Type: text/plain;
 name="config-2.5.64"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.5.64"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_CARD is not set
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_XFRM_USER=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
CONFIG_3C515=m
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=m
# CONFIG_AMD_RNG is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP3 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_I810=y
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=y
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
# CONFIG_CIFS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_ZISOFS_FS=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=m
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
CONFIG_SOUND_MPU401=m
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--------------010408090700090206070909--

