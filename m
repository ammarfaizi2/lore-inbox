Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUCKMQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUCKMQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:16:58 -0500
Received: from mylinuxtime.de ([217.160.170.124]:170 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S261207AbUCKMQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:16:56 -0500
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: Oops on USB-bluetooth plug/unplug
Date: Thu, 11 Mar 2004 13:16:41 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403111316.41464.mail@earthworm.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I get an oops if I plug/unplug my USB-bluetooth device. This one occured after 
I plug and unplugged the device once, an plugged it again. System hangs 
completely after that. I'm running 2.6.4-rc3.

Oops: 0002 [#1]
PREEMPT
CPU: 0
EIP: 0060 [<c032f1f0>] Tainted: P
EFLAGS: 00010002
EIP is at urb_unlink+0x30/0xa0
eax: db7a695c ebx: 00000000 ecx: 00000000 edx: d5f80000
esi: 00000246 edi: db7a6954 ebp: dfc2edf0 edp: d5f81efc
ds: 007b es: 007b ss: 0068
Process hotplug (pid: 7054, threadinfo=d5f80000 task=d55005e0)
Stack: db7a6954 dfc2ec00 d5f81fc4 db7a6954 d5f81fc4 dfc2ec00 c032f9ab db7a6954
ab7a6954 d5f80000 db7a6954 c0340df0 dfc2ec00 db7a6954 d5f81fc4 d5f81fc4
dfc2edd0 dfc2edd0 dfc2ec00 d5f81fc4 c0340fd6 dfc2ec00 d5f81fc4 00000000
Call Trace:
[<c032f9ab>] usb_hcd_giveback_urb+0x1b/0x40
[<c0340df0>] uhci_finish_completion+0x60/0xa0
[<c0340fd6>] uhci_irq+0x116/0x180
[<c032fa06>] usb_hcd_irq+0x36/0x70
[<c010cda9>] handle_IRQ_event+0x49/0x80
[<c010d11f>] do_IRQ+0x8f/0x130
[<c010b568>] common_interrupt+0x18/0x20
Code: 89 59 04 89 0b 89 40 04 8b 5f 14 89 47 08 56 9d ff 4a 14 8b
<0> Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


These bt config options are set:

CONFIG_BT=y
CONFIG_BT_L2CAP=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y

CONFIG_BT_HCIUSB=y
CONFIG_BT_HCIBCM203X=y
CONFIG_BT_HCIBTUART=m


Please cc as I'm not subscribed to the list.

-- 
Christian Hesse
