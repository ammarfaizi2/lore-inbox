Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTJTPW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbTJTPW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:22:28 -0400
Received: from skuter.storm.com.pl ([195.116.229.161]:62473 "EHLO
	skuter.storm.com.pl") by vger.kernel.org with ESMTP id S262647AbTJTPWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:22:25 -0400
Message-ID: <3F93FD9F.4010306@storm.pl>
Date: Mon, 20 Oct 2003 17:22:07 +0200
From: =?ISO-8859-2?Q?Piotr_Wa=B6kiewicz?= <piter@storm.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6-test7 panic (appletalk related)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Box is dual pentium:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 451.023
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr
bogomips        : 888.83

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 451.023
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr
bogomips        : 899.07

Two network cards (don't remember names exactly), one on 3c59x, second 
on ne2k-pci.
Two networks: samba and netatalk (strange, but netatalk was idle at the 
moment).
HD on IDE.

After about two days uptime I got this panic (written off screen on 
paper, so might be errors in it):

EIP is at atalk_sum_skb+0x17d/0x1f0 [appletalk]
eax: 00000000 ebx: 00000011 ecx: 00000000 edx: dfb55be0
esi: 00000006 edi: 00000015 ebp: 00000015 esp: dc84de5c
ds: 007b es: 007b ss: 0068

Stack: dfb55bac 00000011 00000000 5596f951 8100000a 00000000 df90b400 
00000000 (sorry, but I haven't time to write more)

Call Trace:
[<e092210a>] atalk_chcecksum+0x2a/0x50 [appletalk]
[<e0922db0>] atalk_rcv+0x300/0x390 [appletalk]
[<c01100d0>] do_gettimeofday+0x20/0xad
[<e08e40d7>] snap_rcv+0x57/0xb0 [psnap]
[<e08cf4e6>] llc_rcv+0x196/0x280 [llc]
              netif_receive_skb
              process_backlog
              net_rx_action
              do_softirq
              do_IRQ
              common_interrupt

Code: 0f 0b f4 03 76 4b 92 e0 eb ea c7 44 24 0c e4 03 00 00 c7 44
<0> Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


HTH

