Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWFNXfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWFNXfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWFNXfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:35:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:55475 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965034AbWFNXfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:35:11 -0400
Date: Wed, 14 Jun 2006 16:35:07 -0700
From: Greg KH <greg@kroah.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, vgoyal@in.ibm.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060614233507.GA23629@kroah.com>
References: <11501587043722-git-send-email-greg@kroah.com> <11501587082203-git-send-email-greg@kroah.com> <11501587122736-git-send-email-greg@kroah.com> <11501587153872-git-send-email-greg@kroah.com> <11501587193060-git-send-email-greg@kroah.com> <11501587223213-git-send-email-greg@kroah.com> <11501587273612-git-send-email-greg@kroah.com> <11501587303683-git-send-email-greg@kroah.com> <11501587343689-git-send-email-greg@kroah.com> <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 02:20:06PM +0200, Geert Uytterhoeven wrote:
> On Mon, 12 Jun 2006, Greg KH wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > Introduce the Kconfig entry and actually switch to a 64bit value, if
> > wanted, for resource_size_t.
> 
> > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > index 805b81f..22dcaa5 100644
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -368,6 +368,13 @@ config 060_WRITETHROUGH
> >  
> >  source "mm/Kconfig"
> >  
> > +config RESOURCES_32BIT
> > +	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
> > +	depends on EXPERIMENTAL
> > +	help
> > +	  By default resources are 64 bit. This option allows memory and IO
> > +	  resources to be 32 bit to optimize code size.
> > +
> >  endmenu
> 
> Why is the default 64 bit? Because 32 bit became experimental?

That's a really good question.  Vivek, why did you change it to be this
way?  In thinking about it some more, this should be a 64bit option
instead.

thanks,

greg k-h
