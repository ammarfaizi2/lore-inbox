Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267757AbUG3RGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267757AbUG3RGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267752AbUG3RFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:05:44 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:43477 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267748AbUG3RFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:05:30 -0400
Message-ID: <410A7FD5.8010906@eidetix.com>
Date: Fri, 30 Jul 2004 19:05:25 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.7: swap doesn't seem to happen
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me.  Thanks. ]

Trying to rsync a big directory from one place to another.  Not much 
free memory.

Unable to handle kernel paging request at virtual address 0000186b
  printing eip:
c015ef88
*pde = 00000000
Oops: 0000 [#7]
Modules linked in: nfs lockd sunrpc floppy sg scsi_mod capability 
commoncap 8139cp ohci_hcd nvidia_agp agpgart evdev ehci_hcd usbcore 
8139too mii crc32 forcedeth isofs zlib_inflate ide_cd cdrom rtc unix
CPU:    0
EIP:    0060:[<c015ef88>]    Not tainted
EFLAGS: 00010202   (2.6.7)
EIP is at __d_lookup+0x68/0x100
eax: 0000186b   ebx: 0000186b   ecx: 00000011   edx: f7f00000
esi: df18df28   edi: 32ae6223   ebp: f6ffff98   esp: df18de58
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 19544, threadinfo=df18c000 task=d4df2f30)
Stack: c01245f2 f5e49d80 000003e8 32ae6223 00000000 f7f69834 e360102a 
0000000c
        e360102a df18df28 f7fcd160 df18dec0 c0155b70 d3d4b050 df18dec8 
00000001
        e360102a df18dec0 c6ff6ed4 df18dec8 c015602c df18df28 df18dec8 
df18dec0
Call Trace:
  [<c01245f2>] in_group_p+0x42/0x80
  [<c0155b70>] do_lookup+0x30/0xb0
  [<c015602c>] link_path_walk+0x43c/0x850
  [<c0156659>] path_lookup+0x69/0x110
  [<c01568c9>] __user_walk+0x49/0x60
  [<c0151f7c>] vfs_lstat+0x1c/0x60
  [<c01526ab>] sys_lstat64+0x1b/0x40
  [<c0113a10>] do_page_fault+0x0/0x4ff
  [<c0104925>] error_code+0x2d/0x38
  [<c0103efb>] syscall_call+0x7/0xb

Code: 8b 03 0f 18 00 90 8d 6b 98 8b 7c 24 0c 39 7d 14 74 12 8b 1b

What I notice is that swap is not in use:

             total       used       free     shared    buffers     cached
Mem:        907512     883488      24024          0      66184    658980
-/+ buffers/cache:     158324     749188
Swap:       497972          0     497972


config and other junk available on request.

Thankyou,
-- 
David N. Welton
davidw@eidetix.com
