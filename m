Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUIXWiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUIXWiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUIXWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:38:16 -0400
Received: from smtp06.auna.com ([62.81.186.16]:30661 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S268686AbUIXWiK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:38:10 -0400
Date: Fri, 24 Sep 2004 22:38:08 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc2-mm3, irq 11: nobody cared!, Disabling IRQ #11
To: linux-kernel@vger.kernel.org
References: <20040924014643.484470b1.akpm@osdl.org>
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org> (from akpm@osdl.org on
	Fri Sep 24 10:46:43 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096065488l.13335l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.24, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/
> 

I got this oops also, some time after normal boot:

Sep 24 12:58:38 nada kernel: irq 11: nobody cared!
Sep 24 12:58:38 nada kernel:  [__report_bad_irq+36/144] __report_bad_irq+0x24/0x90
Sep 24 12:58:38 nada kernel:  [<c0108514>] __report_bad_irq+0x24/0x90
Sep 24 12:58:38 nada kernel:  [note_interrupt+146/352] note_interrupt+0x92/0x160
Sep 24 12:58:38 nada kernel:  [<c0108782>] note_interrupt+0x92/0x160
Sep 24 12:58:38 nada kernel:  [finish_task_switch+61/144] finish_task_switch+0x3d/0x90
Sep 24 12:58:38 nada kernel:  [<c011983d>] finish_task_switch+0x3d/0x90
Sep 24 12:58:38 nada kernel:  [do_IRQ+354/416] do_IRQ+0x162/0x1a0
Sep 24 12:58:38 nada kernel:  [<c0108bc2>] do_IRQ+0x162/0x1a0
Sep 24 12:58:38 nada kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Sep 24 12:58:38 nada kernel:  [<c01065dc>] common_interrupt+0x18/0x20
Sep 24 12:58:38 nada kernel:  [default_idle+0/64] default_idle+0x0/0x40
Sep 24 12:58:38 nada kernel:  [<c0103b40>] default_idle+0x0/0x40
Sep 24 12:58:38 nada kernel:  [default_idle+44/64] default_idle+0x2c/0x40
Sep 24 12:58:38 nada kernel:  [<c0103b6c>] default_idle+0x2c/0x40
Sep 24 12:58:38 nada kernel:  [cpu_idle+52/80] cpu_idle+0x34/0x50
Sep 24 12:58:38 nada kernel:  [<c0103bf4>] cpu_idle+0x34/0x50
Sep 24 12:58:38 nada kernel: handlers:
Sep 24 12:58:38 nada kernel: [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Sep 24 12:58:38 nada kernel: [<c0335680>] (usb_hcd_irq+0x0/0x70)
Sep 24 12:58:38 nada kernel: [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Sep 24 12:58:38 nada kernel: [<c0335680>] (usb_hcd_irq+0x0/0x70)
Sep 24 12:58:38 nada kernel: [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Sep 24 12:58:38 nada kernel: [<c0335680>] (usb_hcd_irq+0x0/0x70)
Sep 24 12:58:38 nada kernel: Disabling IRQ #11

System:

nada:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:07.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 62)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

If any more info is needed, just ask for it.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm3 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1


