Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbTC1RNV>; Fri, 28 Mar 2003 12:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTC1RNV>; Fri, 28 Mar 2003 12:13:21 -0500
Received: from [81.2.110.254] ([81.2.110.254]:4093 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263067AbTC1RNU>;
	Fri, 28 Mar 2003 12:13:20 -0500
Subject: Re: [PATCH] IDE 2.5.66-masked_irq-fix-A0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0303280201250.27389-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0303280201250.27389-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048872307.5056.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 17:25:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 01:05, Bartlomiej Zolnierkiewicz wrote:
> > logic is sound enough and I will fix it properly using the NO_IRQ
> > stuff
> 
> Something like that?
> 	if (masked_irq != IDE_NO_IRQ && masked_irq != hwif->irq)

I need to look at that further. Re-reading the code the non backed out logic
seems right. Its causing problems but I'm now less convinced it is the
guilty party.

	If the hwif irq is not masked
		mask it


