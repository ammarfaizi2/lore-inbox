Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312603AbSCVBOk>; Thu, 21 Mar 2002 20:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312604AbSCVBO1>; Thu, 21 Mar 2002 20:14:27 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:6140 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S312603AbSCVBN4>; Thu, 21 Mar 2002 20:13:56 -0500
Message-ID: <00e401c1d13e$d5d92580$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020321180811.A12688@rushmore>
Subject: Re: Linux 2.4.19-pre3-ac5
Date: Thu, 21 Mar 2002 20:13:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 22 Mar 2002 01:13:54.0898 (UTC) FILETIME=[D5D83B20:01C1D13E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: <rwhron@earthlink.net>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 21, 2002 6:08 PM
Subject: Re: Linux 2.4.19-pre3-ac5


> > stuff. If you want a peaceful life and a production -ac system please
> > stick at 2.4.18-ac3 or 2.4.19pre3-ac4. IDE and large NFS changes do not
> > in general make for stability first time around.
>
> No complaints.  Maybe this ksymoops output is helpful.
>
> Oops occured at boot time:

<snip>

Me Too (tm).

Same BUG, similar oops trace, different hardware (SMP PPro, 440FX chipset).
Here it is in case it's useful:

ksymoops 2.4.1 on i686 2.4.19-pre3-ac4.  Options used
     -v /usr/src/linux-2.4.19-pre3-ac5/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux-2.4.19-pre3-ac5/System.map (specified)

kernel BUG at ide-cd.c:790!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0237e5f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c03d8c28   ecx: 00000064   edx: 00000177
esi: 000001f4   edi: c12f1e84   ebp: 00000000   esp: c12f1cb4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c12f1000)
Stack: 0080c8dc 00000000 00000000 c1369a00 c03d8c28 c02389dd c03d8c28 c12f1e6c
       c02387d0 c0237de4 c03d8c28 00000064 00000000 c03d8c28 00000040 c12f1dac
       c0238a33 c03d8c28 00000018 c02389b0 c022d647 c03d8c28 c12f1dac 00000000
Call Trace: [<c02389dd>] [<c02387d0>] [<c0237de4>] [<c0238a33>] [<c02389b0>]
   [<c022d647>] [<c022d99c>] [<c022e03a>] [<c0238acf>] [<c01157a1>] [<c0239992>]
   [<c0265c5d>] [<c023a11b>] [<c023a18b>] [<c0140feb>] [<c023aaa6>] [<c023af99>]
   [<c0105000>] [<c0105068>] [<c0105000>] [<c0105696>] [<c0105040>]
Code: 0f 0b 16 03 9d 87 2f c0 68 50 7c 23 c0 56 8b 74 24 28 56 53

>>EIP; c0237e5f <cdrom_transfer_packet_command+6f/a0>   <=====
Trace; c02389dd <cdrom_do_pc_continuation+2d/40>
Trace; c02387d0 <cdrom_pc_intr+0/1e0>
Trace; c0237de4 <cdrom_start_packet_command+154/160>
Trace; c0238a33 <cdrom_do_packet_command+43/50>
Trace; c02389b0 <cdrom_do_pc_continuation+0/40>
Trace; c022d647 <start_request+197/200>
Trace; c022d99c <ide_do_request+29c/2f0>
Trace; c022e03a <ide_do_drive_cmd+fa/130>
Trace; c0238acf <cdrom_queue_packet_command+4f/b0>
Trace; c01157a1 <wait_for_completion+91/c0>
Trace; c0239992 <ide_cdrom_packet+72/80>
Trace; c0265c5d <cdrom_mode_sense+4d/60>
Trace; c023a11b <ide_cdrom_get_capabilities+9b/b0>
Trace; c023a18b <ide_cdrom_probe_capabilities+5b/420>
Trace; c0140feb <bdput+8b/a0>
Trace; c023aaa6 <ide_cdrom_setup+466/4f0>
Trace; c023af99 <ide_cdrom_init+e9/17f>
Trace; c0105000 <_stext+0/0>
Trace; c0105068 <init+28/190>
Trace; c0105000 <_stext+0/0>
Trace; c0105696 <kernel_thread+26/30>
Trace; c0105040 <init+0/190>
Code;  c0237e5f <cdrom_transfer_packet_command+6f/a0>
00000000 <_EIP>:
Code;  c0237e5f <cdrom_transfer_packet_command+6f/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0237e61 <cdrom_transfer_packet_command+71/a0>
   2:   16                        push   %ss
Code;  c0237e62 <cdrom_transfer_packet_command+72/a0>
   3:   03 9d 87 2f c0 68         add    0x68c02f87(%ebp),%ebx
Code;  c0237e68 <cdrom_transfer_packet_command+78/a0>
   9:   50                        push   %eax
Code;  c0237e69 <cdrom_transfer_packet_command+79/a0>
   a:   7c 23                     jl     2f <_EIP+0x2f> c0237e8e
<cdrom_transfer_packet_command+9e/a0>
Code;  c0237e6b <cdrom_transfer_packet_command+7b/a0>
   c:   c0 56 8b 74               rclb   $0x74,0xffffff8b(%esi)
Code;  c0237e6f <cdrom_transfer_packet_command+7f/a0>
  10:   24 28                     and    $0x28,%al
Code;  c0237e71 <cdrom_transfer_packet_command+81/a0>
  12:   56                        push   %esi
Code;  c0237e72 <cdrom_transfer_packet_command+82/a0>
  13:   53                        push   %ebx

--Adam


