Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRAKOsi>; Thu, 11 Jan 2001 09:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131198AbRAKOs2>; Thu, 11 Jan 2001 09:48:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21770 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129927AbRAKOsQ>; Thu, 11 Jan 2001 09:48:16 -0500
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
To: dennispowell@earthlink.net (dep)
Date: Thu, 11 Jan 2001 14:49:49 +0000 (GMT)
Cc: James@nistix.com (James Brents),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <01011109382601.29363@depoffice.localdomain> from "dep" at Jan 11, 2001 09:38:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Gj32-0002ND-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> us who have via chipset motherboards, suggesting that it is limited 
> to that chipset, that chipset is ubiquitous, or via chipset 
> motherboard owners are generally the complaining type. no idea which 
> applies there, either.

Or there are a lot of them. 90% of scsi bug reports I get are adaptec 29xx
driver. Thats not because the adaptec 29xx is the most sucky driver 8)

Firstly there are numerous reasons for CRC errors. At ATA100 even the track
length and the capacitance of the connectors becomes an issue. It is quite
possibly a driver issue. It could even be that specific combination of drives
and ide controller is right on the edge of the spec limits and just slightly
dipping over. It might be the odd power spike.

Providing the code is working sanely the odd CRC error shouldnt be a 
problem and should be causing a command retry. The CRC checking used in ATA
is very robust so unlike scsi parity errors which couldnt be ignored ATA
ones on occassion are probably fine

ATA100 is another testimony to the fact that pigs can be made to fly given 
sufficient thrust (to borrow an RFC)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
