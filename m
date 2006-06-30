Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWF3RKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWF3RKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWF3RKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:10:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57992 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751626AbWF3RKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:10:52 -0400
Subject: Re: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline
	stall
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
References: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 18:26:56 +0100
Message-Id: <1151688416.31392.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 18:13 +0200, ysgrifennodd Andreas Mohr:
> Use an independently-formatted "unsigned int" for data instead of a
> restrictive "u16" to avoid instruction fetch pipeline stalls
> probably caused by the byte calculations later.

drivers/ide is on its way out. I'm also curious that this shows up given
that the inw() is going to cause a PCI sequence and stall the CPU
entirely for ages anyway.

NAK because
1. This is a gcc problem
2. Not everyone is using an intel x86-32 box which has such problems
3. IDE is in life-support mode and the relatives are already planning
the flowers.

Alan
