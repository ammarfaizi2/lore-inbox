Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274800AbTGaQC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274804AbTGaQC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:02:57 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:32398 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S274800AbTGaQCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:02:53 -0400
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to
	2.6.0-test2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <200307311449.43853.eu@marcelopenna.org>
References: <200307311449.43853.eu@marcelopenna.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059667126.16608.40.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Jul 2003 16:58:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-31 at 18:49, Marcelo Penna Guerra wrote:
> if (!is_sata(hwif)) 
>        hwif->atapi_dma = 1;
> 
> and DMA is not enabled by default.
> 
> I think it should be:
> 
> if (is_sata(hwif)) 
>        hwif->atapi_dma = 1;
> 
> With this DMA is enabled by default on my board and works great.

You've accidentally worked around a different bug

