Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSEONV3>; Wed, 15 May 2002 09:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314392AbSEONV2>; Wed, 15 May 2002 09:21:28 -0400
Received: from skunk.directfb.org ([212.84.236.169]:19852 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S314325AbSEONV0>; Wed, 15 May 2002 09:21:26 -0400
Date: Wed, 15 May 2002 15:19:42 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Greg KH <greg@kroah.com>
Cc: Denis Oliver Kropp <dok@directfb.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmwarefb 0.5.2
Message-ID: <20020515131942.GA1717@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20020515010242.GA1257@skunk.convergence.de> <20020515042113.GA22029@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (greg@kroah.com):
> On Wed, May 15, 2002 at 03:02:42AM +0200, Denis Oliver Kropp wrote:
> > 
> > Hi,
> > 
> > this is an updated version of the VMware framebuffer driver.
> > It contains a fix regarding the framebuffer offset (screen_base)
> > for non-standard modes.
> 
> Some non-technical questions about this code:
> 	- please read Documentation/CodingStyle and reformat your code
> 	  based on that (scripts/Lindent will do it for you if you
> 	  want.)

Ok, will try that.

> > +++ linux/drivers/video/vmware/svga_reg.h	Tue May 14 01:31:27 2002
> > @@ -0,0 +1,298 @@
> > +/* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/vmware/svga_reg.h,v 1.4 2001/09/13 08:36:24 alanh Exp $ */
> > +/* **********************************************************
> > + * Copyright (C) 1998-2001 VMware, Inc.
> > + * All Rights Reserved
> > + * $Id: svga_reg.h,v 1.16 2001/07/25 22:41:24 mgoodman Exp $
> > + * **********************************************************/
> 
> <snip>
> 
> > +#ifdef MODULE
> > +
> > +MODULE_AUTHOR("(c) 2002  Denis Oliver Kropp <dok@directfb.org>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("FBDev driver for VMware Virtual SVGA Card");
> > +MODULE_PARM(disabled, "i");
> > +MODULE_PARM_DESC(disabled, "Disable this driver's initialization.");
> > +
> > +#endif
> 
> 	- drop the #ifdef, it's not needed.
> 
> 	- you are stating that your module is under the GPL, yet it uses
> 	  two files that are marked "All Rights Reserved" with the
> 	  copyright from VMWare, Inc.  I don't think you can do that :)
> 
> Is VMWare ok with releasing those files under the GPL?  If so, I suggest
> you add that line to those files, and then everything should be fine.

I wasn't sure yet about that issue, but I will try to contact VMWare and ask.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH
