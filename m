Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbUC3MSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUC3MSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:18:04 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:2784 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S263627AbUC3MR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:17:58 -0500
Message-ID: <40696781.1030008@rgadsdon2.giointernet.co.uk>
Date: Tue, 30 Mar 2004 13:26:41 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5-rc3 panic - hpsb_packet_sent
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When updatedb accesses the first ieee1394 disk:
(output ocr'ed and transcribed...)
  -----------------------------------------------------------
PREEMPT SMP
CPU: 0
EIP:	0060:[<f8a0fa27>]	Not tainted
EFLAGS: 00010047 (2.6.5-rc3)
EIP is at hpsb_packet_sent+0x27/0x90 [ieee1394]
eax: 00100100 ebx: f2bf8000 ecx: db550ec0 edx: 00200200
esi: 00000001 edi: db550ec0 ebp: f2bfa078 esp: c042df14
ds: 007b es: 007b ss: 0068
Process swapper (pid: 0, threadinfo=c042c000 task=c03a9160)
Stack: f2bfa1bc f89329e8 f2bf8000 db550ec0 00000001 f2df2080 f2bfa1e8 
00000292
        f2bfa1fc 00000000 c042c000 c045b5d8 c0127df3 f2bfa1bc 00000001 
c042a028
        0000000a 00000046 c0127b27 c042a028 c042c000 c042c000 00000009 
00000020
Call Trace:
  [<f89329e8>] dma_trm_tasklet+0xa8/0x1b0 [ohci1394]
  [<c0127df3>] tasklet_action+0x73/0xe0
  [<c0127b27>] do_softirq +0xc7/0xd0
  [<c010b84b>] do_IRQ+0x13b/0x1a0
  [<c0109928>] common_interrupt+0x10/0x20
  [<c0106970>] default_idle+0x0/0x40
  [<c011007b>] get_cmos_time+0xfb/0x210
  [<c010699c>] default_ldle+0x2c/0x40
  [<c0106a2b>] cpu_idle+0x3b/0x50
  [<c042e4c0>] unknown_bootoption+0x0/0x120
  [<c042e95b>] start_kernel+0x1bb/0x218
  [<c042e4c0>] unknown_bootoption+0x0/0x120

Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 c6 41
  <0>Kernel panic: Fatal exception in interrupt
In Interrupt handler - not syncing
-----------------------------------------------------------

Similar problem occurred with 2.6.4 and 2.6.5-rc1/2


Robert Gadsdon
