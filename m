Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSLBFtr>; Mon, 2 Dec 2002 00:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSLBFtr>; Mon, 2 Dec 2002 00:49:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27910 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264945AbSLBFtp>;
	Mon, 2 Dec 2002 00:49:45 -0500
Date: Sun, 1 Dec 2002 22:57:37 -0800
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@intercode.com.au>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021202065736.GA11477@kroah.com>
References: <20021201192532.GA9278@kroah.com> <Mutt.LNX.4.44.0212021248290.20929-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0212021248290.20929-100000@blackbird.intercode.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 01:00:27PM +1100, James Morris wrote:
> On Sun, 1 Dec 2002, Greg KH wrote:
> 
> > > I think we still want to make sure that the module author has explicitly
> > > accounted for all of the hooks, in case new hooks are added.
> > 
> > But with this patch, if the module author hasn't specified a hook, they
> > get the "dummy" ones.  So the structure should always be full of
> > pointers, making the VERIFY_STRUCT macro pointless.
> 
> Yes, but defaulting unspecified hooks to dummy operations could be
> dangerous.  A module might appear to compile and run perfectly well, but 
> be missing some important new hook.

One could argue that a "important new hook" would provide a sane dummy
operation, or that if the module doesn't need it, why would it want to
provide it?  :)

Anyway, there's no way to resolve both this percieved problem, and the
"smaller and easier" patch that I proposed, right?  Unless we want to
export all dummy operation functions for all modules to use?  I could do
that, but it's pretty messy...

thanks,

greg k-h
