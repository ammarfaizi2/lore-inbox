Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUCQX7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUCQX7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:59:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:39651 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262205AbUCQX7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:59:45 -0500
Date: Wed, 17 Mar 2004 15:11:35 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com
Cc: linux-kernel@vger.kernel.org, hunold@convergence.de
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Message-ID: <20040317231135.GA4970@kroah.com>
References: <4056C805.8090004@convergence.de> <20040316154454.GA13854@kroah.com> <20040316201426.1d01f1d3.khali@linux-fr.org> <20040316195325.GA22473@kroah.com> <1079515049.405817a9a3da0@imp.gcu.info> <20040317174255.GE19060@kroah.com> <20040317210504.34eb192f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040317210504.34eb192f.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 09:05:04PM +0100, Jean Delvare wrote:
> > > How would we export the value though? Numerical, with user-space
> > > headers to be included by user-space applications? Or converted to
> > > some explicit text strings so that no headers are needed?
> > 
> > A text string would be simple enough to use.
> 
> I'm not sure.  What about a chip driver that would belong to more than
> one class?  What about the eeprom driver which will belong to all
> classes?  With a numeric value, a simple binary operation handles all
> the cases.  With text strings we would end having to parse a possibly
> multi-valued string, and do string comparisons, with at least one
> exception to handle.  This is likely to require much more resources,
> don't you think?

Ok, I wasn't really awake when writing that, you are correct.  Other
devices export "values" that have to be looked up in tables in userspace
(think device ids).  We can just export a hex number that matches the
ones in i2c.h

Anyone want to write a patch?  :)

thanks,

greg k-h
