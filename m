Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273618AbRIQOJ6>; Mon, 17 Sep 2001 10:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273603AbRIQOJt>; Mon, 17 Sep 2001 10:09:49 -0400
Received: from staff.opaltelecom.net ([62.24.128.12]:61190 "EHLO
	staff.opaltelecom.net") by vger.kernel.org with ESMTP
	id <S273620AbRIQOJj>; Mon, 17 Sep 2001 10:09:39 -0400
Message-ID: <013301c13f82$74e6b6a0$f906a8c0@daver>
From: "Dave Rigby" <daver@opaltelecom.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS in 2.4.9 scsi generic stuff / kswapd
Date: Mon, 17 Sep 2001 15:10:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got this from a news server recently upgraded to 2.4.9, running diablo. It
was running for 3-4 days with a full NNTP feed (so heavy load), but
otherwise fine. Drop me a mail if you want any more info.
Ksymoops enclosed.

Please CC me with any resposes, as I'm not subcribed.

Regards

Dave Rigby

Opal Telecom



Unable to handle kernel paging request at virtual address 00fe44c8
c017f06d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[scsi_init_io_vc+221/368]
EIP:    0010:[<c017f06d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 6273022e   ebx: c8168800   ecx: 00fe4494   edx: 6272fc53
esi: c14f3400   edi: c027b4fc   ebp: 00000015   esp: c1479f58
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1479000)
Stack: c14f3600 c14f34ac c14f3600 00000202 00000024 00000001 c14f3400
c021f1a0
       cff271e0 cff271e0 c017d818 c14f3400 c021f1a0 c146a7e0 c1469a00
00000000
       00000282 c1479fbc ffffffff 0008e000 c016e13e c1469a18 c1469c7c
c0114b39
Call Trace: [scsi_request_fn+552/784] [generic_unplug_device+30/48]
[__run_task_queue+73/96] [kswapd+153/176] [stext+0/48]
Call Trace: [<c017d818>] [<c016e13e>] [<c0114b39>] [<c0126bc9>] [<c0105000>]
   [<c0105000>] [<c01054f6>] [<c0126b30>]
Code: 8b 51 34 39 d0 75 0f 0f b7 41 08 89 cb eb 14 8d 74 26 00 8b

>>EIP; c017f06d <scsi_init_io_vc+dd/170>   <=====
Trace; c017d818 <scsi_request_fn+228/310>
Trace; c016e13e <generic_unplug_device+1e/30>
Trace; c0114b39 <__run_task_queue+49/60>
Trace; c0126bc9 <kswapd+99/b0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01054f6 <kernel_thread+26/30>
Trace; c0126b30 <kswapd+0/b0>
Code;  c017f06d <scsi_init_io_vc+dd/170>
00000000 <_EIP>:
Code;  c017f06d <scsi_init_io_vc+dd/170>   <=====
   0:   8b 51 34                  mov    0x34(%ecx),%edx   <=====
Code;  c017f070 <scsi_init_io_vc+e0/170>
   3:   39 d0                     cmp    %edx,%eax
Code;  c017f072 <scsi_init_io_vc+e2/170>
   5:   75 0f                     jne    16 <_EIP+0x16> c017f083
<scsi_init_io_vc+f3/170>
Code;  c017f074 <scsi_init_io_vc+e4/170>
   7:   0f b7 41 08               movzwl 0x8(%ecx),%eax
Code;  c017f078 <scsi_init_io_vc+e8/170>
   b:   89 cb                     mov    %ecx,%ebx
Code;  c017f07a <scsi_init_io_vc+ea/170>
   d:   eb 14                     jmp    23 <_EIP+0x23> c017f090
<scsi_init_io_vc+100/170>
Code;  c017f07c <scsi_init_io_vc+ec/170>
   f:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c017f080 <scsi_init_io_vc+f0/170>
  13:   8b 00                     mov    (%eax),%eax





