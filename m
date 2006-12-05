Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966205AbWLEXGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966205AbWLEXGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966995AbWLEXGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:06:06 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:52003 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966205AbWLEXGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:06:04 -0500
Date: Tue, 5 Dec 2006 15:06:46 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ian Romanick <idr@us.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA and SiS AGP chipsets are x86-only
Message-Id: <20061205150646.c92ef919.randy.dunlap@oracle.com>
In-Reply-To: <4575F929.9020708@us.ibm.com>
References: <20061204104314.GB3013@parisc-linux.org>
	<4575F929.9020708@us.ibm.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 14:56:41 -0800 Ian Romanick wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Matthew Wilcox wrote:
> > There's no point in troubling the Alpha, IA-64, PowerPC and PARISC
> > people with SiS and VIA options.  Andrew thinks it helps find bugs,
> > but there's no evidence of that.
> > 
> > Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> > 
> > diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
> > index c603bf2..a9f9c48 100644
> > --- a/drivers/char/agp/Kconfig
> > +++ b/drivers/char/agp/Kconfig
> > @@ -86,7 +86,7 @@ config AGP_NVIDIA
> > 
> >  config AGP_SIS
> >  	tristate "SiS chipset support"
> > -	depends on AGP
> > +	depends on AGP && X86
> >  	help
> >  	  This option gives you AGP support for the GLX component of
> >  	  X on Silicon Integrated Systems [SiS] chipsets.
> > @@ -103,7 +103,7 @@ config AGP_SWORKS
> > 
> >  config AGP_VIA
> >  	tristate "VIA chipset support"
> > -	depends on AGP
> > +	depends on AGP && X86
> >  	help
> >  	  This option gives you AGP support for the GLX component of
> >  	  X on VIA MVP3/Apollo Pro chipsets.
> 
> I don't know about SiS, but this is certainly *not* true for Via.  There
> are some PowerPC and, IIRC, Alpha motherboards that have Via chipsets.
> My config-fu isn't quite what it should be, so this may be a dumb
> question.  Does the "& X86" requirement exclude x86-64?

No, X86 includes both X86_32 and X86_64.

---
~Randy
