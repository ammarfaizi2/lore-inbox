Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWJJKBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWJJKBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 06:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWJJKBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 06:01:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44461 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965149AbWJJKBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 06:01:51 -0400
Subject: Re: [PATCH] apparent typo in ixgb.h, "_DEBUG_DRIVER_" looks wrong
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
In-Reply-To: <Pine.LNX.4.64.0610100522240.6146@localhost.localdomain>
References: <Pine.LNX.4.64.0610100219590.3442@localhost.localdomain>
	 <20061010091501.GA5369@martell.zuzino.mipt.ru>
	 <Pine.LNX.4.64.0610100522240.6146@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 12:01:46 +0200
Message-Id: <1160474506.3000.280.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 05:28 -0400, Robert P. J. Day wrote:
> On Tue, 10 Oct 2006, Alexey Dobriyan wrote:
> 
> > On Tue, Oct 10, 2006 at 02:27:34AM -0400, Robert P. J. Day wrote:
> > > I'm *guessing* that "_DEBUG_DRIVER_" should really be
> > > "DEBUG_DRIVER" here, since there is no other occurrence of the
> > > former anywhere in the source tree.
> >
> > Since it's debugging guard, underscored or not... doesn't matter.
> > Convert to pr_debug or dev_dbg of you want to deal with it.
> >
> > > --- a/drivers/net/ixgb/ixgb.h
> > > +++ b/drivers/net/ixgb/ixgb.h
> > > @@ -77,7 +77,7 @@ #include "ixgb_hw.h"
> > >  #include "ixgb_ee.h"
> > >  #include "ixgb_ids.h"
> > >
> > > -#ifdef _DEBUG_DRIVER_
> > > +#ifdef DEBUG_DRIVER
> > >  #define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
> > >  #else
> > >  #define IXGB_DBG(args...)
> 
> but what you're suggesting is not equivalent.  i submitted that patch
> to fix what *seems* to be an obvious, innocuous typo, to bring that
> one header file into sync with the rest of the source tree, nothing
> more.
> 
> if all debugging should now use either of pr_debug() or dev_dbg(),
> that's fine but i notice that both of those macros will be defined
> only if "DEBUG" is defined, not "DEBUG_DRIVER".  so making the change
> you suggest would *not* be a trivial change.
> 
> what's the current standard for debugging directives in the kernel?

to use pr_debug or dev_dbg.
Yes it'll mean a slight change for this driver, but just do it. 


