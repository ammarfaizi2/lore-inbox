Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268167AbTAKXBx>; Sat, 11 Jan 2003 18:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268172AbTAKXBx>; Sat, 11 Jan 2003 18:01:53 -0500
Received: from AMarseille-201-1-3-87.abo.wanadoo.fr ([193.253.250.87]:18032
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268167AbTAKXBx>; Sat, 11 Jan 2003 18:01:53 -0500
Subject: Re: [PATCH] sl82c105 driver update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030111234819.A17524@ucw.cz>
References: <1042302798.525.66.camel@zion.wanadoo.fr>
	 <20030111223231.B21505@flint.arm.linux.org.uk>
	 <1042325055.525.153.camel@zion.wanadoo.fr>  <20030111234819.A17524@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042326727.541.187.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Jan 2003 00:12:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 23:48, Vojtech Pavlik wrote:

> > Note that I think sl82c105 and ide-pmac are the only ones to redo the
> > DMA config on ide_dma_on. Most chipsets only do it on ide_dma_check, but
> > I chosed to do it in ide_dma_on too mostly because I found no way to
> > re-trigger ide_dma_check from hdparm (well, this might have changed
> > since, I have to dbl check).
> 
> Correct, and it seems that if you have automatic DMA disabled in the
> kernel and then use hdparm -d1, this leads to a lot of trouble.

Which is why I did that in the first place on pmac, so that hdparm -d1
gave proper timings in the first place (my firmware does nothing useful
and I hard reset the drives & controller on boot anyway).


-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
