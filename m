Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVDUJ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVDUJ0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDUJ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 05:26:04 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:8578 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261229AbVDUJZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 05:25:58 -0400
Date: Thu, 21 Apr 2005 18:25:19 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
In-reply-to: <1114000510.6238.66.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-id: <20050421182519.3fdef37d.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
 <1114000510.6238.66.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005 14:35:10 +0200 Arjan van de Ven wrote:
> 
> > diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
> > --- linux-2.6.12-rc2-mm3/drivers/base/node.c~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
> > +++ linux-2.6.12-rc2-mm3-kei/drivers/base/node.c	2005-04-14 20:49:37.000000000 +0900
> > @@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
> >   
> > +EXPORT_SYMBOL(register_node);
> > +EXPORT_SYMBOL(unregister_node);
> > +#endif /* CONFIG_HOTPLUG */
> >  
> 
> please make these EXPORT_SYMBOL_GPL; the rest of sysfs is too and this
> is very much deep kernel internals that are linux specific.

  OK, I will make that change.  Thanks for the comments!

Thanks,
Keiichiro Tokunaga
