Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbWCVUsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWCVUsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWCVUsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:48:12 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:51651
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932713AbWCVUsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:48:11 -0500
Date: Wed, 22 Mar 2006 12:47:51 -0800
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: minyard@acm.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: [PATCH 2/2] Add full sysfs support to the IPMI driver
Message-ID: <20060322204751.GC12335@kroah.com>
References: <20060321221328.GB27436@i2.minyard.local> <1143018069.2955.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143018069.2955.43.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 10:01:09AM +0100, Arjan van de Ven wrote:
> On Tue, 2006-03-21 at 16:13 -0600, Corey Minyard wrote:
> 
> 
> > +static void ipmi_bmc_release(struct device *dev)
> > +{
> > +	printk(KERN_DEBUG "ipmi_bmc release\n");
> > +}
> 
> 
> eehhhh NO.
> Please read the many comments and documentations about why a release
> function is NOT allowed to be empty. In fact the kernel warned you about
> that, didn't it?

Of course that's not ok.

Come on people, does everyone think I just put that warning message in
the kernel for fun to force you to create an empty release function?
Why do people ignore the helpful hints that the kernel provides?

I can take that check out and watch people get their code wrong even
more, as it sure doesn't seem like it is helping anyone out these
days...

Corey, haven't we discussed this in the past?

greg k-h
