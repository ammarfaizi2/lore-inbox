Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUKII1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUKII1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUKII1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:27:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:16550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261443AbUKII1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:27:52 -0500
Date: Tue, 9 Nov 2004 00:27:35 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tj@home-tj.org, mingo@elte.hu, diffie@gmail.com,
       linux-kernel@vger.kernel.org, diffie@blazebox.homeip.net,
       alan@lxorguk.ukuu.org.uk, Andries.Brouwer@cwi.nl
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041109082735.GB9826@kroah.com>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu> <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org> <20041109071455.GA11643@kroah.com> <20041109080509.GA10724@kroah.com> <20041109001552.4465c23f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109001552.4465c23f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 12:15:52AM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > Andrew, does the patch below fix the issue for you?  It fixed my test
> >  case.
> 
> Dunno - I can't configure 512 legacy ptys any more ;)
> 
> >   		if (parent)
> >   			kobject_put(parent);
> 
> kobject_put(NULL) is legal...

Sure, now it is, but that's a recent (less than 1 month) thing.  Wasn't
legal back when that code was written :)

thanks,

greg k-h
