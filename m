Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVAEJtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVAEJtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVAEJtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:49:51 -0500
Received: from mail.dif.dk ([193.138.115.101]:11238 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262326AbVAEJto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:49:44 -0500
Date: Wed, 5 Jan 2005 10:45:38 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-mtd <linux-mtd@lists.infradead.org>,
       David Woodhouse <dwmw2@redhat.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wh.fh-wedel.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove unnessesary casts from drivers/mtd/maps/nettel.c
 and kill two warnings
In-Reply-To: <41DB343F.5070207@snapgear.com>
Message-ID: <Pine.LNX.4.61.0501051044060.6112@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.61.0412262202510.3552@dragon.hygekrogen.localhost>
 <41DB343F.5070207@snapgear.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Greg Ungerer wrote:

> 
> Sorry for the slow response, I have been out on vacation the
> last couple of weeks :-)
> 
I Hope you had a nice vacation. :)

> 
> Jesper Juhl wrote:
> > I took a look at the cause for these warnings in the 2.6.10 kernel,
> > 
> > drivers/mtd/maps/nettel.c:361: warning: assignment makes pointer from
> > integer without a cast
> > drivers/mtd/maps/nettel.c:395: warning: assignment makes pointer from
> > integer without a cast
> > 
> > and as far as I can see the casts in there (to unsigned long and back to
> > void*) are completely unnessesary ('virt' in 'struct map_info' is a void
> > __iomem *), and getting rid of those casts buys us a warning free build.
> > 
> > Are there any reasons not to apply the patch below?
> > Unfortunately I don't have hardware to test this patch, so it has been
> > compile tested only.
> 
> Looks good to me. I have applied it to my working tree.
> Do you want me to send it to Linus?
> 

I'd appreciate that.

-- 
Jesper Juhl

