Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTJQKVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTJQKVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:21:30 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:16645 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263373AbTJQKV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:21:29 -0400
Date: Fri, 17 Oct 2003 12:20:02 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>,
       Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Message-ID: <20031017102002.GC1690@tmathiasen>
References: <200310162344.09021.bzolnier@elka.pw.edu.pl> <20031017095117.GB1690@tmathiasen> <200310171222.29796.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310171222.29796.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
X-OS: Linux 2.4.22 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17 2003, Bartlomiej Zolnierkiewicz wrote:
> > Also, the previous problem we had where Linux would enable DMA on a device
> > (system) not supporting it has also been fixed now that we look at the
> > dma_stat bits to determine whether the BIOS indicated DMA. We're currently
> 
> Can I assume that "biostimings" option is no longer needed for ServerWorks?
> 
> If so I will remove it because it is dangerous on many chipsets.
> Even if some chipset needs it in the future it should be reimplemented
> in specific chipset driver, not in generic IDE code.
>

Yes, even though I haven't tested on many systems, I believe this is the right
fix. Regarding the biostimings stuff, then I already sent fixes to Alan a long
time ago but I think they got lost. Please remove it and we can come up with
something else if ever needed.

Torben
-- 
