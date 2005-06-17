Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVFQMnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVFQMnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 08:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVFQMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 08:43:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30340 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261442AbVFQMnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 08:43:23 -0400
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42B07E5D.9070004@rainbow-software.org>
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>
	 <42AD6362.1000109@rainbow-software.org>
	 <1118669975.13260.23.camel@localhost.localdomain>
	 <42AD92F2.7080108@yahoo.com.au>
	 <1118675343.13773.1.camel@localhost.localdomain>
	 <42B07E5D.9070004@rainbow-software.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119012053.27908.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Jun 2005 13:40:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-06-15 at 20:15, Ondrej Zary wrote:
> Now I've tested it with preempt disabled and nothing has changed. When 
> fiddling around with hdparm, I got about 16MB/s max. with 2.6.12-rc5. 
> With 2.4.31, I got about 21MB/s when just the DMA was enabled 
> (read-ahead and multcount set to 0 - changing them does not make almost 
> any difference).

multcount is only used for PIO so that would be expected. Similarly the
block readahead should matter but not anything drive level.

If you compare the hdparm data are both 2.4 and 2.6 selecting the same
IDE modes ?

