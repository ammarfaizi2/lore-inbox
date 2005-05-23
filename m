Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVEWUwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVEWUwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 16:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEWUwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 16:52:41 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:42646 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261966AbVEWUwH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 16:52:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OWdvM9k9dh1fU2/ehWtCoFwLULaeZCGjT59AeiEpIhKvijIiNiP7W9jbpq+Ef3v5z/sIBjUspzr8WGEmdZyDRyN6jZexVoyka5APy+EKgpRsy1o/b0xhdb8JRlvr21KB+wjYtcEhyXnrd75d6woeHrDFBWpMMoyG5SkLSvDezT8=
Message-ID: <3fc35c7e05052313523ab43067@mail.gmail.com>
Date: Mon, 23 May 2005 22:52:02 +0200
From: Helge Pomorin <dotkomm@gmail.com>
Reply-To: Helge Pomorin <dotkomm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
In-Reply-To: <20050523193010.5bf72481.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <web-135595327@mail5.rambler.ru>
	 <20050523193010.5bf72481.vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/5/23, Sergey Vlasov <vsu@altlinux.ru>:
> This is a known problem - if the Intel ICH5/6 controller is used in
> combined mode (SATA mapped to legacy IDE ports), DMA for PATA devices
> does not work.  If you reconfigure the controller in BIOS to not use the
> combined mode (so that the SATA part becomes a separate PCI device), DMA
> for PATA devices will work fine.
> 
> To IDE developers: Is something planned to work around this problem?
> AFAIK, there are some machines where BIOS does not provide an option to
> turn off the combined mode.
> 
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
