Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132238AbRCVXP3>; Thu, 22 Mar 2001 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132239AbRCVXPT>; Thu, 22 Mar 2001 18:15:19 -0500
Received: from ns2.cypress.com ([157.95.67.5]:16257 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S132238AbRCVXPD>;
	Thu, 22 Mar 2001 18:15:03 -0500
Message-ID: <3ABA8737.82BD7ACA@cypress.com>
Date: Thu, 22 Mar 2001 17:13:59 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB oops Linux 2.4.2ac6
In-Reply-To: <20010228175009.A27630@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitcev wrote:
> 
> > > 2.4.2-ac6
> > > o USB hub kmalloc wrong size corruption fix (Peter Zaitcev)
> 
> > The first line of the oops is
> >
> > ----
> > kernel BUG at slab.c:1398!
> > ----
> > Any other ideas to try?
> >         -Thomas
> 
> I did not break it, honest! I will be looking in a USB mouse
> problem though. If you need an immediate resolution, nice
> folks at linux-usb@lists.sourceforge.net may be able to help.
> Or may be not :)

I found the problem.
CONFIG_DEBUG_SLAB "Debug memory allocation"
in the 2.4.2-ac series doesn't work with USB.

2.4.2-ac5 just booted and found the mouse correctly.
On to ac-21 now...

Did David Brownell's patch to disable OHCI loading
on the AMD-756 make it into the source trees?

	-Thomas
