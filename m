Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWIJTNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWIJTNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWIJTM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:12:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7345 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932523AbWIJTM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:12:58 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <200609101018.06930.jbarnes@virtuousgeek.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <45028F87.7040603@garzik.org>
	 <20060909.030854.78720744.davem@davemloft.net>
	 <200609101018.06930.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 20:35:19 +0100
Message-Id: <1157916919.23085.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-10 am 10:18 -0700, ysgrifennodd Jesse Barnes:
> We already have readX_relaxed, but that's for PIO vs. DMA ordering, not 
> PIO vs. PIO.  To distinguish from that case maybe writeX_weak or 
> writeX_nobarrier would make sense?

We have existing users of the format "__foo" for unlocked or un-ordered
foo. __readl seems fairly natural and its shorter to write than
_nobarriermaybesyncsafterlockbutnotwithmmio()

Alan

