Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293028AbSCAIqX>; Fri, 1 Mar 2002 03:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310404AbSCAIk1>; Fri, 1 Mar 2002 03:40:27 -0500
Received: from www.ms-itti.com.pl ([217.8.167.50]:55556 "HELO
	smtp.ms-itti.com.pl") by vger.kernel.org with SMTP
	id <S310416AbSCAIiu>; Fri, 1 Mar 2002 03:38:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marcin Gogolewski <marcing@ms-itti.com.pl>
Organization: Mobile Solutions -ITTI
To: linux-kernel@vger.kernel.org
Subject: Oops with ACPI (in sched:566)
Date: Fri, 1 Mar 2002 09:39:08 +0100
X-Mailer: KMail [version 1.3.2]
X-Sun-Data-Name: text
X-Sun-Data-Description: text
X-Sun-Data-Type: postscript-file
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020301083856Z310416-889+110389@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have STL2 machine, if I compile kernel (2.4.18) with ACPI I got:
[...] (I hope this is OK, I write it down from monitor ;-) )
ACPI: Core Subsystem version [20011018]
Scheduling in interrupt
kernel BUG at sched:566!
invalid operand
CPU:0
EIP:0010:[<c0117546>] Not tainted
EFLAGS: 00010286
eax: 0x16 ebx: 0x0 ecx:c02d2764 edx:00002480
esi:ffdf4000 edi: 0x0 ebp: f7df5fd4 esp:f7df5f9c

ds:0018 es: 0018 ss:0018
Process ksoftirq_CPU0(pid:3, stackpage=f7df5000)
Stack: c02918e2 00000236 00000000 00000000 00000018 c0320018 f7df4000 c0121660
00000000 f7df4000 00000246 00000000 f7df4000 f7df4000 00000000 c0121ca1
00000000 00010f00 c2113fac 00000000 c0350f40 c0105766 00000000 c0121bb0
Call Trace:[<c0121660>][<c0121ca1>][<c0105766>][<c0121bb0>]
Code:0f 0b 56 5e 8b 55 ec 8b 4a 1c 85 c9 78 3e 81 3d 04 84 32 c0
<0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
[...]

without ACPI there isn't any problem, with ACPI in (I think) 50% starts.

My system:
Intel STL2 with 2xPIII 1 GHz, I can enclose details (lcpci, etc.)
I can't do more tests (it's a production machine).

                                        Marcin
