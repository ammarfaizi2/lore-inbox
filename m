Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbTGGJHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 05:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbTGGJHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 05:07:55 -0400
Received: from post.polcard.com.pl ([193.109.115.28]:52913 "HELO
	post.polcard.com.pl") by vger.kernel.org with SMTP id S266891AbTGGJHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 05:07:53 -0400
Date: Mon, 7 Jul 2003 11:22:25 +0200
From: =?iso-8859-2?Q?Jaros=B3aw?= Bekas <jaroslaw.bekas@polcard.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Subject: bug on 2.5.74
Message-ID: <20030707092225.GA1293@polcard.com.pl>
Reply-To: =?iso-8859-2?Q?Jaros=B3aw?= Bekas 
	  <jaroslaw.bekas@polcard.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Organization: Polcard S.A.
X-Kernel-Version: 2.5.74-bk4
X-Machine: jaro - i686
X-Operating-System: Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello 

netstat generate this: 

Debug: sleeping function called from illegal context at
include/linux/rwsem.h:43
Call Trace:
 [<c0117fe0>] do_page_fault+0x0/0x4c7
 [<c011b9bb>] __might_sleep+0x5b/0x5d
 [<c017a85b>] proc_get_inode+0x12b/0x150
 [<c0118061>] do_page_fault+0x81/0x4c7
 [<c015d950>] real_lookup+0xe0/0x110
 [<c0117fe0>] do_page_fault+0x0/0x4c7
 [<c0109dad>] error_code+0x2d/0x38
 [<c0117fe0>] do_page_fault+0x0/0x4c7
 [<c0109dad>] error_code+0x2d/0x38
 [<c013d4a9>] kfree+0x39/0x70
 [<c016e1a3>] seq_release_private+0x23/0x3f
 [<c015186e>] __fput+0xfe/0x110
 [<c014ffeb>] filp_close+0x4b/0x80
 [<c015007f>] sys_close+0x5f/0x70
 [<c0109343>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 01000000
 printing eip:
c013d4a9
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c013d4a9>]    Not tainted
EFLAGS: 00010086
EIP is at kfree+0x39/0x70
eax: 00000000   ebx: f701e540   ecx: c0d033c0   edx: 01000000
esi: 00000100   edi: 00000206   ebp: f68b1f50   esp: f68b1f3c
ds: 007b   es: 007b   ss: 0068
Process netstat (pid: 1253, threadinfo=f68b0000 task=cd410d00)
Stack: f55c6664 f55c6658 f701e540 c0d033c0 ccbbd090 f68b1f6c c016e1a3 00000100 
       00000000 c0d033c0 f7fe7a00 ccbbd090 f68b1f8c c015186e ccbbd090 c0d033c0 
       e5ac3500 c0d033c0 c0dfa740 00000000 f68b1fa8 c014ffeb c0d033c0 c0dfa740 
Call Trace:
 [<c016e1a3>] seq_release_private+0x23/0x3f
 [<c015186e>] __fput+0xfe/0x110
 [<c014ffeb>] filp_close+0x4b/0x80
 [<c015007f>] sys_close+0x5f/0x70
 [<c0109343>] syscall_call+0x7/0xb

Code: 8b 1c 82 8b 03 3b 43 04 73 13 89 74 83 10 ff 03 57 9d 8b 5d 

-- 
Jaros³aw Bekas
PolCard S.A.
