Return-Path: <linux-kernel-owner+w=401wt.eu-S1753952AbWLWXzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbWLWXzS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbWLWXzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 18:55:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33130 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753952AbWLWXzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 18:55:16 -0500
Date: Sun, 24 Dec 2006 00:55:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20061223235501.GA1740@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061223234305.GA1809@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I got this nasty oops while playing with debugger. Not sure if that is
> related; it also might be something with bluetooth; I already know it
> corrupts memory during suspend, perhaps it corrupts memory in some
> error path?

Okay, I spoke too soon. bluetooth & suspend memory corruption was
_way_ harder to reproduce than expected. Took me 5-or-so-suspend
cycles... so it is probably unrelated to the previous crash.

I was getting pretty regular crashes with bluetooth & gdb, but I was
not using bluetooth at the time of ext3-related crash.

								Pavel

acpi acpi: resuming
__tx_submit: hci0 tx submit failed urb c20efb08 type 2 err -113
agpgart-intel 0000:00:00.0: resuming
pci 0000:00:02.0: resuming
pci 0000:00:02.1: resuming
PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
HDA Intel 0000:00:1b.0: resuming
PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100102)
PCI: Setting latency timer of device 0000:00:1b.0 to 64
pci 0000:00:1c.0: resuming
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pci 0000:00:1c.1: resuming
PCI: Setting latency timer of device 0000:00:1c.1 to 64
pci 0000:00:1c.2: resuming
PCI: Setting latency timer of device 0000:00:1c.2 to 64
pci 0000:00:1c.3: resuming
PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 8070)
PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100107)
PCI: Setting latency timer of device 0000:00:1c.3 to 64
uhci_hcd 0000:00:1d.0: resuming
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb4: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: resuming
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb2: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: resuming
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb5: root hub lost power or was reset
uhci_hcd 0000:00:1d.3: resuming
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb3: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: resuming
PCI: Setting latency timer of device 0000:00:1d.7 to 64
pci 0000:00:1e.0: resuming
PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
PIIX_IDE 0000:00:1f.1: resuming
ahci 0000:00:1f.2: resuming
PCI: Setting latency timer of device 0000:00:1f.2 to 64
pci 0000:00:1f.3: resuming
pci 0000:02:00.0: resuming
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was 100107, writing 100103)
pci 0000:03:00.0: resuming
yenta_cardbus 0000:15:00.0: resuming
ohci1394 0000:15:00.1: resuming
PM: Writing back config space on device 0000:15:00.1 at offset 4 (was 0, writing e4301000)
PM: Writing back config space on device 0000:15:00.1 at offset 3 (was 800000, writing 804000)
PM: Writing back config space on device 0000:15:00.1 at offset 1 (was 2100000, writing 2100006)
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[e4301000-e43017ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
sdhci 0000:15:00.2: resuming
PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
system 00:00: resuming
pnp 00:01: resuming
system 00:02: resuming
pnp 00:03: resuming
pnp 00:04: resuming
pnp 00:05: resuming
pnp 00:06: resuming
pnp 00:07: resuming
i8042 kbd 00:08: resuming
pnp: Device 00:08 does not support activation.
i8042 aux 00:09: resuming
pnp: Device 00:09 does not support activation.
pnp 00:0a: resuming
pnp 00:0b: resuming
platform bluetooth: resuming
pcspkr pcspkr: resuming
vesafb vesafb.0: resuming
serial8250 serial8250: resuming
usb usb1: resuming
hub 1-0:1.0: resuming
usb usb2: resuming
hub 2-0:1.0: resuming
usb usb4: resuming
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
usb usb5: resuming
hub 4-0:1.0: resuming
hub 5-0:1.0: resuming
usb usb3: resuming
hub 3-0:1.0: resuming
i8042 i8042: resuming
atkbd serio0: resuming
psmouse serio1: resuming
mmcblk mmc0:cc53: resuming
sd 0:0:0:0: resuming
usb 3-2: resuming
 usbdev3.14_ep00: PM: resume from 0, parent 3-2 still 2
usb 3-2:1.0: PM: resume from 2, parent 3-2 still 2
usb 3-2:1.0: resuming
 usbdev3.14_ep81: PM: resume from 0, parent 3-2:1.0 still 2
 usbdev3.14_ep02: PM: resume from 0, parent 3-2:1.0 still 2
 usbdev3.14_ep83: PM: resume from 0, parent 3-2:1.0 still 2
usb 3-1: resuming
 usbdev3.15_ep00: PM: resume from 0, parent 3-1 still 2
hci_usb 3-1:1.0: PM: resume from 2, parent 3-1 still 2
hci_usb 3-1:1.0: resuming
 hci0: PM: resume from 0, parent 3-1:1.0 still 2
 usbdev3.15_ep81: PM: resume from 0, parent 3-1:1.0 still 2
 usbdev3.15_ep82: PM: resume from 0, parent 3-1:1.0 still 2
 usbdev3.15_ep02: PM: resume from 0, parent 3-1:1.0 still 2
hci_usb 3-1:1.1: PM: resume from 2, parent 3-1 still 2
hci_usb 3-1:1.1: resuming
 usbdev3.15_ep83: PM: resume from 0, parent 3-1:1.1 still 2
 usbdev3.15_ep03: PM: resume from 0, parent 3-1:1.1 still 2
usb 3-1:1.2: PM: resume from 2, parent 3-1 still 2
usb 3-1:1.2: resuming
 usbdev3.15_ep84: PM: resume from 0, parent 3-1:1.2 still 2
 usbdev3.15_ep04: PM: resume from 0, parent 3-1:1.2 still 2
usb 3-1:1.3: PM: resume from 2, parent 3-1 still 2
usb 3-1:1.3: resuming
Restarting tasks ... <6>usb 3-1: USB disconnect, address 15
PM: Removing info for No Bus:usbdev3.15_ep81
PM: Removing info for No Bus:usbdev3.15_ep82
PM: Removing info for No Bus:usbdev3.15_ep02
slab error in verify_redzone_free(): cache `size-512': memory outside object was overwritten
 [<c016a1b8>] cache_free_debugcheck+0x128/0x1d0
 [<c04b58e3>] hci_usb_close+0xf3/0x160
 [<c016b530>] kfree+0x50/0xa0
 [<c04b58e3>] hci_usb_close+0xf3/0x160
 [<c04b59be>] hci_usb_disconnect+0x2e/0x90
 [<c0454f23>] usb_disable_interface+0x53/0x70
 [<c04576f8>] usb_unbind_interface+0x38/0x80
 [<c032f908>] __device_release_driver+0x68/0xb0
 [<c032fc3e>] device_release_driver+0x1e/0x40
 [<c032f1db>] bus_remove_device+0x8b/0xa0
 [<c032dbc9>] device_del+0x159/0x1c0
 [<c04559ad>] usb_disable_device+0x4d/0x100
 [<c044fe8a>] usb_disconnect+0x9a/0x110
 [<c0452405>] hub_thread+0x355/0xbd0
 [<c061426e>] schedule+0x2de/0x8f0
 [<c013c640>] autoremove_wake_function+0x0/0x50
 [<c04520b0>] hub_thread+0x0/0xbd0
 [<c013c58c>] kthread+0xec/0xf0
 [<c013c4a0>] kthread+0x0/0xf0
 [<c0103be7>] kernel_thread_helper+0x7/0x10
 =======================
e91f6288: redzone 1:0x5a5a5a5a, redzone 2:0xc054aeae.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2878!
invalid opcode: 0000 [#1]
SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c016a242>]    Not tainted VLI
EFLAGS: 00010002   (2.6.20-rc1 #383)
EIP is at cache_free_debugcheck+0x1b2/0x1d0
eax: e91f6284   ebx: e91f6078   ecx: 00052c00   edx: 0000020c
esi: c20df680   edi: e91f6288   ebp: 5a5a5a5a   esp: c2227e30
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 303, ti=c2226000 task=c21f6a70 task.ti=c2226000)
Stack: c06b3fe0 e91f6288 5a5a5a5a c054aeae c04b58e3 e91f6040 c20df680 c20d9164 
       e91f628c 00000282 c016b530 c20efb08 c20efaf4 e977a274 0000000c c04b58e3 
       e977a230 e977a260 f7b3f904 e977a1a4 00000001 e977a1a4 f7b3f904 c07e2060 
Call Trace:
 [<c054aeae>] sock_alloc_send_skb+0x16e/0x1c0
 [<c04b58e3>] hci_usb_close+0xf3/0x160
 [<c016b530>] kfree+0x50/0xa0
 [<c04b58e3>] hci_usb_close+0xf3/0x160
 [<c04b59be>] hci_usb_disconnect+0x2e/0x90
 [<c0454f23>] usb_disable_interface+0x53/0x70
 [<c04576f8>] usb_unbind_interface+0x38/0x80
 [<c032f908>] __device_release_driver+0x68/0xb0
 [<c032fc3e>] device_release_driver+0x1e/0x40
 [<c032f1db>] bus_remove_device+0x8b/0xa0
 [<c032dbc9>] device_del+0x159/0x1c0
 [<c04559ad>] usb_disable_device+0x4d/0x100
 [<c044fe8a>] usb_disconnect+0x9a/0x110
 [<c0452405>] hub_thread+0x355/0xbd0
 [<c061426e>] schedule+0x2de/0x8f0
 [<c013c640>] autoremove_wake_function+0x0/0x50
 [<c04520b0>] hub_thread+0x0/0xbd0
 [<c013c58c>] kthread+0xec/0xf0
 [<c013c4a0>] kthread+0x0/0xf0
 [<c0103be7>] kernel_thread_helper+0x7/0x10
 =======================
Code: f0 2c 5a 75 8b b9 39 31 6b c0 89 f2 b8 88 e8 61 c0 e8 73 f4 ff ff eb 89 81 fb a5 c2 0f 17 0f 85 6c ff ff ff 90 8d 74 26 00 eb 8e <0f> 0b eb fe 0f 0b eb fe 8d b6 00 00 00 00 0f 0b eb fe 8b 52 0c 
EIP: [<c016a242>] cache_free_debugcheck+0x1b2/0x1d0 SS:ESP 0068:c2227e30
 <7>PM: Adding info for No Bus:vcs63
PM: Adding info for No Bus:vcsa63
PM: Removing info for No Bus:vcs63
PM: Removing info for No Bus:vcsa63
done.
Enabling non-boot CPUs ...
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.63 BogoMIPS (lpj=18288162)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00002940 0000c1a9 00000000 00000000
CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
PM: Adding info for No Bus:msr1
CPU1 is up
ata1: waiting for device to spin up (7 secs)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
