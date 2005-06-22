Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVFVIcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVFVIcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVFVI1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:27:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:8940 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262894AbVFVIXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:23:40 -0400
Date: Wed, 22 Jun 2005 01:23:26 -0700
From: Greg KH <greg@kroah.com>
To: Userstack <userstack@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.12 USB Flash Drive Mount / Firmware Corruption
Message-ID: <20050622082326.GA31103@kroah.com>
References: <42B8926E.1040804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B8926E.1040804@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 10:19:26PM +0000, Userstack wrote:
> Hello,
> 
> I am running gentoo64 with the following kernel
> . . .
> $uname -a
> Linux amd64 2.6.12 #1 Fri Jun 17 22:16:51 UTC 2005 x86_64 AMD Athlon(tm)
> 64 Processor 3000+ AuthenticAMD GNU/Linux
> . . .
> 
> I have plugged three USB flash drives into this machine all with the
> same result. Which is shown here in dmesg
> 
> . . .
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usb 3-1: new full speed USB device using ohci_hcd and address 12
> usb 3-1: device descriptor read/64, error -110
> usb 3-1: device descriptor read/64, error -110
> usb 3-1: new full speed USB device using ohci_hcd and address 13
> usb 3-1: device descriptor read/64, error -110
> usb 3-1: device descriptor read/64, error -110
> usb 3-1: new full speed USB device using ohci_hcd and address 14
> usb 3-1: device not accepting address 14, error -110
> usb 3-1: new full speed USB device using ohci_hcd and address 15
> usb 3-1: device not accepting address 15, error -110
> . . .
> 
> All three drives are now useless and are not recognized under any
> operating system/version. However when the drive is plugged back into
> the machine that supposedly corrupted them I see the error stated above
> again in dmesg, but not on other machines.

This is not an indication of "corruption", just that the device doesn't
want to initialize properly for some reason.

Do any other USB devices work in these slots?

You should take this to the linux-usb-devel mailing list for more help
(added to the CC:)

thanks,

greg k-h
