Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753417AbWKCSDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbWKCSDB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbWKCSDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:03:01 -0500
Received: from mail.ggsys.net ([69.26.161.131]:43450 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1753417AbWKCSDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:03:00 -0500
Subject: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: linux-kernel@vger.kernel.org
Cc: mlord@pobox.com
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Fri, 03 Nov 2006 12:02:53 -0600
Message-Id: <1162576973.3967.10.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Pacific Digital qstor card on irq 193. I am using kernel
2.6.17.13 SMP

The error happens every now and then. I have not been able to
figure out any triggers and I can not reproduce it on demand. Today
it happened 3 times within a 40 minutes period. 

All disks connected to the card are disabled and I can't do anything
other than a reboot to get them back.

It is reported as follows:

irq 193: nobody cared (try booting with the "irqpoll" option)
 <c013e19a> __report_bad_irq+0x2a/0xa0  <c013d970> handle_IRQ_event
+0x30/0x70
 <c013e2b0> note_interrupt+0x80/0xf0  <c013da8c> __do_IRQ+0xdc/0xf0
 <c0105799> do_IRQ+0x19/0x30  <c010391a> common_interrupt+0x1a/0x20
 <c0100d91> default_idle+0x41/0x70  <c0100e60> cpu_idle+0x80/0x90
 <c046699d> start_kernel+0x18d/0x1d0  <c0466330> unknown_bootoption
+0x0/0x1d0
handlers:
[<c0301300>] (qs_intr+0x0/0x220)
Disabling IRQ #193

The PCI info for the card is:

0000:01:03.0 0106: Pacific Digital Corp: Unknown device 2068 (rev 01)
        Subsystem: Pacific Digital Corp: Unknown device 2068
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
        I/O ports at eff0 [size=8]
        I/O ports at efe0 [size=8]
        I/O ports at efa8 [size=8]
        I/O ports at efa0 [size=8]
        Memory at febf0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: [40] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [50] Power Management version 2
        Capabilities: [58] PCI-X non-bridge device.


This is really creating problems for me now. If anybody knows
of a dumb (ie. non-raid) PCI SATA card with 8 ports with good
Linux support for a couple hundred backs I would appreciate
it.

If there is any other info that I should provide to help 
troubleshoot please let me know.

Thanks,

Alberto


-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

