Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSEEPtv>; Sun, 5 May 2002 11:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSEEPtu>; Sun, 5 May 2002 11:49:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28143 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S313113AbSEEPtu>; Sun, 5 May 2002 11:49:50 -0400
Date: Sun, 5 May 2002 17:49:34 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Neil Conway <nconway_kernel@yahoo.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, IDE corruption, 2.4.18
Message-ID: <Pine.SOL.4.30.0205051741140.23671-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Explanation: some code now differs in the code path concerned, and
> ide_register_subdriver now only calls ide_dma_check for UDMA drives
> (previously all DMA drives), but ultimately ide_dma_check still ends up
> in ide_config_drive_speed, and that's still fuctionally the same as
> 2.4.

You've got been mistaken by unfortunate name (Martin changed
name dmaproc() to udma() in 2.5.12).
Code calls ide_dma_check for chipsets which registerered udma()
handler (formerly dmaproc()), I think the same 2.4 does.

btw. udma() name is really misleading,
     it should be read (u)dma() not udma() :)

--
bkz

