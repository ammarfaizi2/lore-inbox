Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWFWAOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWFWAOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWFWAOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:14:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751674AbWFWAOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:14:17 -0400
Date: Thu, 22 Jun 2006 17:17:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: gregkh@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-Id: <20060622171732.16fd2cd1.akpm@osdl.org>
In-Reply-To: <449B3047.50704@goop.org>
References: <20060621220656.GA10652@kroah.com>
	<Pine.LNX.4.64.0606221546120.6483@g5.osdl.org>
	<20060622234040.GB30143@suse.de>
	<449B3047.50704@goop.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> Greg KH wrote:
> > I saw this once when debugging the usb code, but could never reproduce
> > it, so I attributed it to an incomplete build at the time, as a reboot
> > fixed it.
> >
> > Is this easy to trigger for you?
> >   
> 
> This is the same oops as I posted yesterday: "2.6.17-mm1: oops in 
> Bluetooth stuff, usbdev_open".  I haven't seen it since...
> 

That's a kernel-wide list of USB devices, isn't it?  Which means that some
driver other than the bluetooth one has got itself freed up while still
being on the list.

If so, it could be any driver at all..
