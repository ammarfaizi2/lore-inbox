Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWBMPBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWBMPBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWBMPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:01:15 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:48524 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932112AbWBMPBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:01:14 -0500
Date: Mon, 13 Feb 2006 16:01:13 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove duplicate #includes
Message-ID: <20060213150113.GA13324@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060213093959.GA10496@MAIL.13thfloor.at> <20060213102656.GC26627@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213102656.GC26627@wavehammer.waldi.eu.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 11:26:56AM +0100, Bastian Blank wrote:
> On Mon, Feb 13, 2006 at 10:39:59AM +0100, Herbert Poetzl wrote:
> > diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/drm/drm.h linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h
> > --- linux-2.6.16-rc2/drivers/char/drm/drm.h	2006-02-07 11:52:24 +0100
> > +++ linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h	2006-02-13 01:48:55 +0100
> > @@ -51,11 +51,9 @@
> >  #if defined(__FreeBSD__) && defined(IN_MODULE)
> >  /* Prevent name collision when including sys/ioccom.h */
> >  #undef ioctl
> > -#include <sys/ioccom.h>
> >  #define ioctl(a,b,c)		xf86ioctl(a,b,c)
> > -#else
> > -#include <sys/ioccom.h>
> >  #endif				/* __FreeBSD__ && xf86ioctl */
> > +#include <sys/ioccom.h>
> >  #define DRM_IOCTL_NR(n)		((n) & 0xff)
> >  #define DRM_IOC_VOID		IOC_VOID
> >  #define DRM_IOC_READ		IOC_OUT
> 
> This one changes the behaviour. 

hmm, yes, doesn't make much sense to remove that 
dumplicate entry anyway, so I'll simply drop that
one from the patch ... 

thanks a lot for the feedback!

> But do we want to have this non-linux hacks in the tree?

good question

best,
Herbert

> Bastian
> 
> -- 
> It would be illogical to assume that all conditions remain stable.
> 		-- Spock, "The Enterprise Incident", stardate 5027.3


