Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVA0BOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVA0BOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVA0AFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:05:54 -0500
Received: from farley.sventech.com ([69.36.241.87]:10734 "EHLO
	farley.sventech.com") by vger.kernel.org with ESMTP id S262156AbVAZVYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:24:12 -0500
Date: Wed, 26 Jan 2005 13:24:11 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Oliver Neukum <oliver@neukum.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: USB API, ioctl's and libusb
Message-ID: <20050126212411.GB21204@sventech.com>
References: <20050126122014.GF58@DervishD> <200501261440.38766.oliver@neukum.org> <20050126163811.GA259@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126163811.GA259@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005, DervishD <lkml@dervishd.net> wrote:
>  * Oliver Neukum <oliver@neukum.org> dixit:
> > Am Mittwoch, 26. Januar 2005 13:20 schrieb DervishD:
> > > ? ? My question is: which interface should be used by user space
> > > applications, <linux/usb.h> or ioctl's? Is the ioctl interface
> > > deprecated in any way? In the "Programming guide for Linux USB Device
> > > Drivers", located in http://usb.in.tum.de/usbdoc/, I can't find ioctl
> > > interface references :?
> > You are supposed to use libusb.
> 
>     That's irrelevant, the program I was trying to fix uses libusb.
> My question is about the preferred kernel interface, 'cause I don't
> know if it's the ioctl one or the URB one (well, I'm calling 'URB'
> interface the API that is implemented using URB's inside the kernel).

ioctl() calls are for userspace only.

It just so happens there is an ioctl() call that provides an URB like
interface and an ioctl() call that provides a synchronous call to do
a control message.

>     BTW, and judging from the program I've read, there are lots of
> operations that must be done using 'usb_control_msg', and libusb
> implements that function with exactly the same interface as the
> kernel. The only difference is that libusb uses ioctl and the kernel
> implements the function using URB's. IMHO libusb doesn't provide a
> cleaner API, the only advantage of libusb is portability. Anyway,
> I've not used it enough to judge, I'm more concerned about kernel USB
> interface, not libusb one.

I think you're looking at this incorrectly. You use the kernel API for
kernel modules. You can use either the ioctl() API or libusb for
userspace applications.

JE

