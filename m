Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbTJQKSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTJQKSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:18:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58864 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263363AbTJQKS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:18:29 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Date: Fri, 17 Oct 2003 12:22:29 +0200
User-Agent: KMail/1.5.4
Cc: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
References: <200310162344.09021.bzolnier@elka.pw.edu.pl> <20031017095117.GB1690@tmathiasen>
In-Reply-To: <20031017095117.GB1690@tmathiasen>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171222.29796.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 of October 2003 11:51, Torben Mathiasen wrote:
> On Thu, Oct 16 2003, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > I wonder if this patch fixes problems (reported back in 2.4.21 days)
> > with CSB5 IDE and Compaq Proliant machines.  Please test it if you can.
>
> Hi Bart,
>
> Funny you should send this as I was just looking at it. The good news is
> that it works!. We're not seeing any failed commands during boot anymore. I
> tested it on both 2.4.23-pre7 and 2.6.0-test7.

Great!

> Also, the previous problem we had where Linux would enable DMA on a device
> (system) not supporting it has also been fixed now that we look at the
> dma_stat bits to determine whether the BIOS indicated DMA. We're currently

Can I assume that "biostimings" option is no longer needed for ServerWorks?

If so I will remove it because it is dangerous on many chipsets.
Even if some chipset needs it in the future it should be reimplemented
in specific chipset driver, not in generic IDE code.

> making sure that all of our servers does proper BIOS IDE setup to make
> things work as expected.
>
> Thanks for the patch, please include it.

Sure.

thanks,
--bartlomiej

