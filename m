Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbRBTErM>; Mon, 19 Feb 2001 23:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRBTErC>; Mon, 19 Feb 2001 23:47:02 -0500
Received: from [198.77.1.35] ([198.77.1.35]:41220 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129535AbRBTEqt>;
	Mon, 19 Feb 2001 23:46:49 -0500
Message-ID: <3A91F65F.EBBFCAF7@mountain.net>
Date: Mon, 19 Feb 2001 23:45:19 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
CC: Andre Hedrick <andre@linux-ide.org>, Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] meaningless #ifndef?
In-Reply-To: <Pine.GSO.4.30.0102192252130.7963-100000@balu> <Pine.LNX.4.10.10102191421140.4861-100000@master.linux-ide.org> <20010219173153.B12609@ganymede.isdn.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Wendling wrote:
> 
> Also sprach Andre Hedrick:
> } On Mon, 19 Feb 2001, Pozsar Balazs wrote:
> }
> } > from drivers/ide/ide-features.c:
> } >
> } > /*
> } >  *  All hosts that use the 80c ribbon mus use!
> } >  */
> } > byte eighty_ninty_three (ide_drive_t *drive)
> } > {
> } >         return ((byte) ((HWIF(drive)->udma_four) &&
> } > #ifndef CONFIG_IDEDMA_IVB
> } >                         (drive->id->hw_config & 0x4000) &&
> } > #endif /* CONFIG_IDEDMA_IVB */
> } >                         (drive->id->hw_config & 0x6000)) ? 1 : 0);
> } > }
> } >
> } > If i see well, then this is always same whether CONFIG_IDEDMA_IVB is
> } > defined or not.
> } > What's the clue?
> }
> [snip...]
> 
> The use of the ternary operator is superfluous, though...and makes the
> code look ugly IMNSHO :).
> 

Check return type. 0 == ((byte) 0x6000).

Tom
