Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUJIATX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUJIATX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUJIATX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:19:23 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:45559 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S266324AbUJIATC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:19:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: autofs panic, linux 2.4.21-15.EL.c0smp
Date: Fri, 8 Oct 2004 17:18:56 -0700
Message-ID: <0320111483D8B84AAAB437215BBDA526D60686@NAEX01.na.qualcomm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: autofs panic, linux 2.4.21-15.EL.c0smp
Thread-Index: AcStlZDHacGFD4DGTnCv3iibu4WmPw==
From: "Craig, Dave" <dwcraig@qualcomm.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Oct 2004 00:19:04.0138 (UTC) FILETIME=[95651AA0:01C4AD95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came across the following panic today when shutting down a system that
hung any processes attempting to access network mounts.

Has anyone seen something similar and have any suggestions on how to
improve system availability?  We're experiencing problems about once a
week.

Thanks,
	Dave Craig

Unable to handle kernel NULL pointer dereference at virtual address
00000000
printing eip:
c017c362
*pde = 129b2001
*pte = 00000000
Oops: 0000
loop vfat fat nfs sr_mod ide-cd cdrom dcdipm dcdbas nfsd lockd sunrpc lp
parport autofs ppp_async ppp_generic slhc tg3 ipv6 floppy sg microcode
keybdev moused
CPU:    0
EIP:    0060:[<c017c362>]    Tainted: PF
EFLAGS: 00010207
 
EIP is at invalidate_list [kernel] 0x22 (2.4.21-15.EL.c0smp/i686)
eax: f3273000   ebx: 00000000   ecx: f478b3a0   edx: e1195f50
esi: c5ca0300   edi: 00000000   ebp: c03a9704   esp: e1195f24
ds: 0068   es: 0068   ss: 0068
Process umount (pid: 22290, stackpage=e1195000)
Stack: f478b380 00000001 00000000 00000000 f3273000 e1195f50 f8972410
c017c43d 
       c03a9704 f3273000 e1195f50 f478b388 f478b388 f3273000 f3273048
f8972440 
       c0168592 f3273000 c03a8fe8 00000000 e1195f8c 0804def8 bfffb178
c017f99f 
Call Trace:   [<f8972410>] autofs_fs_type [autofs] 0x0 (0xe1195f3c)
[<c017c43d>] invalidate_inodes [kernel] 0x4d (0xe1195f40)
[<f8972440>] autofs_sops [autofs] 0x0 (0xe1195f60)
[<c0168592>] kill_super [kernel] 0xe2 (0xe1195f64)
[<c017f99f>] sys_umount [kernel] 0x3f (0xe1195f80)
[<c017fa17>] sys_oldumount [kernel] 0x17 (0xe1195fb4)
 
Code: 8b 3f 39 eb 74 66 8d 73 f8 8b 44 24 24 39 86 ac 00 00 00 75
 
Kernel panic: Fatal exception


