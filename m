Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUJ3XxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUJ3XxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUJ3Xvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:51:48 -0400
Received: from smtp-outbound.host.net ([64.135.6.3]:37535 "EHLO
	marketresearchsite.net") by vger.kernel.org with ESMTP
	id S261441AbUJ3Xuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:50:35 -0400
Message-ID: <418428C6.7070707@staff.theuseful.com>
Date: Sat, 30 Oct 2004 19:50:30 -0400
From: Yaroslav Klyukin <yklyukin@staff.theuseful.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LVM general discussion and development <linux-lvm@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: LVM Oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ORBS-Stamp: stamp_not_defined
X-Vpipe: Scanner said ok (av_avast)
X-IP-stats: Incoming Last 0, First 178, in=22278, out=0, spam=0
X-External-IP: 208.48.182.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello!

Oops happened after several days of normal operation diring snapshot.


Linux backup-db2 2.4.27 #1 SMP Fri Oct 22 05:22:55 EST 2004 i686 unknown 
unknown GNU/Linux

Filesystem - reiserfs.

Logical Volume Manager 1.0.8
Heinz Mauelshagen, Sistina Software  17/11/2003 (IOP 10)


Unable to handle kernel NULL pointer dereference at virtual address 00000004
c02adbea
*pde = 126d9001
Oops: 0002
CPU:    0
EIP:    0010:[<c02adbea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: f8c3b4b0   ebx: fb20bde8   ecx: f89edc38   edx: 00000000
esi: 33dbdf00   edi: 00000001   ebp: 00000803   esp: c5bc3dac
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 9, stackpage=c5bc3000)
Stack: 00000038 00000803 00000000 eae59400 f4ff7800 f4ff7970 00002000 
c02aa5fa
        c5bc3e00 c5bc3df8 33dbc580 f4ff7800 f73a9000 00000400 f77db240 
eae59570
        f73a9000 33dbc580 0002cdd0 33dbdf38 33dbdf38 08030803 00003a06 
f2046d00
Call Trace:    [<c02aa5fa>] [<c02aa727>] [<c022a4be>] [<c022a59e>] 
[<c02b8d08>]
   [<c013ebdc>] [<c013ece5>] [<c0142b48>] [<c0142e41>] [<c01072b6>] 
[<c0142d50>]
   [<c0105000>] [<c01057ae>] [<c0142d50>]
Code: 89 42 04 8b 03 89 48 04 89 01 89 59 04 89 0b 89 ca 90 8d 74


 >>EIP; c02adbea <lvm_snapshot_remap_block+aa/100>   <=====

Trace; c02aa5fa <lvm_map+36a/480>
Trace; c02aa727 <lvm_make_request_fn+17/30>
Trace; c022a4be <generic_make_request+be/140>
Trace; c022a59e <submit_bh+5e/130>
Trace; c02b8d08 <netif_receive_skb+188/1c0>
Trace; c013ebdc <write_locked_buffers+2c/40>
Trace; c013ece5 <write_some_buffers+f5/140>
Trace; c0142b48 <sync_old_buffers+78/b0>
Trace; c0142e41 <kupdate+f1/1c0>
Trace; c01072b6 <ret_from_fork+6/20>
Trace; c0142d50 <kupdate+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057ae <arch_kernel_thread+2e/40>
Trace; c0142d50 <kupdate+0/1c0>

Code;  c02adbea <lvm_snapshot_remap_block+aa/100>
00000000 <_EIP>:
Code;  c02adbea <lvm_snapshot_remap_block+aa/100>   <=====
    0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c02adbed <lvm_snapshot_remap_block+ad/100>
    3:   8b 03                     mov    (%ebx),%eax
Code;  c02adbef <lvm_snapshot_remap_block+af/100>
    5:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c02adbf2 <lvm_snapshot_remap_block+b2/100>
    8:   89 01                     mov    %eax,(%ecx)
Code;  c02adbf4 <lvm_snapshot_remap_block+b4/100>
    a:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  c02adbf7 <lvm_snapshot_remap_block+b7/100>
    d:   89 0b                     mov    %ecx,(%ebx)
Code;  c02adbf9 <lvm_snapshot_remap_block+b9/100>
    f:   89 ca                     mov    %ecx,%edx
Code;  c02adbfb <lvm_snapshot_remap_block+bb/100>
   11:   90                        nop
Code;  c02adbfc <lvm_snapshot_remap_block+bc/100>
   12:   8d 74 00 00               lea    0x0(%eax,%eax,1),%esi


1 error issued.  Results may not be reliable.

-- 
Senior Systems Administrator, NiuTech LLC.
AIM: infiniteparticle
Cellular: (561) 843-1552


