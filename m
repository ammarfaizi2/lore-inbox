Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBSXcf>; Mon, 19 Feb 2001 18:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129059AbRBSXcZ>; Mon, 19 Feb 2001 18:32:25 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:17425 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S129027AbRBSXcO>; Mon, 19 Feb 2001 18:32:14 -0500
Date: Mon, 19 Feb 2001 17:31:53 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] meaningless #ifndef?
Message-ID: <20010219173153.B12609@ganymede.isdn.uiuc.edu>
In-Reply-To: <Pine.GSO.4.30.0102192252130.7963-100000@balu> <Pine.LNX.4.10.10102191421140.4861-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102191421140.4861-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Feb 19, 2001 at 02:31:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Andre Hedrick:
} On Mon, 19 Feb 2001, Pozsar Balazs wrote:
} 
} > from drivers/ide/ide-features.c:
} > 
} > /*
} >  *  All hosts that use the 80c ribbon mus use!
} >  */
} > byte eighty_ninty_three (ide_drive_t *drive)
} > {
} >         return ((byte) ((HWIF(drive)->udma_four) &&
} > #ifndef CONFIG_IDEDMA_IVB
} >                         (drive->id->hw_config & 0x4000) &&
} > #endif /* CONFIG_IDEDMA_IVB */
} >                         (drive->id->hw_config & 0x6000)) ? 1 : 0);
} > }
} > 
} > If i see well, then this is always same whether CONFIG_IDEDMA_IVB is
} > defined or not.
} > What's the clue?
} 
[snip...]

The use of the ternary operator is superfluous, though...and makes the
code look ugly IMNSHO :).

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
