Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUEKXRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUEKXRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUEKXRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:17:45 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:28288 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263163AbUEKXRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:17:42 -0400
Date: Wed, 12 May 2004 00:17:40 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: From Eric Anholt:
In-Reply-To: <20040511222245.GA25644@kroah.com>
Message-ID: <Pine.LNX.4.58.0405120015420.3826@skynet>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org> <20040511222245.GA25644@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > +/**
> > + * DRM_IOCTL_SET_VERSION ioctl argument type.
> > + */
> > +typedef struct drm_set_version {
> > +	int drm_di_major;
> > +	int drm_di_minor;
> > +	int drm_dd_major;
> > +	int drm_dd_minor;
> > +} drm_set_version_t;
> > +
>
> Ick, you can't use "int" as an ioctl structure member, sorry.  Please
> use the proper "__u16" or "__u32" value instead.

okay I'll submit a fix to Linus rsn ...
>
> And what about kernels running in 64bit mode with 32bit userspace?  Care
> to provide the proper thunking layer for them too?

would love to don't have anyone on team that does 64-bit at the moment or
even has access to 64-bit hardware .. f someone provides the code I'll accept
it, anyway the DRM isn't completely 64-bit safe AFAIK, it has other
"issues",

Thanks,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

