Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283266AbRLIJ0k>; Sun, 9 Dec 2001 04:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283254AbRLIJ0b>; Sun, 9 Dec 2001 04:26:31 -0500
Received: from pc2-camb4-0-cust100.cam.cable.ntl.com ([213.107.105.100]:7296
	"EHLO eden.lincnet") by vger.kernel.org with ESMTP
	id <S283266AbRLIJ0P>; Sun, 9 Dec 2001 04:26:15 -0500
Date: Sun, 9 Dec 2001 09:26:19 +0000 (GMT)
From: Carl Ritson <critson@perlfu.co.uk>
X-X-Sender: <critson@eden.lincnet>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
Message-ID: <Pine.LNX.4.33.0112090919220.1468-100000@eden.lincnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this at the very start of burning a cd, nothing special, using
ide-scsi build into kernel. "cdrecord -v dev=0,0,0 speed=4 img.iso".
Box is Dual-PIII 866, 1GB Ram, all IDE system.

Carl Ritson
critson@perlfu.co.uk
--------------------
ksymoops 2.4.0 on i686 2.5.1-pre8.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre8/ (default)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000090
c01cd0e0
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01cd0e0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210292
eax: 00000000   ebx: f7e80000   ecx: 00000001   edx: c03b5024
esi: ffffffff   edi: ffffffff   ebp: c03b5024   esp: f5cabb28
ds: 0018   es: 0018   ss: 0018
Process cdrecord (pid: 1592, stackpage=f5cab000)
Stack: f7e80000 f69c94a0 c03b5068 c03b5024 c0324000 00000000 00000000
c1e41f80
       fffffc18 00000000 c0324000 00200246 00000000 f7e9b5a0 c1e41f80
c01e0465
       00000000 f69c94a0 f7e80000 f7e83000 00000001 c03b5068 c03b5024
c01e0550
Call Trace: [<c01e0465>] [<c01e0550>] [<c01e0ab0>] [<c01e2b5c>]
[<c01f9def>]
   [<c01f9f2d>] [<c01dca69>] [<c01dce2e>] [<c01dd504>] [<c01fa91a>]
[<c01eaaeb>]
   [<c01eafb8>] [<c01f0373>] [<c01ef7b1>] [<c01ef7fe>] [<c01eace2>]
[<f8ab0e8b>]
   [<f8ab1ab8>] [<f8ab0c9a>] [<f8ab10d8>] [<c012f0a2>] [<f8ab38a6>]
[<f8ab3975>]
   [<c01b9f7c>] [<c012f24f>] [<c01b6813>] [<c01b612e>] [<c01b66a0>]
[<c01b889e>]
   [<c01b8922>] [<c01b434b>] [<c0142db7>] [<c0106e5b>]
Code: 8b 90 90 00 00 00 83 e2 04 89 54 24 28 83 7c 24 34 00 0f 84

>>EIP; c01cd0e0 <blk_rq_map_sg+28/1d0>   <=====
Trace; c01e0465 <ide_build_sglist+1d/d4>
Trace; c01e0550 <ide_build_dmatable+34/174>
Trace; c01e0ab0 <ide_dmaproc+100/228>
Trace; c01e2b5c <via82cxxx_dmaproc+b8/cc>
Trace; c01f9def <idescsi_issue_pc+6b/190>
Trace; c01f9f2d <idescsi_do_request+19/44>
Trace; c01dca69 <start_request+129/19c>
Trace; c01dce2e <ide_do_request+2de/338>
Trace; c01dd504 <ide_do_drive_cmd+108/140>
Trace; c01fa91a <idescsi_queue+57e/5d8>
Trace; c01eaaeb <scsi_dispatch_cmd+107/198>
Trace; c01eafb8 <scsi_done+0/9c>
Trace; c01f0373 <scsi_request_fn+3a7/3cc>
Trace; c01ef7b1 <__scsi_insert_special+71/80>
Trace; c01ef7fe <scsi_insert_special_req+1a/20>
Trace; c01eace2 <scsi_do_req+b2/b8>
Trace; f8ab0e8b <[sg]sg_common_write+1cb/1dc>
Trace; f8ab1ab8 <[sg]sg_cmd_done_bh+0/2c8>
Trace; f8ab0c9a <[sg]sg_new_write+1a2/1c8>
Trace; f8ab10d8 <[sg]sg_ioctl+23c/b0c>
Trace; c012f0a2 <_alloc_pages+16/18>
Trace; f8ab38a6 <[sg]sg_low_malloc+132/198>
Trace; f8ab3975 <[sg]sg_malloc+69/120>
Trace; c01b9f7c <pty_write+138/148>
Trace; c012f24f <__alloc_pages+33/164>
Trace; c01b6813 <opost_block+167/174>
Trace; c01b612e <initialize_tty_struct+16a/188>
Trace; c01b66a0 <opost+1a4/1b0>
Trace; c01b889e <write_chan+18a/228>
Trace; c01b8922 <write_chan+20e/228>
Trace; c01b434b <tty_write+1ff/26c>
Trace; c0142db7 <sys_ioctl+1bb/1f4>
Trace; c0106e5b <system_call+33/38>
Code;  c01cd0e0 <blk_rq_map_sg+28/1d0>
00000000 <_EIP>:
Code;  c01cd0e0 <blk_rq_map_sg+28/1d0>   <=====
   0:   8b 90 90 00 00 00         mov    0x90(%eax),%edx   <=====
Code;  c01cd0e6 <blk_rq_map_sg+2e/1d0>
   6:   83 e2 04                  and    $0x4,%edx
Code;  c01cd0e9 <blk_rq_map_sg+31/1d0>
   9:   89 54 24 28               mov    %edx,0x28(%esp,1)
Code;  c01cd0ed <blk_rq_map_sg+35/1d0>
   d:   83 7c 24 34 00            cmpl   $0x0,0x34(%esp,1)
Code;  c01cd0f2 <blk_rq_map_sg+3a/1d0>
  12:   0f 84 00 00 00 00         je     18 <_EIP+0x18> c01cd0f8
<blk_rq_map_sg+40/1d0>

