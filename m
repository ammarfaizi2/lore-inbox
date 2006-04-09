Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDIPDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDIPDw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWDIPDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:03:52 -0400
Received: from [4.79.56.4] ([4.79.56.4]:56211 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750759AbWDIPDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:03:51 -0400
Subject: Re: [2.6 patch] drivers/isdn/capi/capiutil.c: unexport
	capi_message2str
From: Arjan van de Ven <arjan@infradead.org>
To: Karsten Keil <kkeil@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060409130730.GA27948@pingi.kke.suse.de>
References: <20060407211736.GO7118@stusta.de>
	 <20060409130730.GA27948@pingi.kke.suse.de>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 17:02:39 +0200
Message-Id: <1144594959.2989.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-09 at 15:07 +0200, Karsten Keil wrote:
> On Fri, Apr 07, 2006 at 11:17:36PM +0200, Adrian Bunk wrote:
> > This patch removes an unused EXPORT_SYMBOL.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.17-rc1-mm1-full/drivers/isdn/capi/capiutil.c.old	2006-04-07 10:47:30.000000000 +0200
> > +++ linux-2.6.17-rc1-mm1-full/drivers/isdn/capi/capiutil.c	2006-04-07 10:47:37.000000000 +0200
> > @@ -855,5 +855,4 @@
> >  EXPORT_SYMBOL(capi_cmsg_header);
> >  EXPORT_SYMBOL(capi_cmd2str);
> >  EXPORT_SYMBOL(capi_cmsg2str);
> > -EXPORT_SYMBOL(capi_message2str);
> >  EXPORT_SYMBOL(capi_info2str);
> > 
> 
> Yes it is currently unused, but part of the CAPI driver SDK for supporting
> debug messages in capi drivers, so I would tend to let it exported, if here
> are not strong arguments against exporting it.

every export takes space in the binary kernel. There's some 900 of these
unused ones, totalling to about 100Kb of unused bloat. 

