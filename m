Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263309AbTDCGxT>; Thu, 3 Apr 2003 01:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbTDCGxS>; Thu, 3 Apr 2003 01:53:18 -0500
Received: from AMarseille-201-1-3-158.abo.wanadoo.fr ([193.253.250.158]:13863
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263309AbTDCGxR>; Thu, 3 Apr 2003 01:53:17 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
In-Reply-To: <1049352298.579.23.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
	 <1049330578.1029.38.camel@localhost.localdomain>
	 <1049352298.579.23.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049353552.579.45.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Apr 2003 09:05:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just define an ioctl for that and let each driver that support EDID
> return something seem to be the simplest way.

Replying to myself... and definitely not the best way for 2.5
(would be ok for 2.4 but do we care at this point ?)

Instead, we'd rather add the EDID as an attribute of the fb
to sysfs.

Actually, I suggest that each fbdev driver defines ones or more
nodes in sysfs below the actual driver node, representing the
various heads. Each head would then have attributes representing
the various display properties, one beeing the EDID block.

> If we really want to make EDID a generic thing, then we can eventually
> have the EDID block attached to each fb_info and then a generic
> fbmem.c ioctl to read it, but then make sure that EDID block isn"t
> mandatory (it has no sense to some specific HW like some embedded
> stuffs) and I always prefer when drivers are the real target of
> the calls like this ioctl, eventually using fbdev "tools" as helpers
> instead of having fbdev do something directly as a "mid-mayer".
> 
> Ben.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
