Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUATWJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUATWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:08:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:49115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262674AbUATWHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:07:39 -0500
Date: Tue, 20 Jan 2004 14:07:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
Message-ID: <20040120220750.GA3944@kroah.com>
References: <10745567571488@kroah.com> <1074556757661@kroah.com> <20040120230322.24cbe005.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120230322.24cbe005.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 11:03:22PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > (...) Greg, could
> > you please apply the following patch to the "porting-clients" document
> > so that at least the new drivers don't need to be converted
> > afterwards?
> > 
> >  Documentation/i2c/porting-clients |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > 
> > diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
> > --- a/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
> > +++ b/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
> > @@ -92,7 +92,10 @@
> >    i2c_get_clientdata(client) instead.
> >  
> >  * [Interface] Init function should not print anything. Make sure
> > -  there is a MODULE_LICENSE() line.
> > +  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
> > +  by module_param(). Note that module_param has a third parameter,
> > +  that you should set to 0 by default. See
> > include/linux/moduleparam.h+  for details.
> >  
> >  Coding policy:
> 
> On second thought I think I shouldn't have done that change. I2c chip
> drivers use SENSORS_INSMOD_* macros which in the end include
> MODULE_PARM() calls.
> 
> Quoting Rusty Russell: "However, I never implemented mixing old
> and new style in the same module, so if you're adding a parameter, it
> makes sense to convert them all."
> 
> So maybe I shouldn't suggest that new drivers use the new style, since
> they will mix old and new in this case. What about forgetting about that
> doc change for now? Sorry for the trouble, I should have thought about
> that before submitting.

Heh, feel free to port the SENSORS_INSMOD_* crap too if you want to.  I
really hate that code, and want to drop it entirely in 2.7 if
possible...

Or just send me a patch, backing out your change, I'll apply that :)

thanks,

greg k-h
