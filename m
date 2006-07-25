Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWGYTCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWGYTCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWGYTCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:02:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:21152 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932487AbWGYTCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:02:10 -0400
Date: Tue, 25 Jul 2006 11:57:55 -0700
From: Greg KH <greg@kroah.com>
To: Peter Koellner <peter@asgalon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: usb storage device not working anymore in 2.6.17.5 and 2.6.17.6
Message-ID: <20060725185755.GA9727@kroah.com>
References: <Pine.LNX.4.62.0607221735210.6065@noisydwarf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0607221735210.6065@noisydwarf>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2006 at 05:59:40PM +0200, Peter Koellner wrote:
> Hi! I noticed a problem with my usb storage device after upgrading
> from 2.6.17.4:
> 
> 
> problem: After updating the kernel from 2.6.17.4 to .5 and then .6 my 
> usb HDD drive does not work anymore. Any ideas?
> 
> symptoms: on plugging in the HDD, I get the following outpit in dmesg
> with kernel 2.6.17.6:
> 
> usb 4-1.4.1: new full speed USB device using ehci_hcd and address 11
> usb 4-1.4.1: device descriptor read/64, error -32
> usb 4-1.4.1: device descriptor read/64, error -32
> usb 4-1.4.1: new full speed USB device using ehci_hcd and address 12
> usb 4-1.4.1: device descriptor read/64, error -32
> usb 4-1.4.1: device descriptor read/64, error -32
> usb 4-1.4.1: new full speed USB device using ehci_hcd and address 13
> usb 4-1.4.1: device not accepting address 13, error -32
> usb 4-1.4.1: new full speed USB device using ehci_hcd and address 14
> usb 4-1.4.1: device not accepting address 14, error -32

That's really odd.  Can you do a 'git bisect' on the -stable kernel tree
to try to find out the problem that caused this?

Hm, I have a uhci patch around here that might help out, can you test it
out if I send it to you?

thanks,

greg k-h
