Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWJJMRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWJJMRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWJJMRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:17:01 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:28385 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S965137AbWJJMRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:17:00 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 08:15:01 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Andreas Schwab <schwab@suse.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] ixgb:  Delete IXGB_DBG() macro and call pr_debug()
 directly.
In-Reply-To: <je4pucxtc6.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.64.0610100814020.7689@localhost.localdomain>
References: <Pine.LNX.4.64.0610100738540.7436@localhost.localdomain>
 <je4pucxtc6.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Andreas Schwab wrote:

> "Robert P. J. Day" <rpjday@mindspring.com> writes:
>
> > Remove the minimally-useful definition of IXGB_DBG() and have
> > ixgb_main.c call pr_debug() directly.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> > ---
> > diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
> > index 50ffe90..fb9fde5 100644
> > --- a/drivers/net/ixgb/ixgb.h
> > +++ b/drivers/net/ixgb/ixgb.h
> > @@ -77,12 +77,6 @@ #include "ixgb_hw.h"
> >  #include "ixgb_ee.h"
> >  #include "ixgb_ids.h"
> >
> > -#ifdef _DEBUG_DRIVER_
> > -#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
>                                                ^^^^^^^^
> > -#else
> > -#define IXGB_DBG(args...)
> > -#endif
> > -
> >  #define PFX "ixgb: "
> >  #define DPRINTK(nlevel, klevel, fmt, args...) \
> >  	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
> > diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
> > index e09f575..d063e84 100644
> > --- a/drivers/net/ixgb/ixgb_main.c
> > +++ b/drivers/net/ixgb/ixgb_main.c
> > @@ -1948,7 +1948,7 @@ #endif
> >
> >  			/* All receives must fit into a single buffer */
> >
> > -			IXGB_DBG("Receive packet consumed multiple buffers "
> > +			pr_debug("Receive packet consumed multiple buffers "
>
> Would perhaps be useful to retain the "ixgb:" prefix.

crap, you're right.  my bad.  back into the breech ... argh.  that's
what happens when there's only decaf left in the house.

rday
