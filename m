Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTL0UXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 15:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTL0UXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 15:23:18 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:53227 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S264563AbTL0UXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 15:23:12 -0500
Message-ID: <3FEDEA78.1090301@oracle.com>
Date: Sat, 27 Dec 2003 21:24:24 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-mm1 oops on boot (cpufreq related)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  hand-copied from the oopsed screen (but should be reliable...):


cpufreq: CPU0 - ACPI performance management activated
cpufreq: *P0: 1Mhz, 0 mW, 0 uS
cpufreq:  P1: 0Mhz, 0 mW, 0 uS
divide error: 0000 [#1]
PREEMPT
CPU:   0
EIP:   0060:[<c02cb03f>]   Not tainted VLI
EFLAGS: 00010246
EIP is at cpufreq_notify_transition+0xb2/0x17a
eax: 001b1000   ebx: 001b1000   ecx: 00000000   edx: 00000000
esi: c1a37f70   edi: 00000000   ebp: 0000008b   esp: c1a37fa8
ds: 007b   es: 007b   ss:0068
Process swapper (pid: 1, threadinfo=c1a36000 task=f7f9f980)
Stack: ffffff00 c01164d9 00000060 00000086 f7dab860 f7dab800 0000008b c01156d3
        c1a37f70 00000001 c1a37f60 c037b940 00000000 00000086 f7dab860 00000064
        01000000 c037b8e0 c037d37e 00000000 00000000 00000001 00000000 c1a37fa8
Call Trace:
  [<c01164d9>] delay_tsc+0xb/0x15
  [<c01156d3>] acpi_processor_set_performance+0x1e0/0x3e6
  [<c04652c1>] acpi_cpufreq_init+0x243/0x2a3
  [<c045e6e6>] do_initcalls+0x27/0x93
  [<c012c9e7>] init_workqueues+0xf/0x28
  [<c01070bd>] init+0x30/0x133
  [<c010708d>] init+0x0/0x133
  [<c0108f59>] kernel_thread_helper+0x5/0xb

Code: 08 39 4e 04 76 3e bf 1f 85 eb 51 8b 1d 50 fe 4a c0 89 f8 f7 e1 89 f8 89 d1 f7 25 54 fe 4a c0 89 d8 89 d7 c1 e9 05 31 d2 c1 ef 05 <f7> f7 89 d5 89 c3 31 d2 0f af e9 0f af d9 89 e8 f7 f7 01 d8 a3
  <0>Kernel panic: Attempted to kill init!


RedHat 9, Dell Latitude C640, PIV@1.8Ghz / 1GB RAM.

Using Preempt, highmem4g.

2.6.0 vanilla boots fine.

To build -mm1 I added CONFIG_INPUT_EVDEV (for Synaptics TouchPad) and
  removed CONFIG_SERIO_PCIPS2 (I realized I'll never use dockstations).

I'll be happy to follow up on this - just please CC: me directly, I
  only read l-k via the USSG mail archives. Thanks in advance, ciao,

--alessandro

  "Immagina intensamente e vedrai
    dove gli altri pensano che non ci sia niente"
       (Cristina Dona', "Salti nell'aria")


