Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVEZPMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVEZPMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVEZPMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:12:48 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:6869 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S261434AbVEZPMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:12:45 -0400
Message-Id: <200505261512.j4QFCiRe003049@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: Patch avoiding-mmap-fragmentation-fix-2.patch oops
Date: Thu, 26 May 2005 16:12:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Rutherford-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm using kernel 2.6.12-rc5-git1
with patches from -mm
avoiding-mmap-fragmentation.patch
avoiding-mmap-fragmentation-tidy.patch
avoiding-mmap-fragmentation-fix.patch
avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes.patch
avoiding-mmap-fragmentation-fix-2.patch

I get a oops when exiting from mplayer playing (dfbmga framebuffer):-

xxxxxxxx.xxxxxxxxxxxxxx.com login: Unable to handle kernel paging request at
v0
 printing eip:
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: parport_pc lp parport floppy natsemi nls_iso8859_15 ntfs
mgai
CPU:    0
EIP:    0060:[<e29245cc>]    Not tainted VLI
EFLAGS: 00210286   (2.6.12-rc5-git1)
EIP is at snd_pcm_mmap_data_close+0x6/0xd [snd_pcm]
eax: 0000863c   ebx: d6073000   ecx: d4dc356c   edx: e29245c6
esi: d50756fc   edi: d58a7180   ebp: d66b9800   esp: d6073f6c
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 1634, threadinfo=d6073000 task=d72e6020)
Stack: c013ddbc 00000000 d66b9800 d50756fc c013f532 b747e000 b746e000
c013f8ad
       b746e000 b747e000 d4dc3a14 d66b9800 d66b9830 ffff0001 d6073000
c013f928
       b746e000 00000002 00000002 c01026ff b746e000 00010000 b7ec143c
00000002
Call Trace:
 [<c013ddbc>] remove_vm_struct+0x78/0x81
 [<c013f532>] unmap_vma_list+0xe/0x17
 [<c013f8ad>] do_munmap+0xf1/0x12c
 [<c013f928>] sys_munmap+0x40/0x63
 [<c01026ff>] sysenter_past_esp+0x54/0x75
Code: 81 dd 89 f8 8b 5c 24 04 8b 74 24 08 8b 7c 24 0c 8b 6c 24 10 83 c4 14
c3 8

(sorry didn't have linewrap on my minicom!)

Without the last patch, avoiding-mmap-fragmentation-fix-2, works fine doing
same stuff with mplayer.

More information/testing can be supplied/performed as required.

Thanks
Colin Harrison

