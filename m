Return-Path: <linux-kernel-owner+w=401wt.eu-S1751682AbWLNVCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWLNVCY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWLNVCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:02:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbWLNVCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:02:22 -0500
Date: Thu, 14 Dec 2006 16:02:15 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.20rc1 oops.
Message-ID: <20061214210215.GC22164@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Puzzling.

		Dave

USB Universal Host Controller Interface driver v3.0
Compaq SMART2 Driver (v 2.6.0)
BUG: unable to handle kernel paging request at virtual address e082a736
 printing eip:
e082a736
*pde = 1fd4e067
Oops: 0000 [#1]
SMP 
last sysfs file: /block/ram0/dev
Modules linked in: cpqarray ext3 jbd mbcache ehci_hcd ohci_hcd uhci_hcd
CPU:    2
EIP:    0060:[<e082a736>]    Not tainted VLI
EFLAGS: 00010292   (2.6.19-1.2872.fc7 #1)
EIP is at 0xe082a736
eax: 00000040   ebx: dfc66000   ecx: ffffffff   edx: 00000046
esi: e0810cc0   edi: dfc66000   ebp: dfea8ac0   esp: df67ff4c
ds: 007b   es: 007b   ss: 0068
Process probe-0000:02:0 (pid: 290, ti=df67f000 task=dfec12d0 task.ti=df67f000)
Stack: e080e2ab 0000ae10 00000002 00000000 00000000 c0667edb df646967 c04aa7f2 
       0000a1ff 00000020 e0810d18 e0810cf4 c04e6835 e080d97c e0810cf4 e0810cc0 
       dfc66000 dfea8ac0 c04e6921 dfc66048 dfe99da8 e0810cf4 c054953e 00000286 
Call Trace:
Inexact backtrace:
 [<c04aa7f2>] sysfs_create_link+0x128/0x13e
 [<c04e6835>] pci_match_device+0x13/0xb3
 [<c04e6921>] pci_device_probe+0x36/0x57
 [<c054953e>] really_probe+0x7f/0x103
 [<c04208cb>] complete+0x39/0x48
 [<c05494bf>] really_probe+0x0/0x103
 [<c0438997>] kthread+0xb0/0xd9
 [<c04388e7>] kthread+0x0/0xd9
 [<c0404b77>] kernel_thread_helper+0x7/0x10
 =======================
Code:  Bad EIP value.
EIP: [<e082a736>] 0xe082a736 SS:ESP 0068:df67ff4c
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():0, irqs_disabled():1
 [<c04050df>] dump_trace+0x68/0x1d8
 [<c0405267>] show_trace_log_lvl+0x18/0x2c
 [<c04057f5>] show_trace+0xf/0x11
 [<c0405867>] dump_stack+0x12/0x14
 [<c043b45a>] down_read+0x12/0x28
 [<c0433220>] blocking_notifier_call_chain+0xe/0x29
 [<c04297a4>] do_exit+0x19/0x6d5
 [<c0405796>] die+0x21b/0x240
 [<c05ed41b>] do_page_fault+0x407/0x4da
 [<c05ebc7c>] error_code+0x7c/0x84
 [<e082a736>] 0xe082a736
DWARF2 unwinder stuck at 0xe082a736
Leftover inexact backtrace:
 [<c04aa7f2>] sysfs_create_link+0x128/0x13e
 [<c04e6835>] pci_match_device+0x13/0xb3
 [<c04e6921>] pci_device_probe+0x36/0x57
 [<c054953e>] really_probe+0x7f/0x103
 [<c04208cb>] complete+0x39/0x48
 [<c05494bf>] really_probe+0x0/0x103
 [<c0438997>] kthread+0xb0/0xd9
 [<c04388e7>] kthread+0x0/0xd9
 [<c0404b77>] kernel_thread_helper+0x7/0x10
 =======================
SCSI subsystem initialized


-- 
http://www.codemonkey.org.uk
