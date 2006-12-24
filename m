Return-Path: <linux-kernel-owner+w=401wt.eu-S1753054AbWLXXif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbWLXXif (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 18:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbWLXXif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 18:38:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35461 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753054AbWLXXie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 18:38:34 -0500
Date: Mon, 25 Dec 2006 00:36:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20061224233647.GB1761@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <1166971163.15485.21.camel@violet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <1166971163.15485.21.camel@violet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun 2006-12-24 15:39:23, Marcel Holtmann wrote:
> Hi Pavel,
> 
> > > I got this nasty oops while playing with debugger. Not sure if that is
> > > related; it also might be something with bluetooth; I already know it
> > > corrupts memory during suspend, perhaps it corrupts memory in some
> > > error path?
> > 
> > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > cycles... so it is probably unrelated to the previous crash.
> 
> can you try to reproduce this with 2.6.20-rc2 as well.

Yep, here it is, reproduced on 6-th-or-so suspend.

bluetooth may need to be actively used in order for this to trigger;
connecting to the net over my cellphone seems to work okay.

(Full logs in attachment).

								Pavel

Linux version 2.6.20-rc2 (pavel@amd) (gcc version 4.0.4 20060507
(prerelease) (Debian 4.0.3-3)) #383 SMP Fri Dec 22 11:30:05 CET 2006
...
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
usb usb3: resuming
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
hub 1-0:1.0: resuming
hub 3-0:1.0: resuming
i8042 i8042: resuming
atkbd serio0: resuming
psmouse serio1: resuming
usb usb4: resuming
usb usb5: resuming
hub 4-0:1.0: resuming
hub 5-0:1.0: resuming
usb usb2: resuming
hub 2-0:1.0: resuming
mmcblk mmc0:cc53: resuming
sd 0:0:0:0: resuming
usb 3-2: resuming
 usbdev3.8_ep00: PM: resume from 0, parent 3-2 still 2
usb 3-2:1.0: PM: resume from 2, parent 3-2 still 2
usb 3-2:1.0: resuming
 usbdev3.8_ep81: PM: resume from 0, parent 3-2:1.0 still 2
 usbdev3.8_ep02: PM: resume from 0, parent 3-2:1.0 still 2
 usbdev3.8_ep83: PM: resume from 0, parent 3-2:1.0 still 2
usb 3-1: resuming
 usbdev3.9_ep00: PM: resume from 0, parent 3-1 still 2
hci_usb 3-1:1.0: PM: resume from 2, parent 3-1 still 2
hci_usb 3-1:1.0: resuming
 hci0: PM: resume from 0, parent 3-1:1.0 still 2
 usbdev3.9_ep81: PM: resume from 0, parent 3-1:1.0 still 2
 usbdev3.9_ep82: PM: resume from 0, parent 3-1:1.0 still 2
 usbdev3.9_ep02: PM: resume from 0, parent 3-1:1.0 still 2
hci_usb 3-1:1.1: PM: resume from 2, parent 3-1 still 2
hci_usb 3-1:1.1: resuming
 usbdev3.9_ep83: PM: resume from 0, parent 3-1:1.1 still 2
 usbdev3.9_ep03: PM: resume from 0, parent 3-1:1.1 still 2
usb 3-1:1.2: PM: resume from 2, parent 3-1 still 2
usb 3-1:1.2: resuming
 usbdev3.9_ep84: PM: resume from 0, parent 3-1:1.2 still 2
 usbdev3.9_ep04: PM: resume from 0, parent 3-1:1.2 still 2
usb 3-1:1.3: PM: resume from 2, parent 3-1 still 2
usb 3-1:1.3: resuming
Restarting tasks ... <3>__tx_submit: hci0 tx submit failed urb f765d1bc type 2 err -19
usb 3-1: USB disconnect, address 9
PM: Removing info for No Bus:usbdev3.9_ep81
PM: Removing info for No Bus:usbdev3.9_ep82
PM: Removing info for No Bus:usbdev3.9_ep02
slab error in verify_redzone_free(): cache `size-512': memory outside object was overwritten
 [<c016a298>] cache_free_debugcheck+0x128/0x1d0
 [<c04b08d3>] hci_usb_close+0xf3/0x160
 [<c016b610>] kfree+0x50/0xa0
 [<c04b08d3>] hci_usb_close+0xf3/0x160
 [<c04b09ae>] hci_usb_disconnect+0x2e/0x90
 [<c044fed3>] usb_disable_interface+0x53/0x70
 [<c04526a8>] usb_unbind_interface+0x38/0x80
 [<c032a8b8>] __device_release_driver+0x68/0xb0
 [<c032abee>] device_release_driver+0x1e/0x40
 [<c032a18b>] bus_remove_device+0x8b/0xa0
 [<c0328b79>] device_del+0x159/0x1c0
 [<c045095d>] usb_disable_device+0x4d/0x100
 [<c044ae3a>] usb_disconnect+0x9a/0x110
 [<c044d3b5>] hub_thread+0x355/0xbd0
 [<c060f53e>] schedule+0x2de/0x8f0
 [<c013c680>] autoremove_wake_function+0x0/0x50
 [<c044d060>] hub_thread+0x0/0xbd0
 [<c013c5cc>] kthread+0xec/0xf0
 [<c013c4e0>] kthread+0x0/0xf0
 [<c0103be7>] kernel_thread_helper+0x7/0x10
 =======================
f70a2720: redzone 1:0x5a5a5a5a, redzone 2:0xc0545e9e.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2878!
invalid opcode: 0000 [#1]
SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c016a322>]    Not tainted VLI
EFLAGS: 00010012   (2.6.20-rc2 #383)
EIP is at cache_free_debugcheck+0x1b2/0x1d0
eax: f70a271c   ebx: f70a20f8   ecx: 00052c00   edx: 0000020c
esi: c20df680   edi: f70a2720   ebp: 5a5a5a5a   esp: c2313e30
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 304, ti=c2312000 task=c2257030 task.ti=c2312000)
Stack: c06aedf0 f70a2720 5a5a5a5a c0545e9e c04b08d3 f70a20c0 c20df680 c20d9164 
       f70a2724 00000286 c016b610 f653e8d8 f653e8c4 c2134ba0 0000000c c04b08d3 
       c2134b5c c2134b8c f62e0a54 c2134ad0 00000001 c2134ad0 f62e0a54 c07dbee0 
Call Trace:
 [<c0545e9e>] sock_alloc_send_skb+0x16e/0x1c0
 [<c04b08d3>] hci_usb_close+0xf3/0x160
 [<c016b610>] kfree+0x50/0xa0
 [<c04b08d3>] hci_usb_close+0xf3/0x160
 [<c04b09ae>] hci_usb_disconnect+0x2e/0x90
 [<c044fed3>] usb_disable_interface+0x53/0x70
 [<c04526a8>] usb_unbind_interface+0x38/0x80
 [<c032a8b8>] __device_release_driver+0x68/0xb0
 [<c032abee>] device_release_driver+0x1e/0x40
 [<c032a18b>] bus_remove_device+0x8b/0xa0
 [<c0328b79>] device_del+0x159/0x1c0
 [<c045095d>] usb_disable_device+0x4d/0x100
 [<c044ae3a>] usb_disconnect+0x9a/0x110
 [<c044d3b5>] hub_thread+0x355/0xbd0
 [<c060f53e>] schedule+0x2de/0x8f0
 [<c013c680>] autoremove_wake_function+0x0/0x50
 [<c044d060>] hub_thread+0x0/0xbd0
 [<c013c5cc>] kthread+0xec/0xf0
 [<c013c4e0>] kthread+0x0/0xf0
 [<c0103be7>] kernel_thread_helper+0x7/0x10
 =======================
Code: f0 2c 5a 75 8b b9 05 df 6a c0 89 f2 b8 88 98 61 c0 e8 73 f4 ff ff eb 89 81 fb a5 c2 0f 17 0f 85 6c ff ff ff 90 8d 74 26 00 eb 8e <0f> 0b eb fe 0f 0b eb fe 8d b6 00 00 00 00 0f 0b eb fe 8b 52 0c 
EIP: [<c016a322>] cache_free_debugcheck+0x1b2/0x1d0 SS:ESP 0068:c2313e30
 <7>PM: Adding info for No Bus:vcs63
PM: Adding info for No Bus:vcsa63
PM: Removing info for No Bus:vcs63
PM: Removing info for No Bus:vcsa63
done.
Enabling non-boot CPUs ...
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.64 BogoMIPS (lpj=18288234)
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
ata1: waiting for device to spin up (8 secs)
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--1yeeQ81UyVL57Vl7
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="oops4.bz2"
Content-Transfer-Encoding: base64

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

--1yeeQ81UyVL57Vl7--
