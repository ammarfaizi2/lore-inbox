Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264887AbUEKXWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUEKXWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUEKXV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:21:59 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:11137 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265054AbUEKXUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:20:52 -0400
Date: Wed, 12 May 2004 00:20:51 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sf.net
Subject: Re: From Eric Anholt:
In-Reply-To: <20040511222245.GA25644@kroah.com>
Message-ID: <Pine.LNX.4.58.0405120018360.3826@skynet>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org> <20040511222245.GA25644@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Ick, you can't use "int" as an ioctl structure member, sorry.  Please
> use the proper "__u16" or "__u32" value instead.

I just looked at drm.h and nearly all the ioctls use int, this file is
included in user-space applications also at the moment, I'm worried
changing all ints to __u32 will break some of these, anyone on DRI list
care to comment?

Dave.

 >
> And what about kernels running in 64bit mode with 32bit userspace?  Care
> to provide the proper thunking layer for them too?
>
> thanks,
>
> greg k-h
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

