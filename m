Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUIIWgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUIIWgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUIIWgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:36:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:7609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266585AbUIIWgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:36:36 -0400
Date: Thu, 9 Sep 2004 15:36:06 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: eric.valette@free.fr, linux-kernel@vger.kernel.org, petkan@nucleusys.com
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver : fixed
Message-ID: <20040909223605.GA17655@kroah.com>
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr> <20040909152454.14f7ebc9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909152454.14f7ebc9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 03:24:54PM -0700, Andrew Morton wrote:
> Eric Valette <eric.valette@free.fr> wrote:
> >
> > Here is a small patch that makes the card functionnal again. I've 
> > forwarded the patch to driver author also.
> > 
> > --- linux/drivers/usb/net/rtl8150.c-2.6.9-rc1-mm4.orig	2004-09-09 11:15:11.000000000 +0200
> > +++ linux/drivers/usb/net/rtl8150.c	2004-09-09 11:15:46.000000000 +0200
> > @@ -341,7 +341,7 @@
> >  
> >  static int rtl8150_reset(rtl8150_t * dev)
> >  {
> > -	u8 data = 0x11;
> > +	u8 data = 0x10;
> 
> hm, OK.  Presumably the change (which comes in via the bk-usb tree) was
> made for a reason.  So I suspect both versions are wrong ;)
> 
> But it might be risky for Greg to merge this patch up at present.

As all your patch does is revert the patch in my tree (it was a one line
change), mainline should work just fine for you, right?

I'll defer to Petkan as to what to do about this, as he sent me that
patch for a good reason I imagine :)

thanks,

greg k-h
