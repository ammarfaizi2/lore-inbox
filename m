Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTDERbd (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 12:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTDERbd (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 12:31:33 -0500
Received: from [203.197.168.150] ([203.197.168.150]:3854 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S262563AbTDERbc (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 12:31:32 -0500
Message-ID: <3E8F1645.1F4BD93B@tataelxsi.co.in>
Date: Sat, 05 Apr 2003 23:15:41 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel panic for cardbus adapter - please help
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We are using Madge 16/4 MK 2 CardBus Adapter in Redhat linux 8.0 on
Comapaq laptop i586.
We are using pcmcia-cs 3.2.4 source tree which we have compiled and
installed.
The problem we are facing is when we are plugging out the adapter from
the socket, it's giving the following dump and the processor hangs.
We have to restart the laptop after that. It's happening everytime. The
same thing happens for pcmcia-cs 3.1.31 source tree also.


    [<c28801fe>] cb_release [cb_enabler] 0xee (0xc02e5e38))
[<c2880e20>] bus_table [cb_enabler] 0x0 (0xc02e5e50))
[<c2880268>] cb_event [cb_enabler] 0x5e (0xc02e5e58))
[<c01ab820>] multiwrite_intr [kernel] 0x0 (0xc02e5e64))
[<c286178e>] send_event [pcmcia-core] 0x46 (0xc02e5e88))
[<c2861867>] parse_event [pcmcia-core] 0x11f (0xc02e5eb8))
[<c28876d2>] common_housekeeping [mtok] 0x3a (0xc02e5ecc))
[<c2875db4>] socket [i82365] 0x54 (0xc02e5ed8))
[<c286d211>] pcic_interrupt [i82365] 0x17d (0xc02e5ee8))
[<c0109d5d>] handle_IRQ_event [kernel] 0x3d (0xc02e5f28))
[<c2875d60>] socket [i82365] 0x0 (0xc02e5f30))
[<c0109ee8>] do_IRQ [kernel] 0x78 (0xc02e5f48))
[<c010c378>] call_do_IRQ [kernel] 0x5 (0xc02c5f68))
[<c0113326>] apm_bios_call_simple [kernel] 0x56 (0xc02e5f94))
[<c011330d>] apm_bios_call_simple [kernel] 0x3d (0xc02e5fa0))
[<c0113422>] apm_do_idle [kernel] 0x12 (0xc02e5fbc))
[<c0113543>] apm_cpu_idle [kernel] 0xb3 (0xc02e5fd4))
[<co105000>] stext [kernel] 0x0 (0xc02e5fe4))
[<c0106e8b>] cpu_idle [kernel] 0x1b (0xc02e5fec))

Code: 0f 0b ae 00 9b 5f 22 c0 58 5a e9 7c fe ff ff 90 90 8d b4 26
<0>Kernel panic: Aiee, killing interrupt handler'
In interrupt handler - not syncing

Any idea what can be wrong?

Thanks in advance
Prasanta

