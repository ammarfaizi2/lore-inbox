Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUIKATM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUIKATM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUIKATM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:19:12 -0400
Received: from [66.35.79.110] ([66.35.79.110]:33925 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S268048AbUIKATD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:19:03 -0400
Date: Fri, 10 Sep 2004 17:18:49 -0700
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@ximian.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040911001849.GA321@hockin.org>
References: <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910235409.GA32424@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 04:54:09PM -0700, Greg KH wrote:
> To send an event, the user needs to pass the kobject, a optional
> sysfs-attribute and the signal string to the following function:
>   
>   kobject_uevent(const char *signal,
>                  struct kobject *kobj,
>                  struct attribute *attr)

Sorry I missed the flare up of this topic.  What about events for which
there is no associated kobject?

why is the kobject argument not first?  Seems weird..

What happened to a formatted string argument?  The signal argument can 
become the pre-formatted string, and someone can provide a wrapper
that takes a printf() like format and args.
	kobject_uevent_printf(kobj, "something bad: 0x%08x", err);

Tim
