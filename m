Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVGGDP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVGGDP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 23:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVGFT6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:58:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:53689 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262176AbVGFQJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:09:43 -0400
Date: Wed, 6 Jul 2005 09:07:37 -0700
From: Greg KH <greg@kroah.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050706160737.GC13115@kroah.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706041702.GA10253@kroah.com> <20050706155734.GA4271@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706155734.GA4271@sysman-doug.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 10:57:35AM -0500, Doug Warzecha wrote:
> On Tue, Jul 05, 2005 at 11:17:03PM -0500, Greg KH wrote:
> >    > +static void dcdbas_device_release(struct device *dev)
> >    > +{
> >    > +     /* nothing to release */
> >    > +}
> > 
> >    This is a symptom of a broken driver.
> > 
> >    Hm, I wonder if there's some way for the compiler to check the fact that
> >    a function pointer passed to another function, is really a null
> >    function.  That would stop this kind of nonsense...
> 
> There are other drivers in the kernel tree with null device release functions.

Where?

> > 
> >    I'm sure I commented on this driver already, yet, I never got a response
> >    and the code is not changed.  Is there some reason for this?  That's a
> >    sure way to prevent your patch from ever being applied...
> 
> This is the first comment on the release function.  The code has been
> changing in response to comments from you and others.  We'll continue
> to make changes as needed.

You never responded to those questions though, so determining if the
code was changed is difficult.  And I still see you using ioctls, which,
if I remember, was what I asked about.

thanks,

greg k-h
