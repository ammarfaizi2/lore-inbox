Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRJEUb2>; Fri, 5 Oct 2001 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273176AbRJEUbS>; Fri, 5 Oct 2001 16:31:18 -0400
Received: from lsd.nurk.org ([208.8.184.53]:53895 "HELO lsd.nurk.org")
	by vger.kernel.org with SMTP id <S272773AbRJEUbN>;
	Fri, 5 Oct 2001 16:31:13 -0400
Date: Fri, 5 Oct 2001 13:31:57 -0700 (PDT)
From: Sean Swallow <sean@swallow.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PDC20268 UDMA troubles
Message-ID: <Pine.LNX.4.33.0110051329450.15665-100000@lsd.nurk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

Thank you for the reply.

I was wondering if both controllers (PDC20268 and PDC20267) should show up
when I cat /proc/ide/pdc202xx ?

I'm not disabling the BURST_BIT, I think the driver is, but only on the
second card. Thus, I can't get udma5 on all 4 chains.

This is from dmesg:

PDC20267: IDE controller on PCI bus 00 dev 40
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x1080-0x1087, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x1088-0x108f, BIOS settings: hdg:DMA, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 50
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide4: BM-DMA at 0x10d0-0x10d7, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x10d8-0x10df, BIOS settings: hdk:pio, hdl:pio

Let me know if you need more information.

cheers,

-- 
Sean J. Swallow
pgp (6.5.2) keyfile @ https://nurk.org/keyfile.txt


On Thu, 4 Oct 2001 andre@linux-ide.org wrote:

>
> There is nothing wrong with the procfs.
> The HOST performs a sense mode on the contents of the taskfile registers
> when loading a setfeature to change the transfer rate.  Mode 5 is the
> same
> timings as Mode 4; however, the internal base clocks are different.
>
> Also why are we disabling the BUSRT BIT?
>
>



