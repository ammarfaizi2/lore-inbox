Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTEEWyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTEEWyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:54:20 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:6016 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261858AbTEEWyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:54:19 -0400
Subject: Re: USB not working with 2.5.69, worked with .68
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030505215141.GB3111@kroah.com>
References: <1052168060.826.8.camel@chevrolet.hybel>
	 <20030505215141.GB3111@kroah.com>
Content-Type: text/plain
Message-Id: <1052176021.1092.7.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (Preview Release)
Date: 06 May 2003 01:07:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 05.05.2003 kl. 23.51 skrev Greg KH:
> On Mon, May 05, 2003 at 10:54:20PM +0200, Stian Jordet wrote:
> > 
> > I have read somewhere that the USB device not accepting new address
> > means that the host-controller doesn't get an interrupt, and that this
> > often is because of ACPI. It's just the same with acpi disabled (and in
> > 2.5.68 it did work with and without acpi).
> 
> Hm, can you look at /proc/interrups and verify that the usb controller's
> interrupt count is going up?  It really sounds like the interrupt isn't
> getting through to the usb controller driver.

*argh* I hate this. Earlier I only tried to disable acpi, I had to
disable MPS1.4 in the BIOS as well. Now it works. But, I can't turn my
computer off without acpi. This worked with 2.5.68, so something has
changed, but I guess you aren't the one to blame, then. 

Thanks for answering, and sorry I didn't find this out earlier. But it
works with acpi in 2.5.68, that's what's bugging me :)

Best regards,
Stian


A little off-topic rant about my motherboard:

I have a ASUS CUV266-DLS motherboard. Dual P3, integrated SCSI and
ethernet. Since it is smp, I have to use ACPI to power it off.

* With kernel 2.5.69, and ACPI enabled, usb doesn't work. 

* With earlier ACPI enabled kernels, and secondary ide disabled in bios,
usb doesn't work.

* Without ACPI, no kernel will boot with secondary ide enabled.

It's not easy..

