Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSESVRl>; Sun, 19 May 2002 17:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSESVRl>; Sun, 19 May 2002 17:17:41 -0400
Received: from [204.130.252.205] ([204.130.252.205]:64393 "EHLO
	www.JAMMConsulting.com") by vger.kernel.org with ESMTP
	id <S315120AbSESVRk>; Sun, 19 May 2002 17:17:40 -0400
From: "Neil Aggarwal" <neil@JAMMConsulting.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Kernel bug in RedHat 7.3 -- Assertion failure in journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
Date: Sun, 19 May 2002 16:18:25 -0500
Message-ID: <ENEBKGGOKDOEALIKAJMBOEIPCGAA.neil@JAMMConsulting.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

My RedHat 7.3 machine just locked up and I could not reboot it.  I had
to punch the reset button.

Here is what I found in the /var/log/messages file:
May 19 12:50:16 server1 kernel: Assertion failure in
journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
May 19 12:50:16 server1 kernel: ------------[ cut here ]------------
May 19 12:50:16 server1 kernel: kernel BUG at commit.c:535!
May 19 12:50:16 server1 kernel: invalid operand: 0000
May 19 12:50:16 server1 kernel: ipt_LOG ipt_state ip_conntrack
iptable_filter ip_tables autofs eepro100 usb-oh
May 19 12:50:16 server1 kernel: CPU:    1
May 19 12:50:16 server1 kernel: EIP:    0010:[<f88560e4>]    Not tainted
May 19 12:50:16 server1 kernel: EFLAGS: 00010286
May 19 12:50:16 server1 kernel:
May 19 12:50:16 server1 kernel: EIP is at journal_commit_transaction [jbd]
0xb04 (2.4.18-3smp)
May 19 12:50:16 server1 kernel: eax: 0000001c   ebx: 0000000a   ecx:
c02eee60   edx: 001830f4
May 19 12:50:16 server1 kernel: esi: f442edf0   edi: f54d0ec0   ebp:
f5fc6000   esp: f5fc7e78
May 19 12:50:16 server1 kernel: ds: 0018   es: 0018   ss: 0018
May 19 12:50:16 server1 kernel: Process kjournald (pid: 194,
stackpage=f5fc7000)
May 19 12:50:16 server1 kernel: Stack: f885ceee 00000217 f54d1000 00000000
00000fd4 f008d02c 00000000 f1cdf540
May 19 12:50:16 server1 kernel:        f442ef70 00002125 80000000 00000001
0000002c f54d1164 f00b5a40 e061d9e0
May 19 12:50:16 server1 kernel:        e061d5c0 e061d440 e0c80380 e03c73e0
e0bde320 e0c285c0 e08dcc00 e08dcba0
May 19 12:50:16 server1 kernel: Call Trace: [<f885ceee>] .rodata.str1.1
[jbd] 0x26e
May 19 12:50:16 server1 kernel: [<c0124eb5>] update_process_times [kernel]
0x25
May 19 12:50:16 server1 kernel: [<c0116049>] smp_apic_timer_interrupt
[kernel] 0xa9
May 19 12:50:16 server1 kernel: [<c010a77f>] do_IRQ [kernel] 0xdf
May 19 12:50:16 server1 kernel: [<c010758d>] __switch_to [kernel] 0x3d
May 19 12:50:16 server1 kernel: [<c0119048>] schedule [kernel] 0x348
May 19 12:50:16 server1 kernel: [<f88587d6>] kjournald [jbd] 0x136
May 19 12:50:17 server1 kernel: [<f8858680>] commit_timeout [jbd] 0x0
May 19 12:50:17 server1 kernel: [<c0107286>] kernel_thread [kernel] 0x26
May 19 12:50:17 server1 kernel: [<f88586a0>] kjournald [jbd] 0x0
May 19 12:50:17 server1 kernel:
May 19 12:50:17 server1 kernel:
May 19 12:50:17 server1 kernel: Code: 0f 0b 5a 59 6a 04 8b 44 24 18 50 56 e8
4b f1 ff ff 8d 47 48

Has anyone seen this?  Is there a way to fix it?

Thanks,
	Neil.
--
Neil Aggarwal
JAMM Consulting, Inc.    (972) 612-6056, http://www.JAMMConsulting.com
Custom Internet Development    Websites, Ecommerce, Java, databases

