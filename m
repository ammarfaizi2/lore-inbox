Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUHSAua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUHSAua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUHSAua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:50:30 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:49389 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S267772AbUHSAu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:50:26 -0400
Message-ID: <4123F9B5.4020702@softhome.net>
Date: Wed, 18 Aug 2004 17:52:05 -0700
From: Brannon Klopfer <plazmcman@softhome.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1: kernel panic rmmod'ing apm
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux littleblue 2.6.8.1 #81 Wed Aug 18 17:13:39 PDT 2004 i686 unknown 
unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib 
snd_mpu401_uart snd_rawmidi snd_cs4231_lib nfsd exportfs intel_agp 
uhci_hcd serial_cs 3c574_cs ds yenta_socket pcmcia_core agpgart

-----------------------------

Hello,
    When rmmod'ing apm, I get a kernel panic. However, the machine 
continues to function properly, AFAIK. Here's the dmesg:

[snip]
Unable to handle kernel paging request at virtual address d2d9f211
 printing eip:
d2d9f211
*pde = 01357067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib 
snd_mpu401_uart snd_rawmidi snd_cs4231_lib nfsd exportfs intel_agp 
uhci_hcd serial_cs 3c574_cs ds yenta_socket pcmcia_core agpgart
CPU:    0
EIP:    0060:[<d2d9f211>]    Not tainted
EFLAGS: 00010246   (2.6.8.1)
EIP is at 0xd2d9f211
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: c03c0000
esi: 00011ff9   edi: 00000202   ebp: 00000001   esp: c03c0f84
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03c0000 task=c033fa40)
Stack: 00005305 00000000 00000000 00090000 c03e0000 c03c0000 00011ff9 
0000000a
       00000001 d2d9f373 00005305 00000000 00000000 c03c0fbc 00005305 
d2d9f4ab
       c03c0000 00099100 c03e0120 00423007 c0102164 c03c0000 c03c1723 
c033fa40
Call Trace:
 [<c0102164>] cpu_idle+0x34/0x40
 [<c03c1723>] start_kernel+0x163/0x180
 [<c03c1340>] unknown_bootoption+0x0/0x160
Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 
[END]

After that, the module is gone, and everything works fine. I just tried 
inserting and removeing it subsequent times, and it works with no errors 
(so far). I only rmmod when apm is used by nothing.

The only reason I'm messing around with the apm module is that Loki's UT 
seems to (sometimes) run much too fast with APM support in kernel, and 
rmmod'ing it out seems to do the trick. This is probably indicitive of 
another problem, though my system seems pretty stable (other than that 
kernel panic...).

All said, this doesn't bother me, as my system stays up.

-Brannon Klopfer
