Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTJQJwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbTJQJwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:52:46 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:20740 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263365AbTJQJwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:52:45 -0400
Date: Fri, 17 Oct 2003 11:51:17 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>,
       Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Message-ID: <20031017095117.GB1690@tmathiasen>
References: <200310162344.09021.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310162344.09021.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
X-OS: Linux 2.4.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> I wonder if this patch fixes problems (reported back in 2.4.21 days)
> with CSB5 IDE and Compaq Proliant machines.  Please test it if you can.
>
Hi Bart,

Funny you should send this as I was just looking at it. The good news is that
it works!. We're not seeing any failed commands during boot anymore. I tested
it on both 2.4.23-pre7 and 2.6.0-test7.

Also, the previous problem we had where Linux would enable DMA on a device
(system) not supporting it has also been fixed now that we look at the dma_stat
bits to determine whether the BIOS indicated DMA. We're currently making sure
that all of our servers does proper BIOS IDE setup to make things work as expected.

Thanks for the patch, please include it.

Torben
