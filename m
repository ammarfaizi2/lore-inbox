Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbTBFVEv>; Thu, 6 Feb 2003 16:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTBFVEv>; Thu, 6 Feb 2003 16:04:51 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:1688 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267386AbTBFVEu>; Thu, 6 Feb 2003 16:04:50 -0500
Message-ID: <3E42D05E.8080907@blue-labs.org>
Date: Thu, 06 Feb 2003 16:15:10 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030131
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.59 OOPS w/ fdisk & devfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel paging request at virtual address 6b6b6b87
 printing eip:
c018ddf3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c018ddf3>]    Not tainted
EFLAGS: 00010202
EIP is at _devfs_unhook+0x2b/0x70
eax: 6b6b6b6b   ebx: 6b6b6b6b   ecx: c109312c   edx: 6b6b6b6b
esi: 00000002   edi: c109312c   ebp: 6b6b6b6b   esp: c1d41f0c
ds: 007b   es: 007b   ss: 0068
Process fdisk (pid: 178, threadinfo=c1d40000 task=c162c100)
Stack: c109312c c018de4a c109312c c109312c 00000002 c1503520 c10c2874 
c018deeb
       6b6b6b6b c109312c c10b904c c01758ad c109312c c108f850 c0175ad7 
c10c2874
       00000002 c108f868 c108f850 c1503520 c15b4924 00000000 c0279ebf 
c10c2874
Call Trace:
 [<c018de4a>] _devfs_unregister+0x12/0x90
 [<c018deeb>] devfs_unregister+0x23/0x30
 [<c01758ad>] delete_partition+0x49/0x58
 [<c0175ad7>] rescan_partitions+0x6b/0xf0
 [<c0279ebf>] blkdev_reread_part+0x5b/0x74
 [<c027a247>] blkdev_ioctl+0x24b/0x379
 [<c0156f49>] sys_ioctl+0x21d/0x274
 [<c0108dd7>] syscall_call+0x7/0xb

Code: 89 42 1c 8b 51 1c 85 d2 75 08 8b 41 18 89 43 10 eb 06 8b 41
 <6>note: fdisk[178] exited with preempt_count 2

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


