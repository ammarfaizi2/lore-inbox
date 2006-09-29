Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWI2AUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWI2AUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWI2AUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:20:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932266AbWI2AUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:20:50 -0400
Date: Thu, 28 Sep 2006 17:20:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [GIT PATCH] More USB patches for 2.6.18
Message-Id: <20060928172037.69a6a401.akpm@osdl.org>
In-Reply-To: <200609281708.34599.david-b@pacbell.net>
References: <20060928224250.GA23841@kroah.com>
	<Pine.LNX.4.64.0609281639040.3952@g5.osdl.org>
	<20060928165951.2c5bd4c7.akpm@osdl.org>
	<200609281708.34599.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 17:08:33 -0700
David Brownell <david-b@pacbell.net> wrote:

> > --- a/drivers/usb/host/ohci-hub.c~ohci-add-auto-stop-support-hack-hack
> > +++ a/drivers/usb/host/ohci-hub.c
> > @@ -132,6 +132,10 @@ static inline struct ed *find_head (stru
> >  	return ed;
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int ohci_restart(struct ohci_hcd *ohci);
> > +#endif
> > +
> >  /* caller has locked the root hub */
> 
> Better to just always include the forward decl... much cleaner!

See other email.

> ... reviewing and testing those new OHCI changes is still on my
> list;

erm, we prefer to do that before code hits mainline.

> all that suspend stuff needs care, things that work on PCs don't
> necessarily work on embedded hardware (where OHCI is common, and
> PM tends to be more critical).

I guess we'll find out.
