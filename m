Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVA0AQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVA0AQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVA0AQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:16:11 -0500
Received: from ida.rowland.org ([192.131.102.52]:4612 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262476AbVAZWPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:15:11 -0500
Date: Wed, 26 Jan 2005 17:15:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: DervishD <lkml@dervishd.net>
cc: Oliver Neukum <oliver@neukum.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] Re: USB API, ioctl's and libusb
In-Reply-To: <20050126163811.GA259@DervishD>
Message-ID: <Pine.LNX.4.44L0.0501261711150.639-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, DervishD wrote:

>     That's irrelevant, the program I was trying to fix uses libusb.
> My question is about the preferred kernel interface, 'cause I don't
> know if it's the ioctl one or the URB one (well, I'm calling 'URB'
> interface the API that is implemented using URB's inside the kernel).
> 
>     BTW, and judging from the program I've read, there are lots of
> operations that must be done using 'usb_control_msg', and libusb
> implements that function with exactly the same interface as the
> kernel. The only difference is that libusb uses ioctl and the kernel
> implements the function using URB's. IMHO libusb doesn't provide a
> cleaner API, the only advantage of libusb is portability. Anyway,
> I've not used it enough to judge, I'm more concerned about kernel USB
> interface, not libusb one.

You don't seem to understand the difference between a kernel API and a
user API.  Only code that is part of the kernel can use a kernel API, so
only kernel drivers can use the "URB" interface.  By contrast, a user API
can be used by regular programs, not part of the kernel.  libusb provides
a user API.

So there's really no choice.  Unless you're writing a kernel module, your 
program can't use URBs.  You can use libusb, or if you don't care about 
portability you can use ioctl calls directly.  But you can't use URBs.

Alan Stern

