Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTJIMez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJIMez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:34:55 -0400
Received: from bay7-f71.bay7.hotmail.com ([64.4.11.71]:47364 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262130AbTJIMex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:34:53 -0400
X-Originating-IP: [212.39.68.18]
X-Originating-Email: [ndnikolov@hotmail.com]
From: "Nikolay Nikolov" <ndnikolov@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.0-test7 pcm_oss bug
Date: Thu, 09 Oct 2003 12:34:51 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F71T9Am3B0cRGT0001acd1@hotmail.com>
X-OriginalArrivalTime: 09 Oct 2003 12:34:52.0281 (UTC) FILETIME=[BC8C9E90:01C38E61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have posted a bug in pcm_oss in linux-2.6.0-test6 while playing audio file 
with play. There was a patch:
alsa-bk-2003-09-30.patch.gz
I used it and everything was OK. But this patch is not appplied in the 
linux-2.6.0-test7 tree. So the problem is the same. Here is tho Oops:

Unable to handle kernel paging request at virtual address d4971000
printing eip:
d4991e1d
*pde = 01329067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<d4991e1d>]    Not tainted
EFLAGS: 00010202
EIP is at snd_pcm_format_set_silence+0x7d/0x1a0 [snd_pcm]
eax: 00000000   ebx: 00001cba   ecx: 00000a5d   edx: 00003974
esi: 00000002   edi: d4971000   ebp: ca84b5c0   esp: c3eedf18
ds: 007b   es: 007b   ss: 0068
Process sox (pid: 1303, threadinfo=c3eec000 task=c5ed9980)
Stack: 00000001 c3eec000 00001cba c6af5800 c12de140 d497a9bc 00000002 
d4970000
       00001cba c413b660 ca84b5c0 ceca9a00 c413b660 d497bbcc ca84b5c0 
c413b660
       cfed4260 cf1149bc cf328f20 c014a17a cf1149bc c413b660 c013f7ba 
cfed7cf0
Call Trace:
[<d497a9bc>] snd_pcm_oss_sync+0x9c/0x140 [snd_pcm_oss]
[<d497bbcc>] snd_pcm_oss_release+0x1c/0x90 [snd_pcm_oss]
[<c014a17a>] __fput+0x3a/0xd0
[<c013f7ba>] unmap_vma_list+0x1a/0x30
[<c0148d9c>] filp_close+0x5c/0x70
[<c0148df5>] sys_close+0x45/0x60
[<c010a7eb>] syscall_call+0x7/0xb

Code: f3 ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa e9 05 01 00 00

My motherboard is i810 and I use the onboard sound card.
OS is RH 7.2

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

