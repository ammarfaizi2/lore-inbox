Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSLVO5z>; Sun, 22 Dec 2002 09:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSLVO5y>; Sun, 22 Dec 2002 09:57:54 -0500
Received: from smtp.terra.es ([213.4.129.129]:24872 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S264673AbSLVO5v>;
	Sun, 22 Dec 2002 09:57:51 -0500
Date: Sun, 22 Dec 2002 15:46:55 +0100
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: linux-ntfs-dev@lists.sourceforge.net
Subject: ntfs bug
Message-Id: <20021222154655.0a2d1125.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__22_Dec_2002_15:46:55_+0100_0906d4b0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sun__22_Dec_2002_15:46:55_+0100_0906d4b0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

kernel 2.5.52, smp,
ntfs compiled as module,
writing not enabled, when i try to mount
an partition from xp:

NTFS driver 2.1.0 [Flags: R/O MODULE].
Unable to handle kernel NULL pointer dereference at virtual address 00000028
 printing eip:
d48b685f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<d48b685f>]    Not tainted
EFLAGS: 00010202
EIP is at ntfs_fill_super+0x16f/0x6c8 [ntfs]
eax: 00000000   ebx: c387de00   ecx: d4893000   edx: 00000200
esi: c03bb3ec   edi: c4dde760   ebp: c387de00   esp: cea5de8c
ds: 0068   es: 0068   ss: 0068
Process mount (pid: 523, threadinfo=cea5c000 task=c957e0c0)
Stack: c387de00 c03bb3ec c387df48 cea5decc c4dde694 00000200 c014ed36 c387de00 
       c505b000 00000000 c387de00 00000200 d48bc9e0 fffffff4 d48bc9e0 c15bb2b8 
       cea5df0c d48b6df7 d48bc9e0 00000000 c5059000 c505b000 d48b66f0 cffe6874 
Call Trace:
 [<c014ed36>] get_sb_bdev+0xe2/0x12c
 [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
 [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
 [<d48b6df7>] ntfs_get_sb+0x1f/0x24 [ntfs]
 [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
 [<d48b66f0>] ntfs_fill_super+0x0/0x6c8 [ntfs]
 [<c014ef07>] do_kern_mount+0x4b/0xb8
 [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
 [<c0164896>] do_add_mount+0x66/0x158
 [<c0164b6d>] do_mount+0x139/0x150
 [<c019639b>] copy_from_user+0x2f/0x3c
 [<c0165178>] sys_mount+0xd8/0x164
 [<c0109037>] syscall_call+0x7/0xb

Code: 8b 40 28 85 c0 74 11 66 83 b8 b6 00 00 00 00 74 07 0f b7 90 
 
diego@estel:~$ 

.config.gz attached


Diego Calleja
--Multipart_Sun__22_Dec_2002_15:46:55_+0100_0906d4b0
Content-Type: application/octet-stream;
 name=".config.gz"
Content-Disposition: attachment;
 filename=".config.gz"
Content-Transfer-Encoding: base64

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
mKjKv6RAuUwiMoQYCoj/B3+jlvV5RQAA

--Multipart_Sun__22_Dec_2002_15:46:55_+0100_0906d4b0--
