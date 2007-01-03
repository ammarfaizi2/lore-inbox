Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbXACAVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbXACAVA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbXACAVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:21:00 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37305
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750804AbXACAU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:20:59 -0500
Date: Tue, 02 Jan 2007 16:20:58 -0800 (PST)
Message-Id: <20070102.162058.55482337.davem@davemloft.net>
To: James.Bottomley@SteelEye.com
Cc: rmk+lkml@arm.linux.org.uk, miklos@szeredi.hu, arjan@infradead.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167780858.3687.13.camel@mulgrave.il.steeleye.com>
References: <1167778403.3687.1.camel@mulgrave.il.steeleye.com>
	<20070102.151906.21595863.davem@davemloft.net>
	<1167780858.3687.13.camel@mulgrave.il.steeleye.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Tue, 02 Jan 2007 17:34:18 -0600

> Erm ... for a device driver, if we're preparing to do I/O on the page
> something must have made the user caches coherent ... that can't be
> kmap, because the driver might elect to DMA on the page ... unless
> another component of this API is going to be to make dma_map_... also
> flush the user cache?

The DMA map/unmap/sync performs the necessary cache flushes.
