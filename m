Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272551AbTGaP2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272543AbTGaP06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:26:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46481 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272545AbTGaP0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:26:09 -0400
Date: Thu, 31 Jul 2003 17:25:37 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to 2.6.0-test2
In-Reply-To: <200307311449.43853.eu@marcelopenna.org>
Message-ID: <Pine.SOL.4.30.0307311710440.8394-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jul 2003, Marcelo Penna Guerra wrote:

> Hi,

Hi,

> I don't know if anyone is working on this, but I merged the changes from
> siimage 1.06 present in 2.4.x to 2.6.0-test2. I'm really not very familiar
> with the IDE code, so it's probably a good idea if someone could take a look
> at it. All I can tell is it's working with the SiI3112A present in my
> motherboard and it's a lot more stable than before.

Thanks, I'll take a look.

What do you mean by "a lot more stable than before"?

> I also added the suggestion from Andre to make the driver not care about cable
> detection and found a possible bug in the 2.4.x code.

Can you separate your changes from forward-port?

> In 2.4.22-pre9:
>
> if (!is_sata(hwif))
>        hwif->atapi_dma = 1;
>
> and DMA is not enabled by default.

This means that if this is a SATA controller DMA shouldn't be
enabled on ATAPI devices.  There are probably some reasons to do this.

> I think it should be:
>
> if (is_sata(hwif))
>        hwif->atapi_dma = 1;
>
> With this DMA is enabled by default on my board and works great.

Are you aware of side effect?
[ Disabling DMA on ATAPI devices on SiI680. ]

Please consult this change with Alan :-).

> Marcelo Penna Guerra

Regards,
--
Bartlomiej


