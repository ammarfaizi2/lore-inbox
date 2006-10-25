Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422842AbWJYVGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422842AbWJYVGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422867AbWJYVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:06:34 -0400
Received: from c60.cesmail.net ([216.154.195.49]:19223 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S1422842AbWJYVGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:06:33 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Pavel Roskin <proski@gnu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161808227.7615.0.camel@localhost.localdomain>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 17:06:32 -0400
Message-Id: <1161810392.3441.60.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 21:30 +0100, Alan Cox wrote:
> Ar Mer, 2006-10-25 am 16:11 -0400, ysgrifennodd Pavel Roskin:
> > I don't see any legal reasons behind this restriction.  A driver under
> > GPL should be able to use any exported symbols.  EXPORT_SYMBOL_GPL is a
> > technical mechanism of enforcing GPL against non-free code, but
> > ndiswrapper is free.  The non-free NDIS drivers are not using those
> > symbols.
> 
> The combination of GPL wrapper and the NDIS driver as a work is not free
> (in fact its questionable if its even legal to ship such a combination
> together).

So, the problem is on the legal side.

But I have to ask - which NDIS driver?  I can write a free NDIS driver
and use it with ndiswrapper.  You can say it's a stupid thing to do, but
once you talk about the legality, the only argument should be
legal/illegal.  Besides, it may be a not such a bad idea for a ReactOS
developer writing a ReactOS driver to test it with Linux.

Also, nothing should prevent me from combining ndiswrapper with any
Windows driver in the privacy of my home as long as I don't distribute
anything.  GPL doesn't have use restrictions (although the driver may
have an EULA).

Since the problem is with USB symbols, I can split the USB part from
ndiswrapper and call it ndiswrapper-usb.  Then ndiswrapper-usb will be
calling the GPL-only symbols while ndiswrapper will be loading the
non-free modules.  Good luck catching that!  It's actually a change that
makes sense technically.  Imagine what a change specifically intended to
fool Linux would do!

I don't see how the kernel can detect the cases where GPL is actually
violated without creating problem for honest users.  Kernel code is not
a police department, let alone a court of law.  Let's not create out own
DRM right in the kernel!

Companies that ship ndiswrapper with non-free modules may be breaking
copyright laws already.  But it's not something that should be fought by
kernel patches.

-- 
Regards,
Pavel Roskin

