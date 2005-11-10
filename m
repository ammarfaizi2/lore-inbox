Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVKJGoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVKJGoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 01:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVKJGoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 01:44:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751088AbVKJGn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 01:43:59 -0500
Date: Wed, 9 Nov 2005 22:41:17 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: bunk@stusta.de, stern@rowland.harvard.edu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-usb@one-eyed-alien.net, zaitcev@redhat.com,
       Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
Message-Id: <20051109224117.337690bf.zaitcev@redhat.com>
In-Reply-To: <20051109222808.GG9182@kroah.com>
References: <20051107215226.GA25104@kroah.com>
	<Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org>
	<20051107222840.GB26417@kroah.com>
	<20051108004716.GJ3847@stusta.de>
	<20051109222808.GG9182@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005 14:28:08 -0800, Greg KH <greg@kroah.com> wrote:

> > What about letting the two drivers always use libusual?
> 
> Pete?  What do you think about this patch?

It does nothing to explain how exactly the current configuration managed
not to work, which leaves me unsatisfied. I did test the kernel to build
correctly with libusub on and off. All we have is this:

> It seems that libusual.ko is not being actually built as a module, despite being 
> set to 'm' in .config.

Which is nonsensual, because CONFIG_USB_LIBUSUAL is a boolean.
And reub.net is down, so I cannot fetch the erroneous .config.

I suspect that Reuben did not rerun "make oldconfig" after editing
.config or something of that nature.

What Adrian is proposing may be a good idea or may be not, but it has
nothing to do with the problem.

-- Pete
