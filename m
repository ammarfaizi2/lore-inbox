Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbRE2RBc>; Tue, 29 May 2001 13:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbRE2RAO>; Tue, 29 May 2001 13:00:14 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261394AbRE2Q7V>;
	Tue, 29 May 2001 12:59:21 -0400
Message-ID: <001901c0e84e$1948d2f0$1901a8c0@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
Subject: EXT2-fs error (device ide0(3,1)): read_inode_bitmap: Cannot read inode bitmap - block_group = 129, inode_bitmap = 1056776 , kernel BUG at inode.c:886!
Date: Tue, 29 May 2001 15:46:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDRemoteIP: 192.168.1.25
X-Return-Path: Dave@keston.u-net.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlankTo all the kernel people,
                    Ok, this is probabally old news and has been fixed, but
the following happened in kernel 2.4.3 (ironically when i was deleting
/usr/src/linux in order to extract the latest 2.4.5 :-)


Here it is:

However, it has a very slight sound of a more serious problem, to do with my
disk (however, since i know nothing about this error message, i will take no
sides)

May 29 01:36:35 toweringmeep kernel: hda: read_intr: status=0x59 {
DriveReady SeekComplete DataRequest Error }
May 29 01:36:35 toweringmeep kernel: hda: read_intr: error=0x40 {
UncorrectableError }, LBAsect=2113616, sector=2113553
May 29 01:36:35 toweringmeep kernel: end_request: I/O error, dev 03:01
(hda), sector 2113553
May 29 01:36:35 toweringmeep kernel: EXT2-fs error (device ide0(3,1)):
read_inode_bitmap: Cannot read inode bitmap - block_group = 129,
inode_bitmap = 1056776
May 29 01:36:35 toweringmeep kernel: kernel BUG at inode.c:886!
May 29 01:36:35 toweringmeep kernel: invalid operand: 0000
May 29 01:36:35 toweringmeep kernel: CPU:    0
May 29 01:36:35 toweringmeep kernel: EIP:    0010:[iput+218/348]
May 29 01:36:35 toweringmeep kernel: EFLAGS: 00010282
May 29 01:36:35 toweringmeep kernel: eax: 0000001b   ebx: c04e12a0   ecx:
c1c8e000   edx: c0229808
May 29 01:36:35 toweringmeep kernel: esi: c022d440   edi: c1ca9f40   ebp:
c10e1fa4   esp: c10e1f50
May 29 01:36:35 toweringmeep kernel: ds: 0018   es: 0018   ss: 0018
May 29 01:36:35 toweringmeep kernel: Process rm (pid: 5838,
stackpage=c10e1000)
May 29 01:36:35 toweringmeep kernel: Stack: c01f11e5 c01f1265 00000376
c1ca9f40 c04e12a0 c013b9a8 c04e12a0 00000000
May 29 01:36:35 toweringmeep kernel:        c04e10c0 c0135854 c1ca9f40
c1ca9f40 c1ca9f40 c1a05000 c013592b c04e10c0
May 29 01:36:35 toweringmeep kernel:        c1ca9f40 c10e0000 08097753
00000000 bffff838 c0779540 c10ed7a0 c1a05000
May 29 01:36:35 toweringmeep kernel: Call Trace: [d_delete+76/108]
[vfs_unlink+276/324] [sys_unlink+167/284] [system_call+51/64]
May 29 01:36:35 toweringmeep kernel:
May 29 01:36:35 toweringmeep kernel: Code: 0f 0b 83 c4 0c eb 6f 39 1b 74 3b
f6 83 f0 00 00 00 07 75 26


Incidently, could anyone tell me out of interest what the problem actually
is / was ?

Thanks

Dave


PS: im now having a problem extracting the new kernel .... and find i have
numerous of these

May 29 01:53:35 toweringmeep kernel: hda: read_intr: status=0x59 {
DriveReady SeekComplete DataRequest Error }
May 29 01:53:35 toweringmeep kernel: hda: read_intr: error=0x40 {
UncorrectableError }, LBAsect=2113616, sector=2113553
May 29 01:53:35 toweringmeep kernel: end_request: I/O error, dev 03:01
(hda), sector 2113553
May 29 01:53:35 toweringmeep kernel: EXT2-fs error (device ide0(3,1)):
read_inode_bitmap: Cannot read inode bitmap - block_group = 129,
inode_bitmap = 1056776

is this a nice catch 22 ? or is there a nasty problem with one of my disks
... im about to reboot and check the disk....

---------------------------------------
The information in this e-mail and any files sent with it is confidential to
the ordinary user of the e-mail address to which it was addressed and may
also be legally privileged. It is not to be relied upon by any person other
than the addressee except with the sender's prior written approval. If no
such approval is given, the sender will not accept liability (in negligence
or otherwise) arising from any third party acting, or refraining from
acting, on such information. If you are not the intended recipient of this
e-mail you may not copy, forward, disclose or otherwise use it or any part
of it in any form whatsoever. If you have received this e-mail in error
please notify the sender immediately, destroy any copies and delete it from
your computer system. Have a nice Day !
---------------------------------------------


