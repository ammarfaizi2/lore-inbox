Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135574AbRD1Qrc>; Sat, 28 Apr 2001 12:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbRD1QrW>; Sat, 28 Apr 2001 12:47:22 -0400
Received: from mailgate2.zdv.Uni-Mainz.DE ([134.93.8.57]:47602 "EHLO
	mailgate2.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S135574AbRD1QrS>; Sat, 28 Apr 2001 12:47:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Olaf Stetzer <ostetzer@mail.uni-mainz.de>
To: linux-kernel@vger.kernel.org
Subject: Severe problems when mounting vfat partitions
Date: Sat, 28 Apr 2001 18:05:11 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042818051100.00561@Seaborg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello *,

I hope that this is the right place to document my problems:

After some changes in the bios settings and/or rebuilding the kernel
(I don't remember the exact chronology of this..) I get the following
kernel message when I try to mount a vfat partition (either ide/hdd
or a ZIP connected to the SCSI-bus):

Dweezil:~# mount -t msdos /dev/hda5 /mnt
Unable to handle kernel NULL pointer dereference at virtual address 00000004
current->tss.cr3 = 074e4000, %cr3 = 074e4000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c801ead9>]
EFLAGS: 00010286
eax: 00000000   ebx: c0797df8   ecx: c0797eac   edx: 00000000
esi: 00000305   edi: c0797e60   ebp: c0797ebc   esp: c0797d78
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 416, process nr: 35, stackpage=c0797000)
Stack: c0797e60 c0797ebc c021e6dc c020b0d8 c7fe7400 00000001 c0797dc0 c0180d9b
       c021e6dc c801f4ee 00000000 c0797dec c0797df0 c0797df4 c0797eac c0797e60
       c0797df8 c658f600 00000305 c80763e0 c01f0000 c0113d34 c0797df4 d4afb60c
Call Trace: [<c0180d9b>] [<c801f4ee>] [<c80763e0>] [<c0113d34>] [<c012ab63>] 
[<c0140f88>] [<c0135e32>]
       [<c0135fe0>] [<c0141a69>] [<c80760ca>] [<c8076460>] [<c012c9d4>] 
[<c012ce7e>] [<c8076120>] [<c80763e0>]
       [<c012d31e>] [<c8076120>] [<c80763e0>] [<c010a0ac>]
Code: 66 8b 40 04 66 89 41 04 8a 41 0e 66 c7 41 06 00 00 24 d0 88
Segmentation fault

After this all other attemts to run mount/umount cause this program to
hang completely (I am unable to kill this process!)

I tried to get back to the old bios settings but nothing helped. Really 
strange that this problem occured since a few hours, before everything
worked fine!!!

My system is the following:
Duron 750 on a DFI AK74-SC (VIA KT133)
Kernels I tried: 2.2.17 and 2.2.18
vfat & friends is compiled as modules.
Windows 95 is running fine with the partitions in question so I think
it is not a problem with partition tables (the fact that also the scsi-ZIP
is causing this problem too underlines this!).

If you have any suggestions to solve the problem it would be very kind
to CC them to me (sorry for being a little bit inactive for my part but in
two weeks are my PhD exams and I need this problem to be fixed soon
so I can continue to work on the slides for my PhD presentation...)

Thanks a lot in advance!!!

Olaf 
