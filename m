Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUAUEiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUAUEgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:36:22 -0500
Received: from dp.samba.org ([66.70.73.150]:32737 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266055AbUAUEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:35:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support 
In-reply-to: Your message of "Tue, 20 Jan 2004 10:30:54 BST."
             <20040120093054.GC18096@bytesex.org> 
Date: Wed, 21 Jan 2004 11:26:03 +1100
Message-Id: <20040121043608.7F1F02C141@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120093054.GC18096@bytesex.org> you write:
> On Tue, Jan 20, 2004 at 12:55:39PM +1100, Rusty Russell wrote:
> > In message <20040115115611.GA16266@bytesex.org> you write:
> > > +static int repeat = 1;
> > > +MODULE_PARM(repeat,"i");
> > > +MODULE_PARM_DESC(repeat,"auto-repeat for IR keys (default: on)");
> > > +
> > > +static int debug = 0;    /* debug level (0,1,2) */
> > > +MODULE_PARM(debug,"i");
> > 
> > Please replace the MODULE_PARM lines with the modern form:
> > 
> > 	module_param(repeat, bool, 0644);
> > 	module_param(debug, int, 0644);
> 
> No.  The code in question must also build on 2.4 kernels which don't
> have module_param().  And I don't want to clutter up the code with
> #ifdefs unless I absolutely have to.

Sure!  I'll write and test the forward compat macros for 2.4, submit
them to Marcelo, and then bother you again 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
