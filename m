Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268705AbRG0LXW>; Fri, 27 Jul 2001 07:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268727AbRG0LXM>; Fri, 27 Jul 2001 07:23:12 -0400
Received: from CPE-61-9-148-51.vic.bigpond.net.au ([61.9.148.51]:6136 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S268705AbRG0LW7>;
	Fri, 27 Jul 2001 07:22:59 -0400
Message-ID: <3B614E4B.973DAA85@eyal.emu.id.au>
Date: Fri, 27 Jul 2001 21:19:39 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bogo-howto: ATA-100 drives on the Asus A7A266
In-Reply-To: <3B60886B.57C31DA9@mail.utexas.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Bobby D. Bryant" wrote:
> 
> People are using the archive and discovering my earlier question about
> getting my ATA-100 drive to work on  the Asus A7A266, and are now

FYI, you may want to add this table to your summary.

The IDE modes are
	PIO 		0-4
	Single word DMA	0-2
	Multi word DMA	0-2
	Ultra DMA	0-7

This configures the disk - not the chipset.
	-X00	restore default PIO
	-X01	diasble IORDY

PIO=mode + 8		Programmed IO
	-X08	PIO 0
	-X09	PIO 1
	-X10	PIO 2
	-X11	PIO 3
	-X12	PIO 4

SDMA=mode + 16		Single-word DMA
	-X16	SDMA 0
	-X17	SDMA 1
	-X18	SDMA 2

MDMA=mode + 32		Muti-word DMA
	-X32	MDMA 0
	-X33	MDMA 1
	-X34	MDMA 2

UDMA=mode + 64		Ultra DMA
	-X64	UDMA 0 (ATA 16)
	-X65	UDMA 1 (ATA 25)
	-X66	UDMA 2 (ATA 33)
	-X67	UDMA 3 (ATA 44)
	-X68	UDMA 4 (ATA 66)
	-X69	UDMA 5 (ATA 100)

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
