Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVEWVrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVEWVrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVEWVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:47:34 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:36888 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261979AbVEWVrW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:47:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PLZVw6rfKfHIsDfdt0UTx4gVm1qKkIkYHGibXR1IOVH83eiqTfDN+ZWLtqXTG9QX6tKIYFKhwXZ/T+gPo7/I3AcL6jdQAF3hi1EMu01KhVNq9AWhWkhx6CemoY1sSBBxppBBhtC0PEtehTXalD0YZg5gDkkHr5uj35so0fuG1Oo=
Message-ID: <3fc35c7e050523144729051b23@mail.gmail.com>
Date: Mon, 23 May 2005 23:47:22 +0200
From: Helge Pomorin <dotkomm@gmail.com>
Reply-To: Helge Pomorin <dotkomm@gmail.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [SATA] Disabling irq: #11 with silicon image 3112 sata controller with sata_sil and libata (NO RAID)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hm,
now i realise it that ive answered last message not sended new...
sorry about that... well again:

i want to install my root fs on my primary sata drive, its solo
plugged at the onboard controller atm. (at the point it works fine,
with 2.6.5...)

-disabling acpi  (no changes)
-disabling irq debug (no changes)
-change compatible mode (well bios option misses)
-disabling sata (well i want use it so disabling isnt that i want to know...)

well so heres my previous message i did send couple of minutes ago:

Hi there,
Got similar looking problem here,
i cant change sata modes or something alike...

I get *disabling irq* message with Intel ICH 4 / SIL 3112 A rev 01
SATA Controller on Asus P4G8X Deluxe board (P4 Northwood, Intel
*granite bay* E702 Chipsets) at distros which using newer kernel than
2.6.5, manual installation of kernel >= 2.6.7 fails
(well i think udev isnt creating devices or something cause after i
did try compile the kernel on my own etc...
kernel modules  found the sata controller, the devices and the
partitions, but hangsup with an *waiting for /dev/sda3 (my root disk)
to appear*)

my messages are known i think... but for completion:
(i did copied it from net this isn exactly my error
cause i dont know how to copy the error, after failed boot...)
ata1: SATA max UDMA/100 cmd 0xE09FC080 ctl 0xE09FC08A bmdma 0xE09FC000
irq 11
ata2: SATA max UDMA/100 cmd 0xE09FC0C0 ctl 0xE09FC0CA bmdma
0xE09FC008 irq 11
irq 11: nobody cared!
[<c012fbea>] __report_bad_irq+0x2a/0x90
[<c012f5a0>] handle_IRQ_event+0x30/0x70
[<c012fcdc>] note_interrupt+0x6c/0xd0
[<c012f710>] __do_IRQ+0x130/0x160
[<c01042b9>] do_IRQ+0x19/0x30
[<c010289a>] common_interrupt+0x1a/0x20
[<c0117830>] __do_softirq+0x30/0x90
[<c01178b6>] do_softirq+0x26/0x30
[<c012f564>] irq_exit+0x34/0x40
[<c01042be>] do_IRQ+0x1e/0x30
[<c010289a>] common_interrupt+0x1a/0x20
[<c01005f0>] default_idle+0x0/0x30
[<c0100613>] default_idle+0x23/0x30
[<c010068a>] cpu_idle+0x3a/0x60
[<c03ca767>] start_kernel+0x147/0x160
[<c03ca360>] unknown_bootoption+0x0/0x1b0
handlers:
[<c0273770>] (usb_hcd_irq+0x0/0x70)
[<e0a65460>] (ata_interrupt+0x0/0x1c0 [libata])
/*
the handlers differs from my messages i get also reported:
[ohci1394]
[reiserfs]
[usbcore]
[sata_sil]
/*
Disabling IRQ #11
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01
87:4003 88:203f
ata1: dev 0 ATA, max UDMA/100, 390721968 sectors: lba48

i got that problem after a new installation of my system, before that
it worked with a 2.6.10 kernel on same system (something about 4 weeks
ago dont know settings anymore sorry...)

well im trying some different partition style layouts,
cause i just get that message with an seperate boot partition formated
with ext3,
if i set up a blank installation without that */boot* it works fine,
even with newer version's...

if u got an idea, need some logs infos etc message me :-)

greets
Helge Pomorin
Berlin, Germany
