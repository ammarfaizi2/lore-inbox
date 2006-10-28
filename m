Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWJ1Rgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWJ1Rgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWJ1Rgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:36:42 -0400
Received: from mail.first.fraunhofer.de ([194.95.169.2]:32743 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751204AbWJ1Rgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:36:41 -0400
Subject: Re: usb initialization order (usbhid vs. appletouch)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200610281903.29510.oliver@neukum.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	 <200610261436.47463.oliver@neukum.org> <1162054576.3769.15.camel@localhost>
	 <200610281903.29510.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Oct 2006 19:36:32 +0200
Message-Id: <1162056992.9216.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 19:03 +0200, Oliver Neukum wrote:
> Am Samstag, 28. Oktober 2006 18:56 schrieb Soeren Sonnenburg:
> > Anyways, back to the above problem. Can one somehow tell the hid-core to
> > load the appletouch driver when it detects any of these devices and then
> > initialize on top of that ? The appletouch driver is completely ignored
> > (doesn't even enter the atp_prope function as usb_register registers
> > with device/product tuples that are already taken by hid....
> > 
> > Any ideas ?
> 
> Try udev to disconnect the hid driver, then load appletouch.

I don't understand... I can disconnect the driver if I do on cmdline
        libhid-detach-device 05ac:<id> ; modprobe appletouch .
However then my keyboard is gone.

Of course there is the workaround of building both the appletouch and
hid driver as modules and then loading them in this order ... but I was
hoping to have them fix in the kernel. If this is however not doable we
should mark it in Kconfig and I will have to live with it.

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
