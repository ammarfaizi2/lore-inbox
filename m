Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTKVWTP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTKVWTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 17:19:15 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49382 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262792AbTKVWTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 17:19:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chris Cheney <ccheney@cheney.cx>
Subject: Re: bugme #1217: "Use PCI DMA by default when available" does not work
Date: Sat, 22 Nov 2003 23:20:18 +0100
User-Agent: KMail/1.5.4
References: <20031122204828.GE1411@cheney.cx>
In-Reply-To: <20031122204828.GE1411@cheney.cx>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311222320.18382.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris, please post output of 'lspci -vvv -xxx' - it will be very useful.
We can see what registers are programmed differently when autodma is off.

--bart

On Saturday 22 of November 2003 21:48, Chris Cheney wrote:
> I sent the following followup report to the bug I filed at
> bugme.osdl.org several months ago about my hpt372 ide controller being
> slow.
>
> I have determined what causes the dramatic slowdown problem. It is not
> drive specific but it may be specific to the hpt controllers. The
> problem is due to using automatic dma. If I don't have the following
> two options set in my kernel then it runs at full speed when I turn on
> dma with hdparm. Otherwise using automatic dma I get somewhere between
> a 50% - 700% slowdown on writes, reads seem to not be as badly affected.
> This is reproducible on both 2.4.23-rc1-xfs and 2.6.0-test9-bk24 (the
> two I tested on).
>
> CONFIG_IDEDMA_PCI_AUTO=3Dy=20
> CONFIG_IDEDMA_AUTO=3Dy=20

