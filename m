Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTHSXub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTHSXua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:50:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:23233 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261533AbTHSXuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:50:23 -0400
Date: Tue, 19 Aug 2003 16:50:12 -0700
From: Greg KH <greg@kroah.com>
To: ckbb ckbb <ckbroadbus@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB device not accepting new address=2 (error=-19)
Message-ID: <20030819235012.GA7843@kroah.com>
References: <BAY1-F29tnhvCRohyMM0002e7a1@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-F29tnhvCRohyMM0002e7a1@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 07:33:32PM -0400, ckbb ckbb wrote:
> I am stuck with the following error. I really appreciate any help for this 
> problem. May be it is known bug in the usb stack.
> 
> I am using linux2.4.21, powerpc processor, phillips 1161a host controller
> 
> I am getting interrupts & hardware seems to be OK. I have configured EHCI & 
> OHCI, scsi, usb mass storage in the kernel configuration.
> 
> 
> usb.c: new USB bus registered, assigned bus number 1
> Product: USB OHCI Root Hub
> SerialNumber: c7911000
> hub.c: USB hub found
> hub.c: 1 port detected
> hcd_1161.c : usb devices found..
> usbutil: USB int. status bits cleared 0x00060000
> usbutil: USB interrupt.1 Enabled ox00020000
> ISP116x_HCD Initialization Successful
> 
> usb.c: USB device not accepting new address=2 (error=-19)
> 
> usb.c: USB device not accepting new address=3 (error=-19)

Looks like a pci interrupt routing issue.  Is the usb host controller
actually getting interrupts?

Is this a custom motherboard, or is it a Apple machine?

Odds are it's a bug in the hcd_1161 driver as almost no one uses that
driver and I doubt it is up to date.

thanks,

greg k-h
