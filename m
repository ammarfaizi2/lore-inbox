Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271929AbTG2RZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271933AbTG2RZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:25:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41970 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271929AbTG2RZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:25:19 -0400
Date: Tue, 29 Jul 2003 19:24:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Tomas Szepe <szepe@pinerecords.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] kill surplus menu in IDE Kconfig
In-Reply-To: <Pine.LNX.4.44.0307271508020.714-100000@serv>
Message-ID: <Pine.SOL.4.30.0307291913460.17634-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for doing this guys.

I wanted to apply this but then I've noticed that it moves
around some config options which are destined to die.

So instead I want to:
- kill CONFIG_BLK_DEV_IDE_MODES (and ide_modes.h)
- kill CONFIG_BLK_DEV_PDC202XX
- redo your changes in respect to CONFIG_BLK_DEV_IDE
- use "if BLK_DEV_IDEDMA_PCI ... endif" instead of "depends on"
- use "if IDE_CHIPSETS ... endif" instead of "depends on"

Does it sound sane?  If so I will later post patches for you review.
:-)
--
Bartlomiej


