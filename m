Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317955AbSGPUiA>; Tue, 16 Jul 2002 16:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317954AbSGPUh7>; Tue, 16 Jul 2002 16:37:59 -0400
Received: from server1.mvpsoft.com ([64.105.236.213]:4531 "HELO
	server1.mvpsoft.com") by vger.kernel.org with SMTP
	id <S317955AbSGPUh5>; Tue, 16 Jul 2002 16:37:57 -0400
Message-ID: <3D345AD7.1010509@mvpsoft.com>
Date: Tue, 16 Jul 2002 13:41:43 -0400
From: Chris Snyder <csnyder@mvpsoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020714
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel panics on bootup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get my Intergraph dual-P133 to boot.  The model number, 
according to the back of the case, is JHIF60H70.  Here's the error 
messages that are being displayed:

Intel Pentium with F0 0F bug - workaround enabled.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium 75 - 200 stepping 0b
per-CPU timeslice cutoff: 160.14 usecs.
SMP motherboard not detected.
Local APIC not detected.  Using dummy APIC emulation.
Waiting on wait_init_idle (map=0x0)
All processors have done init_idle
general protection fault: 6d60
CPU: 
0
EIP: 
0010:[<c00f6e1e>] 
Not tainted
EFLAGS: 
00016757
eax: 49435024	ebx: 00000000	ecx: 00000000	edx: 00000010
esi: c02d7fc0	edi: c02bee74	ebp: 49435024	esp: c1415f84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1415000)
Stack: 00000010 c00f6d60 c02d7fc0 00000000 0008e000 00000292 00000079 
c02dc291
49435024 c000f6d60 c02d7fc0 00000000 0008e000 00000018 ffffff00 c02dc450
00000010 c02dc443 c1414000 c02dcaf 2 c02dcb76 c02effbe c1414000 c02d88de
Call Trace: [<c0105295>] [<c01057cc>]

Code: cb 66 9d f9 eb fa e8 27 04 00 00 b4 00 f8 c3 e8 1e 04 00 00\
  <0>Kernel panic: Attempted to kill init!

(note: I typed these in by hand, on a teeny notebook keyboard.  If 
anything seems outrageous, let me know, and I'll verify it)
Kernel version is 2.4.18.  I noticed that it doesn't notice that there's 
an SMP motherboard - perhaps that has something to do with it?  This 
system has 256 MB EDO RAM (72 pin), a Mylex DAC960 RAID controller, a 
built-in SCSI controller (not sure what chipset, but supported by 
generic SCSI), and a tulip-based net card.  I'm attempting to boot it 
off of a SCSI Zip drive connected to the built-in SCSI (no bootable CD 
support).  This system was previously running NT4 SMP with no problems 
(well, other than the normal NT problems<g>).  Thanks in advance.

