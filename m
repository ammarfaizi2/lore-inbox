Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTEOTuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTEOTuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:50:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:41461 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264196AbTEOTt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:49:58 -0400
Date: Thu, 15 May 2003 13:04:46 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB not accepting addresses in bk9
Message-ID: <20030515200446.GA10318@kroah.com>
References: <3EC310C3.9060606@cox.net> <20030515070800.GA6497@kroah.com> <3EC3F02E.1010604@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC3F02E.1010604@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 03:53:18PM -0400, David van Hoose wrote:
> Greg KH wrote:
> >On Thu, May 15, 2003 at 12:00:03AM -0400, David van Hoose wrote:
> >
> >>Sometime between 2.5.69-bk4 and 2.5.69-bk8, something with related to 
> >>the USB was messed up. I get the below lines in my dmesg.
> >>hub 2-0:0: new USB device on port 1, assigned address 2
> >>usb 2-1: USB device not accepting new address=2 (error=-110)
> >>hub 2-0:0: new USB device on port 1, assigned address 3
> >>usb 2-1: USB device not accepting new address=3 (error=-110)
> >>
> >>The first device is my Logitech Cordless Optical Trackball.
> >>The second device is my TI USB Graphlink.
> >>
> >>The Trackball still works. Not sure about the graphlink as I don't have 
> >>the software installed yet. :-/
> >
> >How can the device work if the USB bus rejected it?  Also, does
> >/proc/interrupts increment for the USB controller when you plug a device
> >in?
> 
> No idea. It seems to increment the usb line in /proc/interrupts.
> I've attached a dmesg with verbose debugging.

-ENOATTACHMENT :)

> >>I used the same config for bk4 as I did for bk8. It've attached my 
> >>config for bk9 since it is the same anyway.
> >
> >Care to do a binary search of bk4 to bk8 to try to find the problem?
> >Should only take you 2 reboots at most :)
> 
> What do you want me to do? I don't know if I have the skills yet to code 
> for the kernel, so the least I can do is test it. :-)

Ok, bk4 works for you and bk8 doesn't.  So try the following:
	- test bk6
	- if bk6 fails test bk5
		- if bk5 fails, the problem happened between bk4 and bk5
		- if bk5 works, the problem happened bewtwen bk5 and bk6
	- if bk6 works test bk7
		- if bk7 fails, the problem happened between bk6 and bk7
		- if bk7 works, the problem happened between bk7 and bk8

And let us know what the result is, please.

thanks,

greg k-h
