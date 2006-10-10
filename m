Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933027AbWJJLhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbWJJLhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 07:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933028AbWJJLhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 07:37:37 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:56030 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S933027AbWJJLhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 07:37:37 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 07:35:42 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] ixgb.h: Redefine IXGB_DBG() macro to use pr_debug().
In-Reply-To: <1160479883.3000.284.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0610100732350.7386@localhost.localdomain>
References: <Pine.LNX.4.64.0610100713350.7179@localhost.localdomain>
 <1160479883.3000.284.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Arjan van de Ven wrote:

> On Tue, 2006-10-10 at 07:17 -0400, Robert P. J. Day wrote:
> > Simplify the definition of IXGB_DBG() to be based on pr_debug().
> >
> > Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> > ---
> > diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
> > index 50ffe90..16e6c3d 100644
> > --- a/drivers/net/ixgb/ixgb.h
> > +++ b/drivers/net/ixgb/ixgb.h
> > @@ -77,11 +77,7 @@ #include "ixgb_hw.h"
> >  #include "ixgb_ee.h"
> >  #include "ixgb_ids.h"
> >
> > -#ifdef _DEBUG_DRIVER_
> > -#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
> > -#else
> > -#define IXGB_DBG(args...)
> > -#endif
> > +#define IXGB_DBG(args...) pr_debug("ixgb: ", args)
>
>
> while this is of course correct, why not go all the way and replace all
> IXGB() users to pr_debug() directly?

fair enough, i can do that.  back later.

rday
