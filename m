Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUC0CZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 21:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUC0CZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 21:25:55 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:42452 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S261629AbUC0CZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 21:25:52 -0500
Message-ID: <4064E81C.1000802@rgadsdon2.giointernet.co.uk>
Date: Sat, 27 Mar 2004 02:34:04 +0000
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2 - panic when slocate.cron job accesses firewire disk
 (untainted)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still the same result (panic) _without_ any nvidia and vmware 'taint':
(Thanks to Denis Vlasenko for pointing this out..)
------------------------------------------------------------------------
EFLAGS: 00010047 (2.6.5-rc2)
EIP is at hpsb_packet_sent+0x27/0x90 [ieeeI394]
eax: 00100100 ebx: f6158000 ecx: e0ba4860 edx: 00200200
esi: 00000001 edi: e0ba4860 ebp: f615a060 esp: c1a3fefc
ds: 007b es: 007b ss: 0068
Process swapper (pid: 0, threadinfo=cla3e000 task=f7f7dI50)
Stack: f615a1a4 f890a9e8 f6158000 e0ba4860 00000001 f89e49b0 f615a1d0 
00000282
        f615a1e4 00000000 c1a3e000 c04c55c0 c0124c03 f615a1a4 00000001 
c0495fa8
        0000000a 00000046 c0124937 c0495fa8 c1a3e000 c1a3e000 00000009 
00000020
Call Trace:
[<f890age8>] dma trm tasklet+0xa8/0x1b0 [ohci1394]
[<f8ge49b0>] abort timedouts+0x0/0x160 [ieee1394]
[<c0124c03>] tasklet_action+0x73/0xe0
[<c0124937>] do_softirq+0xc7/0xd0
[<c018b77b>] do_IRQ+0x13b/0x1a0
[<c01089a8)] common_interrupt+0x18/0x20
[<c8186970)] default_idle+0x0/0x40
[<c810699c)] default_idle+0x2c/0x40
[<c8106a2b)] cpu_idle+0x3b/0x50
[<c8120bb8)] printk+0x178/0x1f0

Code: 09 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 c6 41
<0>Kernel panic: Fatal exception In Interrupt
In Interrupt handler - not syncing
-------------------------------------------------------------------

Robert Gadsdon.


Denis Vlasenko wrote:

 > On Tuesday 23 March 2004 03:25, Robert Gadsdon wrote:
 >
 >> I get the following when the slocate.cron job accesses the first of 3
 >> 120GB firewire disks:
 >> -------------------------------------------------------------
 >> EIP:   0060:[<f89e3a27>]   Tainted:  P
 >
 >
 >                              ^^^^^^^^^^^
 > Can you reproduce with non-tainted setup?
