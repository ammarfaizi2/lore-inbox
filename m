Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUAaLqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 06:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUAaLqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 06:46:46 -0500
Received: from mylinuxtime.de ([217.160.170.124]:63641 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S264549AbUAaLqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 06:46:42 -0500
Message-ID: <32970.80.144.43.225.1075549599.squirrel@www.lugor.de>
Date: Sat, 31 Jan 2004 12:46:39 +0100 (CET)
Subject: silly noise with module acpi/processor
From: "Christian Hesse" <mail@earthworm.de>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.23.0.3; VDF: 6.23.0.53; host: mylinuxtime.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using Linux (kernel 2.6.2-rc3) on my Samsung X10 (Pentium M 1.4 GHz,
Centrino) notebook. If I boot the system without ac-adapter connected and
then modprobe the module processor the notebook makes a really silly
noise. The noise disappears with load (i.e.starting a program) but
reappears as soon as the processor ist idle again. Plugging in the
ac-adapter fixes the problem. Disconnecting the adapter is no problem.
Scaling down cpu-frequency makes the noise quiete, but it still resists.

rmmod processor brings an oops:
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e1cdf28f>]    Tainted: P
EFLAGS: 00010296
EIP is at 0xe1cdf28f
eax: 00000000   ebx: 001bdf10   ecx: 00000008   edx: 00000000
esi: d36f92f8   edi: 001bd989   ebp: d36f9200   esp: c04c5fc0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c04c4000 task=c043a6e0)
Stack: 00099800 00000000 c04c4000 00099800 c0105000 0008e000 c0108a04
00000816
c04c6745 c043a6e0 00000000 c04e77e8 0000001b c04c6470 c04ef020 c010017e
Call Trace:
[<c0105000>] _stext+0x0/0x60
[<c0108a04>] cpu_idle+0x34/0x40
[<c04c6745>] start_kernel+0x185/0x1c0
[<c04c6470>] unknown_bootoption+0x0/0x120

Code:  Bad EIP value.
<0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


Same behavior with 2.6.2-rc2 before the acpi update.

With 2.6.2-rc2-mm1 the noise still resists if I plug in the ac-adapter.

Let me know if you need additional information. Please cc me as I'm not
subscribed to the list.

-- 
Christian Hesse
