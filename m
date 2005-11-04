Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVKDXLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVKDXLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVKDXLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:11:08 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32152
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750933AbVKDXLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:11:05 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: azarah@nosferatu.za.org
Subject: Re: initramfs for /dev/console with udev?
Date: Fri, 4 Nov 2005 17:10:36 -0600
User-Agent: KMail/1.8
Cc: Roland Dreier <rolandd@cisco.com>,
       Robert Schwebel <r.schwebel@pengutronix.de>,
       linux-kernel@vger.kernel.org
References: <20051102222030.GP23316@pengutronix.de> <200511031529.59529.rob@landley.net> <1131140350.9669.7.camel@lycan.lan>
In-Reply-To: <1131140350.9669.7.camel@lycan.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041710.36752.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 15:39, Martin Schlemmer wrote:
> > Ok, I remember why I stopped playing with klibc now.  It's still deep in
> > alpha-test stage, requires way more incestuous knowledge of the kernel
> > headers than anything not bundled with the kernel itself has any excuse
> > for, and I'm still not sure what advantage it claims to have over uClibc
> > except for being BSD licensed.
>
> Well, apparently the plan is to eventually bundle it with the kernel if
> not mistaken.  Also, it have seen a stable release, and it works well
> for what it was intended for, and still have a less footprint than
> uClibc if space is really an issue.

*shrug*.  It only does static linking and uClibc can static link too.  But 
there are no plans to bundle uClibc with the kernel. :)

> > If you have to make it work, I'd suggest extracting a fresh kernel
> > tarball, do "make allyesconfig" (without ARCH=um), and use _those_
> > headers.  Or just accept that it doesn't work and try uClibc. :)
>
> It does work, just need to be fixed up for ARCH=um compiled kernel.  I
> did a quick hack to do this, but HPA don't like it (and I do not blame
> him).  Can be found here:
>
> http://bugs.gentoo.org/attachment.cgi?id=67478

And apparently one of the goals of the 2.6.14 release (or one of the dot 
releases after it) is working with klibc, so I'll wander back to playing with 
uClibc...

Rob
