Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWCaNBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWCaNBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCaNBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:01:42 -0500
Received: from erik-slagter.demon.nl ([83.160.41.216]:45198 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932096AbWCaNBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:01:41 -0500
Subject: OOPS 2.6.16 and 2.6.16-git14
From: Erik Slagter <erik@slagter.name>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 31 Mar 2006 15:01:28 +0200
Message-Id: <1143810088.15258.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a kernel OOPS using 2.6.16 and 2.6.16-git14, I was using 2.6.14.2
before without the problem.

The OOPS happens when doing either

echo "3" > /proc/acpi/sleep

or

echo "mem" > /sys/power/state

As I have a laptop without serial ports, I'd have to write down the
oops, so please forgive that I didn't write down ALL the output, I think
I have the most important stuff, though.

Please note that it also happens when mentioned modules are not linked
in and that I enabled the kernel read-only pages option (although that
doesn't seem to be related).

I am not subscribed, so please CC.

========================= OOPS ====================

hci_usb: 2-1:1.1: no suspend for driver hci_usb?
hci_usb: 2-1:1.0: no suspend for driver hci_usb?
kernel tried to execute NX-protected page - exploit attempt? (uid 0)
BUG: unable to handle kernel paging request at virtual address c04ce31
 
 Printing EIP
c04ce31c
*pde = 00000000
Oops: 0011 [#1]
Modules linked in: pl2303 usbserial ehci_hcd ipw2200 uhci_hcd
CPU: 0
EIP: 0060:[<c04ce31c>] Not tainted VLI
EFLAGS: 00010046 (2.6.16-git14 #4)
EIP is at 0x04ce31c
eax: c04dec00 ebx: c0001000 ecx: c000080 edx: 00000100
esi: 00000003 edi: 00000000 ebp: 0000046 esp: f4f0bef4
ds: 007b es: 007b ss: 0068
Process zsh (pid: 3657, threadinfo=f4f40a000, task=f4c0ea90)
Stack: <0>c0244b4e c04e3f08 00000000 ....
Call trace: acpi_pm_enter+0x53/0x99     suspend_enter+0x4f/0x60
            enter_state+0xde/0x160      state_store+0x97/0xc0
            state_store+0x0/0xc0        subsys_attr_store+0x29/0x40
            sysfs_write_file+0x93/0xf0  vfs_write+0xa6/0x160
            sysfs_write+0x0/0xf0        sys_write+0x41/0x70
            sysenter_past_esp+0x54/0x75


Config and Map not included, they are rather big. Submission on request.
