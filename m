Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVDFVRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVDFVRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 17:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVDFVRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 17:17:44 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:26373 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262328AbVDFVRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 17:17:34 -0400
Message-ID: <425451A0.7020000@tuxrocks.com>
Date: Wed, 06 Apr 2005 15:16:16 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Dynamic Tick version 050406-1
References: <20050406083000.GA8658@atomide.com>
In-Reply-To: <20050406083000.GA8658@atomide.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080309030903020608000908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309030903020608000908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
> Hi all,
> 
> Here's an updated dyn-tick patch. Some minor fixes:

Doesn't look so good here.  I get this with 2.6.12-rc2 (plus a few other patches).
Disabling Dynamic Tick makes everything happy again (it boots).

[4294688.655000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[4294688.656000]  printing eip:
[4294688.657000] c077f818
[4294688.659000] *pde = 00000000
[4294688.660000] Oops: 0000 [#1]
[4294688.661000] PREEMPT 
[4294688.662000] Modules linked in:
[4294688.663000] CPU:    0
[4294688.663000] EIP:    0060:[<c077f818>]    Not tainted VLI
[4294688.663000] EFLAGS: 00010202   (2.6.12-rc2-fs3) 
[4294688.666000] EIP is at dyn_tick_late_init+0x38/0x80
[4294688.667000] eax: 00000000   ebx: c079f0c0   ecx: 00000000   edx: f7c15d4c
[4294688.668000] esi: f7f02000   edi: 00000000   ebp: f7f03fb8   esp: f7f03fb4
[4294688.669000] ds: 007b   es: 007b   ss: 0068
[4294688.670000] Process swapper (pid: 1, threadinfo=f7f02000 task=f7f01830)
[4294688.670000] Stack: c077a0e2 f7f03fd8 c076a956 c019bde8 c01002a0 00000000 c01002a0 0000000 
[4294688.671000]        00000000 f7f03fec c01002d5 0000007b 0000007b ffffffff 00000000 c0101365 
[4294688.672000]        00000000 00000000 00000000 
[4294688.673000] Call Trace:
[4294688.675000]  [<c0104bfa>] show_stack+0x7a/0x90
[4294688.676000]  [<c0104d79>] show_registers+0x149/0x1c0
[4294688.677000]  [<c0104fea>] die+0x14a/0x2d0
[4294688.678000]  [<c011e3ee>] do_page_fault+0x44e/0x633
[4294688.679000]  [<c01046e3>] error_code+0x4f/0x54
[4294688.680000]  [<c076a956>] do_initcalls+0x56/0xc0
[4294688.681000]  [<c01002d5>] init+0x35/0x110
[4294688.682000]  [<c0101365>] kernel_thread_helper+0x5/0x10
[4294688.683000] Code: 83 ec 04 e8 3b 6b c0 ff ba 14 b7<7>eth0: no IPv6 routers present

Frank
-- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com

--------------080309030903020608000908
Content-Type: text/plain;
 name="kermit-log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kermit-log"

[4294667.296000] Linux version 2.6.12-rc2-fs3 (root@moebius.cs.byu.edu) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #3 Wed Apr 6 13:14:48 MDT 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[4294667.296000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000005ffae000 (usable)
[4294667.296000]  BIOS-e820: 000000005ffae000 - 0000000060000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[4294667.296000] 639MB HIGHMEM available.
[4294667.296000] 896MB LOWMEM available.
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: PM-Timer IO Port: 0x808
[4294667.296000] Allocating PCI resources starting at 60000000 (gap: 60000000:9eda0000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: ro root=LABEL=/1 vga=794 nmi_watchdog=1 lapic console=tty0 console=ttyUSB0,9600 psmouse.proto=exps i8k.ignore_dmi:bool=true netconsole=@128.187.171.101/eth0,5515@128.187.171.102/ single
[4294667.296000] Unknown boot option `i8k.ignore_dmi:bool=true': ignoring
[4294667.296000] netconsole: local port 6665
[4294667.296000] netconsole: local IP 128.187.171.101
[4294667.296000] netconsole: interface eth0
[4294667.296000] netconsole: remote port 5515[4294667.296000] netconsole: remote IP 128.187.171.102
[4294667.[4294667.296000] Console: colour dummy device 80x25
[4294667.298[4294667.472000] Capability LSM initialized as secondary
[429466[4294667.472000] Checking 'hlt' instruction... OK.
[4294667.4830[4294667.616000] checking if image is initramfs... it is
[429466[4294667.750000] Completing Region/Field/Buffer/Package initiali[4294667.881000] PCI: Transparent bridge - 0000:00:1e.0
[4294667[4294668.309000] pnp: PnP ACPI: found 10 devices
[4294668.310000[4294668.534000] pnp: 00:01: ioport range 0x808-0x80f could not [4294668.607000] audit(1112798526.606:0): initialized
[4294668.6[4294668.625000] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ [4294668.947000]   * connector 1 of type 2 (CRT) : 2320
[4294668[4294671.384000] radeonfb: Monitor 1 type LCD found
[4294671.384[4294671.384000]  320 x 400
[4294671.384000]  320 x 400
[4294671[4294671.384000]  1024 x 768
[4294671.384000]  1280 x 1024
[4294[4294671.384000] Setting up default mode based on panel info
[42[4294671.492000] fb1: VESA VGA frame buffer device
[4294671.4980[4294673.099000] agpgart: AGP aperture is 128M @ 0xe8000000
[429[4294673.156000] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ [4294673.205000] PPP generic driver version 2.4.2
[4294673.20800[4294676.218000] b44: eth0: Link is up at 100 Mbps, full duplex.[4294677.477000] ICH4: not 100% native mode: will probe irqs lat[4294682.079000] hda: cache flushes supported
[4294682.081000]  [4294682.253000] PCI: Enabling device 0000:02:01.0 (0000 -> 0002[4294682.646000] Badness in device_release at drivers/base/core.[4294682.657000] Databook TCIC-2 PCMCIA probe: not found.
[42946[4294682.683000] hub 1-0:1.0: 6 ports detected
[4294682.705000] [4294682.781000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LN[4294682.919000] uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf[4294683.124000] usbcore: registered new driver usbhid
[4294683.[4294683.141000] drivers/usb/serial/belkin_sa.c: USB Belkin Seri[4294683.155000] drivers/usb/serial/usb-serial.c: USB Serial sup[4294683.169000] drivers/usb/serial/usb-serial.c: USB Serial sup[4294683.183000] drivers/usb/serial/usb-serial.c: USB Serial sup[4294683.198000] drivers/usb/serial/keyspan.c: v1.1.4:Keyspan US[4294683.211000] drivers/usb/serial/usb-serial.c: USB Serial sup[4294685.808000] drivers/usb/serial/whiteheat.c: USB ConnectTech[4294685.833000] md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DIS[4294685.966000] input: PS/2 Generic Mouse on isa0060/serio1
[4294686.655000] intel8x0_measure_ac97_clock: measured 49315 usecs
[4294686.656000] intel8x0: clocking to 48000
[4294686.668000] ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
[4294686.771000] MC'97 1 converters and GPIO not ready (0xff00)
[4294686.777000] ALSA device list:
[4294686.778000]   #0: Intel 82801DB-ICH4 with STAC9750,51 at 0xf8fff800, irq 7
[4294686.779000]   #1: Intel 82801DB-ICH4 Modem at 0xd400, irq 7
[4294686.780000] NET: Registered protocol family 2
[4294686.791000] IP: routing cache hash table of 4096 buckets, 128Kbytes
[4294686.792000] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[4294686.796000] TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
[4294686.801000] TCP: Hash tables configured (established 262144 bind 65536)
[4294686.802000] IPv4 over IPv4 tunneling driver
[4294686.804000] GRE over IPv4 tunneling driver
[4294686.806000] Initializing IPsec netlink so[4294686.815000] NET: Registered protocol family 17
[4294688.655000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[4294688.656000]  printing eip:
[4294688.657000] c077f818
[4294688.659000] *pde = 00000000
[4294688.660000] Oops: 0000 [#1]
[4294688.661000] PREEMPT 
[4294688.662000] Modules linked in:
[4294688.663000] CPU:    0
[4294688.663000] EIP:    0060:[<c077f818>]    Not tainted VLI
[4294688.663000] EFLAGS: 00010202   (2.6.12-rc2-fs3) 
[4294688.666000] EIP is at dyn_tick_late_init+0x38/0x80
[4294688.667000] eax: 00000000   ebx: c079f0c0   ecx: 00000000   edx: f7c15d4c
[4294688.668000] esi: f7f02000   edi: 00000000   ebp: f7f03fb8   esp: f7f03fb4
[4294688.669000] ds: 007b   es: 007b   ss: 0068
[4294688.670000] Process swapper (pid: 1, threadinfo=f7f02000 task=f7f01830)
[4294688.670000] Stack: c077a0e2 f7f03fd8 c076a956 c019bde8 c01002a0 00000000 c01002a0 00000000 
[4294688.671000]        00000000 f7f03fec c01002d5 0000007b 0000007b ffffffff 00000000 c0101365 
[4294688.672000]        00000000 00000000 00000000 
[4294688.673000] Call Trace:
[4294688.675000]  [<c0104bfa>] show_stack+0x7a/0x90
[4294688.676000]  [<c0104d79>] show_registers+0x149/0x1c0
[4294688.677000]  [<c0104fea>] die+0x14a/0x2d0
[4294688.678000]  [<c011e3ee>] do_page_fault+0x44e/0x633
[4294688.679000]  [<c01046e3>] error_code+0x4f/0x54
[4294688.680000]  [<c076a956>] do_initcalls+0x56/0xc0
[4294688.681000]  [<c01002d5>] init+0x35/0x110
[4294688.682000]  [<c0101365>] kernel_thread_helper+0x5/0x10
[4294688.683000] Code: 83 ec 04 e8 3b 6b c0 ff ba 14 b7<7>eth0: no IPv6 routers present
[4294703.238000] md: stopping all md devices.

--------------080309030903020608000908--
