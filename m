Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292511AbSBTVER>; Wed, 20 Feb 2002 16:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292510AbSBTVEH>; Wed, 20 Feb 2002 16:04:07 -0500
Received: from [62.47.19.142] ([62.47.19.142]:9345 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S292508AbSBTVDv>;
	Wed, 20 Feb 2002 16:03:51 -0500
Message-ID: <3C740CC2.21E57B5F@webit.com>
Date: Wed, 20 Feb 2002 21:53:22 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: Cesar Suga <sartre@linuxbr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A simple patch for SIS (documentation and kbuild)
In-Reply-To: <Pine.LNX.4.40.0202201625000.2588-100000@sartre.linuxbr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cesar Suga wrote:
> 
> On Wed, 20 Feb 2002, Thomas Winischhofer wrote:
> 
> > +SiS 300/540/630
> > +CONFIG_DRM_SIS
> > +  Choose this option if you have a SIS 300, 540 or 630 graphics card.
> > +  If M is selected, the module will be called sis.o.  AGP support is
> > +  required for this driver to work.
> 
> > Before posting patches you'd better inform yourself.
> 
> > AGP is *not* required.
> 
>         Ah, sorry. I didn't notice __MUST_HAVE_AGP to be zero. I'll take
> care.

I'd recommend the following dependencies:

Rule 1:
If SiS DRM is selected, SiS framebuffer *MUST* be selected as well

Rule 2:
If SiS framebuffer is a MODULE, SiS DRM *MUST* be a MODULE, too

Rule 3:
If SiS DRM is compiled into the kernel (which I don't recommend), sisfb
*MUST* be compiled into the kernel, too.

(SiS framebuffer can be inside the kernel, in this case DRM can be a
module)

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
