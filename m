Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbRBSV6G>; Mon, 19 Feb 2001 16:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBSV54>; Mon, 19 Feb 2001 16:57:56 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:36753 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S129310AbRBSV5m>;
	Mon, 19 Feb 2001 16:57:42 -0500
Date: Mon, 19 Feb 2001 22:57:32 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [IDE] meaningless #ifndef?
Message-ID: <Pine.GSO.4.30.0102192252130.7963-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from drivers/ide/ide-features.c:

/*
 *  All hosts that use the 80c ribbon mus use!
 */
byte eighty_ninty_three (ide_drive_t *drive)
{
        return ((byte) ((HWIF(drive)->udma_four) &&
#ifndef CONFIG_IDEDMA_IVB
                        (drive->id->hw_config & 0x4000) &&
#endif /* CONFIG_IDEDMA_IVB */
                        (drive->id->hw_config & 0x6000)) ? 1 : 0);
}

If i see well, then this is always same whether CONFIG_IDEDMA_IVB is
defined or not.
What's the clue?

-- 
pozsy.

