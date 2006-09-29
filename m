Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWI2CNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWI2CNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbWI2CNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:37 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12976 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030215AbWI2CNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=da2vlBlUYYP4uILSRygFDDI6CR+Vq4iijNaCOgr0NwsuDmsw4m0vI5wEfNRnK56WN+m3znxcgHi5pp0H/4A6h+IxtxL4NN47II7Xx9r3WE3XIt1IqIAfr8/wJjFTKM1LfbtFh90cAeRottwKIWfsDSmxnfvjkL0Kh3yzrpcute4=
Message-ID: <a44ae5cd0609281913q127abc03i72dc7ea8711a223f@mail.gmail.com>
Date: Thu, 28 Sep 2006 19:13:23 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>, jgarzik@pobox.com
Subject: 2.6.18-mm2 -- EIP: [<c11a962e>] klist_node_init+0x2b/0x3a SS:ESP 0068:f63a5f80
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eth1: RealTek RTL8139 at 0xf9076800, 00:c0:9f:95:18:1b, IRQ 19
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
BUG: unable to handle kernel NULL pointer dereference at virtual
address 000000d0
 printing eip:
c11a962e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
last sysfs file: /class/firmware/0000:01:06.0/loading
Modules linked in: shpchp pci_hotplug intel_agp i2c_i801 agpgart
snd_intel8x0 i2c_core snd_intel8x0m snd_ac97_codec snd_ac97_bus
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
snd_pcm_oss snd_mixer_oss ata_generic ata_piix libata 8139too sdhci
scsi_mod snd_pcm snd_timer psmouse snd soundcore snd_page_alloc 8139cp
mii yenta_socket rsrc_nonstatic pcmcia_core ohci1394 serio_raw ipw2200
ieee1394 ide_cd cdrom rtc unix ehci_hcd ohci_hcd uhci_hcd usbcore ext3
jbd mbcache
CPU:    0
EIP:    0060:[<c11a962e>]    Not tainted VLI
EFLAGS: 00010296   (2.6.18-mm2 #8)
EIP is at klist_node_init+0x2b/0x3a
eax: dff16b08   ebx: 000000a0   ecx: c102ebd7   edx: f63a5f44
esi: dff16afc   edi: f910e214   ebp: f63a5f88   esp: f63a5f80
ds: 007b   es: 007b   ss: 0068
Process probe-0000:01:0 (pid: 1697, ti=f63a4000 task=f639c030 task.ti=f63a4000)
Stack: 000000a0 dff16afc f63a5f98 c11a964f dff16a80 dff16afc f63a5fac c1124295
       00000000 dff16a80 f910e214 f63a5fc4 c1124338 f5c17e80 f5c17e80 f633bd90
       c11242f0 f63a5fe0 c102a834 ffffffff ffffffff c102a784 00000000 00000000
Call Trace:
 [<c11a964f>] klist_add_tail+0x12/0x38
 [<c1124295>] device_bind_driver+0x45/0xa0
 [<c1124338>] really_probe+0x48/0xb3
 [<c102a834>] kthread+0xb0/0xdc
 [<c1003abb>] kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

Leftover inexact backtrace:

 [<c1003f02>] show_trace_log_lvl+0x12/0x25
 [<c1003fa1>] show_stack_log_lvl+0x8c/0x97
 [<c100412c>] show_registers+0x180/0x214
 [<c1004355>] die+0x195/0x2b0
 [<c10148a9>] do_page_fault+0x419/0x4e4
 [<c11ac329>] error_code+0x39/0x40
 [<c11a964f>] klist_add_tail+0x12/0x38
 [<c1124295>] device_bind_driver+0x45/0xa0
 [<c1124338>] really_probe+0x48/0xb3
 [<c102a834>] kthread+0xb0/0xdc
 [<c1003abb>] kernel_thread_helper+0x7/0x10
 =======================
Code: 55 89 e5 56 53 89 c3 89 d6 8d 42 04 89 42 04 89 40 04 c7 42 10
00 00 00 00 8d 42 14 e8 f2 14 e8 ff 8d 46 0c e8 80 3d f1 ff 89 1e <8b>
53 30 85 d2 74 04 89 f0 ff d2 5b 5e 5d c3 55 89 e5 56 53 89
EIP: [<c11a962e>] klist_node_init+0x2b/0x3a SS:ESP 0068:f63a5f80
 <6>ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
