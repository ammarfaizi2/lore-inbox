Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSHOF3i>; Thu, 15 Aug 2002 01:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSHOF3i>; Thu, 15 Aug 2002 01:29:38 -0400
Received: from wwns.wwns.com ([216.153.28.2]:36873 "EHLO wwns.wwns.com")
	by vger.kernel.org with ESMTP id <S316576AbSHOF3h>;
	Thu, 15 Aug 2002 01:29:37 -0400
From: David Wilson <david@wwns.com>
Message-Id: <200208150533.AAA14573@wwns.wwns.com>
Subject: Oops 2.4.20-pre2
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Aug 2002 00:33:29 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fellows,

This is on a RH 7.2 I486 firewall box 2 NE2000 cards, 16M RAM.
I tried several kernels in the 2.4.19-pre series and up to 2.4.20-pre2
I seem to get about the same problem.   The system locks before I get
a login prompt.

Any suggestions appreciated.


Running the oops through ksymoops:
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to handle kernel paging request at virtual address 0bc435e4
 printing eip:
c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
EFLAGS: 00010286
eax: 0bc435e4   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: 0bc435e0   edi: c025f360   ebp: c102c888   esp: c03f5e98
ds: 0018   es: 0018   ss: 0018
Process ifup-aliases (pid: 503, stackpage=c03f5000)
Stack: 00000000 00000001 c0125504 c102c888 c0d97900 080e728c 00000001 c025f360 
       c0d97900 c0125dc6 c025f360 c0d97900 080e728c c0f3f39c 01031065 8b084d8b 
       428b5851 14423b10 01b6820f ec830000 902d6a08 e9e6e851 c483fffb 080e728c 
Call Trace:    [<c0125504>] [<c0125dc6>] [<c0113dea>] [<c0121149>] [<c0113c60>]
  [<c0108bc4>]

Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 
 <1>Unable to handle kernel paging request at virtual address 0bc435e4
 printing eip:
c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
EFLAGS: 00010286
eax: 0bc435e4   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: 0bc435e0   edi: c025f2d0   ebp: c102c888   esp: c0475e98
ds: 0018   es: 0018   ss: 0018
Process ifup-aliases (pid: 502, stackpage=c0475000)
Stack: 00000001 00000001 c0125504 c102c888 c0d97810 080e7600 00000001 c025f2d0 
       c0d97810 c0125dc6 c025f2d0 c0d97810 080e7600 c0a9e39c 01031065 00000000 
       000002d5 00000286 00000000 c023f1a0 c023f3c4 c020e109 c0d97788 080e7600 
Call Trace:    [<c0125504>] [<c0125dc6>] [<c020e109>] [<c0113dea>] [<c013ddf1>]
  [<c013de3e>] [<c01363bf>] [<c01169da>] [<c013520c>] [<c0113c60>] [<c0108bc4>]

Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 
 <1>Unable to handle kernel paging request at virtual address aea43a04
 printing eip:

c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
EFLAGS: 00010286
eax: aea43a04   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: aea43a00   edi: c025f1b0   ebp: c102c8e0   esp: c03afe98
ds: 0018   es: 0018   ss: 0018
Process S17keytable (pid: 605, stackpage=c03af000)
Stack: 00000000 00000001 c0125504 c102c8e0 c025dc70 080d1b60 00000001 c025f1b0 
       c025dc70 c0125dc6 c025f1b0 c025dc70 080d1b60 c039b344 01033065 00000000 
       00000e7f 00000286 00000000 c023f1a0 c023f3c4 c020e109 c05eeaf8 080d1b60 
Call Trace:    [<c0125504>] [<c0125dc6>] [<c020e109>] [<c0113dea>] [<c0115f8c>]
  [<c01169da>] [<c013c344>] [<c0113c60>] [<c0108bc4>]

Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 

 <1>Unable to handle kernel paging request at virtual address aea43a04
 printing eip:
c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
EFLAGS: 00010286
eax: aea43a04   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: aea43a00   edi: 00000305   ebp: 00068052   esp: c078bdb0
ds: 0018   es: 0018   ss: 0018
Process find (pid: 811, stackpage=c078b000)
Stack: c102c8e0 00001000 c01394ab c102c8e0 00000305 00068053 00001000 00000000 
       00000305 00001000 00068052 c0137258 00000305 00068052 00001000 c0c03400 
       00068052 000001a0 0004e880 c013749c 00000305 00068052 00001000 c028d8c4 
Call Trace:    [<c01394ab>] [<c0137258>] [<c013749c>] [<c01a71d1>] [<c01365db>]
  [<c015b770>] [<c015b7f5>] [<c015cb88>] [<c0148be2>] [<c0148c73>] [<c0148eb2>]
  [<c0157cdc>] [<c015cd08>] [<c013e76f>] [<c013ef8b>] [<c013e498>] [<c013f623>]
  [<c013c364>] [<c0108ab3>]

Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 



-- 
David R. Wilson  WB4LHO
World Wide Network Services
Nashville, Tennessee USA
david@wwns.com


