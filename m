Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVFKOk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVFKOk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVFKOk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:40:27 -0400
Received: from mail1.kontent.de ([81.88.34.36]:47299 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261717AbVFKOjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:39:25 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: kaweth fails to work on 2.6.12-rc[56]
Date: Sat, 11 Jun 2005 16:39:17 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <200506111313.14756.oliver@neukum.org> <20050611125239.GA6252@animx.eu.org>
In-Reply-To: <20050611125239.GA6252@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506111639.18034.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 11. Juni 2005 14:52 schrieb Wakko Warner:
> Oliver Neukum wrote:
> > Am Samstag, 11. Juni 2005 06:11 schrieb Wakko Warner:
> > > Oliver Neukum wrote:
> > > > Sorry, I should be more specific. It will print out the error codes
> > > > internal to the USB layer which are meaningful even if interrupts are shared.
> > > > Also, are you seeing tx errors in the error count?
> > > 
> > > Unless I did something wrong, it's apparently not in the USB subsystem.
> > > 
> > > I have 2.6.12-rc3 and rc4 compiled.  Same config file on a test system.
> > > again, rc3 works, rc4 does not.  I booted rc3 and force loaded the usb
> > > modules from rc4 into rc3.  It tainted the kernel, but it worked.
> > > 
> > > I booted into rc4.  I do have ACPI compiled so I added acpi=off.  This did
> > > not work, same problem as before.  I left a ping running, the usb controller
> > > was on IRQ 9.  The test system is an old NEC notebook with an Intel chipset
> > > (thus uhci-hcd usb1.1).  I plugged in a Belkin USB2.0 cardbus card (USB1.1
> > > is serviced by ohci-hcd) and plugged the ethernet adapter into that.  Same
> > > problem.
> > 
> > Do you see tx errors?
> 
> No.  Oh oops I forgot to say the ping caused the interrupts to increase.
> ifconfig showed 1 packet sent but never went up.

This might very well indicate that the queue is not reenabled.
The interrupt handler should do that. If you enable debug in kaweth.c,
you'll learn more. If it doesn't help, I'll send you a patch which produces
more output.

	Regards
		Oliver
