Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbQLWEft>; Fri, 22 Dec 2000 23:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbQLWEfk>; Fri, 22 Dec 2000 23:35:40 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:53770 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S129383AbQLWEfZ>;
	Fri, 22 Dec 2000 23:35:25 -0500
Message-ID: <002b01c06c95$7c24fe60$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: "Andrzej Krzysztofowicz" <kufel!ankry@green.mif.pg.gda.pl>
Cc: "Linux Raid mailing list" <linux-raid@vger.kernel.org>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200012222224.XAA02297@kufel.dom>
Subject: Re: Fw: max number of ide controllers?
Date: Fri, 22 Dec 2000 23:04:45 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is what worked.

append="ide6=0x168,0x36e,10"

Thanks all for your help.

Merry Christmas : )

> > Charles Wilkins writes:
> > > I have ide.2.2.18.1209.patch applied. The kernel is 2.2.18.
> > > So what is the answer? 4 controllers max or 10 for my kernel?
> > 
> > 10 controllers if you have the IDE patches applied.  4 otherwise.
> 
> Look the source Luck ...
> 
> 2.2.18 ide.c:
> 
> static const byte       ide_hwif_to_major[] = {IDE0_MAJOR, IDE1_MAJOR,
> IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR, IDE5_MAJOR };
> 
> 6 otherwise
> 
> Andrzej

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
