Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTAQW5X>; Fri, 17 Jan 2003 17:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTAQW5X>; Fri, 17 Jan 2003 17:57:23 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:44176 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261721AbTAQW5W>; Fri, 17 Jan 2003 17:57:22 -0500
Message-ID: <187d01c2be7d$17f07820$53572382@mzhangpc1>
From: "Mingye Zhang" <Mingye.Zhang@oracle.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel panic: not continuing do_aic7xxx_isr
Date: Fri, 17 Jan 2003 15:06:39 -0800
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

Hi, this is the first time I send email to this list in the hope that I may
get some help here...

I have a machine goes panic whenever I tranfer big files across network. It
is a Dell 1650 machine with 4GB memory, 2 CPUs. The kernel is 2.4.9-e.3smp.
It is a Red Hat Linux Advanced Server release 2.1AS/i686 (Pensacola). Here
is the screen dump:
Stack d1b5be2c 00000001 ce969180 c5339e5c c0118fa2 d1b5a000 00000282
00000202
      f3d461ac f3d46040 f2320720 f3d46178 c0203acc f3d4623c 006e6706
c0113b37
      000003ff 00000002 0000030d 00000000 f5aeb842 00000020 00000001
011d63dc
Call Trace:[<.....>]__wake_up[kernel]0x42
          [<.....>]tcp_v4_rcv[kernel]0x3cc
          [<.....>]smp_apic_time_interrupt[kernel]0x12b
          [<.....>]aic7xxx_isr[kernel]0x296
          [<.....>]net_rx_action[kernel]0x1eb
          [<.....>]do_aic7xxx_isr[aic7xxx]0x68
          [<.....>]handle_IRQ_event[kernel]0x5e
          [<.....>]do_IRQ[kernel]0xc1
          [<.....>]default_idle[kernel]0x0
          [<.....>]call_do_IRQ[kernel]0x5
          [<.....>]default_idle[kernel]0x0
          [<.....>]default_idle[kernel]0x2e
          [<.....>]cpu_idle[kernel]0x32
          [<.....>]__call_console_drivers[kernel]0x46
          [<.....>]call_console_drivers[kernel]0xeb

Code: 8b 07 0f b6 40  19 eb 05 b8 ff 00 00 00 50 31 ff 6a ff 55 0f
<0>Kernel panic: not continuing
In interrupt handler - not syncing

Thanks
Mingye

