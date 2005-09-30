Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbVI3Qze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVI3Qze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVI3Qzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:55:33 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:52395 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030363AbVI3Qzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:55:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=eW7zP57gpWspJgHEErZC69afMtUj007lDo1P20rnwiA8l3/bqbzPDhTnX35S5FifGT1pVIdl67Ba2YXg4qsFFR5bpgaHbx4JxSAzRq5cJRx3UJlUzRkSoTTVeD7l0PkeBarJ7yGCd3KG4VyyM7YxlFxNC0WLwudP4OTPeAeZxoE=
Subject: Re: 2.6.14-rc2-mm2
From: Badari Pulavarty <pbadari@gmail.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <14500000.1128090994@[10.10.2.4]>
References: <20050929143732.59d22569.akpm@osdl.org>
	 <14500000.1128090994@[10.10.2.4]>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 09:54:58 -0700
Message-Id: <1128099298.16275.80.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 07:36 -0700, Martin J. Bligh wrote:
> Hangs on boot on x86_64 (-mm1 did the same, -git8 is fine)
> 
> http://test.kernel.org/13722/debug/console.log
> 
> eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:3d:00:c9:fe
> eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> eth0: dma_rwctrl[769f0000]
> ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 26 (level, low) -> IRQ 21
> eth1: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:09:3d:00:c9:ff
> eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> eth1: dma_rwctrl[769f0000]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD8111: IDE controller at PCI slot 0000:00:07.1
> AMD8111: chipset revision 3
> AMD8111: not 100% native mode: will probe irqs later
> AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
>     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1008-0x100f<4>logips2pp: Detected unknown logitech mouse model 0
> , BIOS settings: hdc:DMA, hdd:pio
> input: PS/2 Logitech Mouse on isa0060/serio1
> -- 0:conmux-control -- time-stamp -- Sep/29/05 15:38:00 --

I ran into the same issue earlier on my AMD box and 
found out that

x86_64-no-idle-tick.patch 

is causing the problem with IDE drives. No idea why.
Can you back out x86_64-no-idle-tick* patches and
try ?

Thanks,
Badari

