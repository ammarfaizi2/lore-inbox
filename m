Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUIKSQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUIKSQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUIKSQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:16:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:5287 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268269AbUIKSQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:16:41 -0400
Date: Sat, 11 Sep 2004 11:15:40 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Tim Hockin <thockin@hockin.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@ximian.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040911181540.GA7105@kroah.com>
References: <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <20040911001849.GA321@hockin.org> <20040911004827.GA8139@kroah.com> <20040911113525.GA7148@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911113525.GA7148@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 12:35:25PM +0100, Dave Jones wrote:
> On Fri, Sep 10, 2004 at 05:48:27PM -0700, Greg KH wrote:
> 
>  > > What happened to a formatted string argument?  The signal argument can 
>  > > become the pre-formatted string, and someone can provide a wrapper
>  > > that takes a printf() like format and args.
>  > > 	kobject_uevent_printf(kobj, "something bad: 0x%08x", err);
>  > 
>  > Use an attribute, and have userspace read that formatted argument if
>  > need be.  This keeps the kernel interface much simpler, and doesn't
>  > allow you to abuse it for things it is not intended for (like error
>  > reporting stuff...)
> 
> Erm, no. This will just encourage folks to sprintf to a buffer first
> and pass the result to kobject_uevent_printf().

Yeah, I agree.  I think we need to standardize on the "events", and make
it hard to misspell them.  I'll work on that on Monday.

> nitpick: Also, if this isn't taking formatted input, shouldn't the name of the
> function lose the 'f' ?

The function name is kobject_uevent(), no 'f' in sight :)

thanks,

greg k-h
