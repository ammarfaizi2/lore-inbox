Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVDGGlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVDGGlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVDGGlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:41:51 -0400
Received: from colino.net ([213.41.131.56]:15603 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261505AbVDGGlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:41:35 -0400
Date: Thu, 7 Apr 2005 08:41:09 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
Message-ID: <20050407084109.19cfd858@colin.toulouse>
In-Reply-To: <1112828577.9568.199.camel@gaston>
References: <20050405204449.5ab0cdea@jack.colino.net>
	<200504051353.36788.david-b@pacbell.net>
	<20050406192007.7f71c61d@jack.colino.net>
	<200504061311.53720.david-b@pacbell.net>
	<1112828577.9568.199.camel@gaston>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2005 09:02:57 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > Interesting.  Looks like pci_enable_wake(dev, state, 0) isn't
> > actually disabling wakeup on your hardware.  (Assuming
> > CONFIG_USB_SUSPEND=n; if not, then it's odd that the system went
> > back to sleep!)  Do you think that might be related to those calls
> > manipulating the Apple ASICs being in the OHCI layer rather than up
> > nearer the generic PCI glue?  (I still think they don't belong in
> > USB code -- ohci or usbcore -- at all.  If the platform-specific
> > PCI hooks don't suffice, they need fixing.)
> 
> There are no platform hooks in the right place for now afaik.

Nope, not in upstream, but I used the ohci patch from Paul Mackerras
previously.

> Anyway, I think Colin's controller is an OHCI/EHCI NEC chip, so not
> an Apple ASIC, it's not doing anything in those calls.


-- 
Colin
