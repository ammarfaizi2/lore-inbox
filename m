Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVDGGkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVDGGkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVDGGke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:40:34 -0400
Received: from colino.net ([213.41.131.56]:11763 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261423AbVDGGk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:40:29 -0400
Date: Thu, 7 Apr 2005 08:40:00 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       debian-powerpc@lists.debian.org
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
Message-ID: <20050407084000.61cff467@colin.toulouse>
In-Reply-To: <200504061311.53720.david-b@pacbell.net>
References: <20050405204449.5ab0cdea@jack.colino.net>
	<200504051353.36788.david-b@pacbell.net>
	<20050406192007.7f71c61d@jack.colino.net>
	<200504061311.53720.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2005 13:11:53 -0700
David Brownell <david-b@pacbell.net> wrote:

> Interesting.  Looks like pci_enable_wake(dev, state, 0) isn't actually
> disabling wakeup on your hardware.  (Assuming CONFIG_USB_SUSPEND=n; if
> not, then it's odd that the system went back to sleep!) 

Yes, CONFIG_USB_SUSPEND is disabled here.

> Do you think
> that might be related to those calls manipulating the Apple ASICs
> being in the OHCI layer rather than up nearer the generic PCI glue?

To be honest, I don't really know :)

> Thanks for the testing update.  I'm glad to know that there seems to
> be only one (minor) glitch that's PPC-specific!

Yup, me too, I consider it working quite well now :)

> OK, I just posted the patch cleaning up EHCI port power switching;
> that should remove the need for that separate patch.  (As well as
> fixing some minor annoyances.)

Seen that, thanks.
-- 
Colin
