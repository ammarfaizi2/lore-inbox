Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270102AbRHMLgH>; Mon, 13 Aug 2001 07:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270105AbRHMLf5>; Mon, 13 Aug 2001 07:35:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270102AbRHMLfs>; Mon, 13 Aug 2001 07:35:48 -0400
Subject: Re: Lost interrupt with HPT370
To: kevin@labsysgrp.com (Kevin P. Fleming)
Date: Mon, 13 Aug 2001 12:37:51 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Kevin P. Fleming" at Aug 12, 2001 10:08:12 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WG2Z-0007Di-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have just tried an HPT-366 card with IC35L040VER07 drives (latest DeskStar
> 41G ATA-100, although the card is only ATA-66) and could not get them to
> even let me create a filesystem without hard locking the machine. This was
> using 2.4.8-ac1 and 2.4.7-ac11. I wrote this off to motherboard/IDE card
> compatibility (or lack thereof), but could it still be an IDE driver issue?

Some HPT cards have problems with certain drives. I believe its a fixed
problem in newer boards or on those with updatable firmware if you update
the firmware itself

Check your drive is in the bad_ata100_5 and bad_ata66_4 list. If not add
it then rebuild and retry (drivers/ide/hpt366.c) - and let me know

Alan
