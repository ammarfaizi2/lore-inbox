Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUDDUOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 16:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUDDUOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 16:14:06 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:33673 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S262742AbUDDUOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 16:14:03 -0400
Message-ID: <40706EA2.7040900@rgadsdon2.giointernet.co.uk>
Date: Sun, 04 Apr 2004 21:22:58 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5 - panic when intensive disk access on 120GB firewire disk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic from 2.6.5 'final' when running slocate (updatedb) 
accessing 120GB firewire disk:

Oops: 00002 [#1]
PREEMPT SMP
CPU: 0
EIP: 0060:[<f8a10a27>]  Not tainted
EFLAGS: 00010047 (2.6.5)
EIP is at hpsb_packet_sent+0x27/0x90 [ieee1394]
eax: 00100100 ebx: f76e0000 ecx: e1fea3c0 edx: 00200200
esi: 00000001 edi: e1fea3c0 ebp: f76e2078 esp: c042df14
ds : 007b es: 007b ss : 0068
Process swapper (pid: 0, threadinfo=c042c000 task=c03aa160)
Stack: f76e21bc f89329e8 f76e0000 e1fea3c0 00000001 f75f8da0 f76e21e8 
00000292
        f76e21fc 00000000 c042c000 c045b5d8 c0127d93 f76e21bc 00000001 
c042b028
        0000000a 00000046 c0127ac7 c042b028 c042c000 c042c000 00000009 
00000020
Call Trace :
  [<f89329e8>] dma_trm_tasklet+0xa8/0x1b0 [ohci1394]
  [<c0127d93>] tasklet_action+0x73/0xe0
  [<c0127ac7>] do_softirq+0xc7/0xd0
  [<c010b82b>] do_IRQ+0x13b/0x1a0
  [<c0109928>] common_interrupt+0x18/0x20
  [<c0106970>] default_idle+0x0/0x40
  [<c010699c>] default_idle+0x2c/0x40
  [<c0106a2b>] cpu_idle+0x3b/0x50
  [<c042e4c0>] unknown_bootoption +0x0/0x120
  [<c042e95b>] start_kernel+0x1bb/0x210
  [<c042e4c0>] unknown_bootoption+0x0/0x120

Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 c6 41
  <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


Similar problem with 2.6.4 and 2.6.5-rc and 2.6.5-rc-mm kernels, and is 
100% repeatable..


Robert Gadsdon
