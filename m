Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTBPT7a>; Sun, 16 Feb 2003 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBPT7a>; Sun, 16 Feb 2003 14:59:30 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:20115 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267443AbTBPT72>; Sun, 16 Feb 2003 14:59:28 -0500
Message-ID: <3E4FEFEA.3030607@blue-labs.org>
Date: Sun, 16 Feb 2003 15:09:14 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: [OOPS] 2.5.53 NFS (rpc.mountd)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below is what can happen infrequently after the following has occured:

1) client loses love with server (df reports 1 for all filesystem stats)
2) admin runs 'exportfs -vra' on server
3) client gets love and server burps:

Unable to handle kernel paging request at virtual address 6b6b6b87
 printing eip:
c0378b4d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0378b4d>]    Not tainted
EFLAGS: 00010202
EIP is at auth_unix_lookup+0x3d/0x88
eax: 6b6b6b6b   ebx: dbdd7b60   ecx: caf3677c   edx: 6b6b6b6b
esi: 00000000   edi: dcf85f58   ebp: dbdd7b44   esp: dbdd7b1c
ds: 0068   es: 0068   ss: 0068
Process rpc.mountd (pid: 3677, threadinfo=dbdd6000 task=ddc70760)
Stack: dbdd7b60 dcf85ed0 dbdd7b40 c013d5de dffff600 dcf85ed0 c04067f8 
0600000a
       00000060 dbdd7f78 dbdd7f78 c01b695d 0600000a 00000008 d6e24914 
00000060
       dcf85ed4 ad030002 0600000a 00000000 00000000 6961722f 6f682f64 
642f656d
Call Trace:
 [<c013d5de>] kmalloc+0xaa/0x128
 [<c01b695d>] write_getfs+0xbd/0x17c
 [<c01b65b1>] fs_write+0x31/0x38
 [<c017ac3c>] sys_nfsservctl+0xb4/0xf8
 [<c0109283>] syscall_call+0x7/0xb

Code: 8b 40 1c 29 d0 85 c0 7e 0a b8 01 00 00 00 f0 0f ab 41 10 8b

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


