Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136062AbRAGUwE>; Sun, 7 Jan 2001 15:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136047AbRAGUvz>; Sun, 7 Jan 2001 15:51:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42512 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136082AbRAGUvk>; Sun, 7 Jan 2001 15:51:40 -0500
Subject: Re: Ext2 (dma ?) error
To: m.duelli@web.de (Michael Duelli)
Date: Sun, 7 Jan 2001 20:53:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010107214838.A1086@Unimatrix01.surf-callino.de> from "Michael Duelli" at Jan 07, 2001 09:48:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FMop-0003Ic-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fsck discovered an error it wasn't able to fix. This error never
> appeared before and my Seagate HD actually should be alright.

Umm the error says not

> hda: dma_intr: status=0x51 { DriveReady SeekCompleteError }
> hda: dma_intr: error=0x40 { UncorrectableError } LBAsect = 2421754, sector
> 210048
> end_request: I/O error, dev 03:03 (hda), sector 2100448

Thats a media error. It may go away if the block is rewritten , on a reformat
etc. But its the disk reporting a bad block. Now that could be a 2.4 artifact
(incredibly unlikely) so try fscking with 2.2 just to be sure is not an error
reporting bug.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
