Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTEOHAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTEOHAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:00:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:43209 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262016AbTEOHAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:00:11 -0400
Date: Thu, 15 May 2003 00:08:00 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB not accepting addresses in bk9
Message-ID: <20030515070800.GA6497@kroah.com>
References: <3EC310C3.9060606@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC310C3.9060606@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 12:00:03AM -0400, David van Hoose wrote:
> Sometime between 2.5.69-bk4 and 2.5.69-bk8, something with related to 
> the USB was messed up. I get the below lines in my dmesg.
> hub 2-0:0: new USB device on port 1, assigned address 2
> usb 2-1: USB device not accepting new address=2 (error=-110)
> hub 2-0:0: new USB device on port 1, assigned address 3
> usb 2-1: USB device not accepting new address=3 (error=-110)
> 
> The first device is my Logitech Cordless Optical Trackball.
> The second device is my TI USB Graphlink.
> 
> The Trackball still works. Not sure about the graphlink as I don't have 
> the software installed yet. :-/

How can the device work if the USB bus rejected it?  Also, does
/proc/interrupts increment for the USB controller when you plug a device
in?

> I used the same config for bk4 as I did for bk8. It've attached my 
> config for bk9 since it is the same anyway.

Care to do a binary search of bk4 to bk8 to try to find the problem?
Should only take you 2 reboots at most :)

thanks,

greg k-h
