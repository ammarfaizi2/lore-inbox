Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWFAQ5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWFAQ5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWFAQ5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:57:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:3090 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030243AbWFAQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:57:41 -0400
Date: Thu, 1 Jun 2006 12:57:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Andrew Morton <akpm@osdl.org>, David Liontooth <liontooth@cogweb.net>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
In-Reply-To: <Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L0.0606011252350.5730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006, linux-os (Dick Johnson) wrote:

> >> Yes, it sounds like we're being non-real-worldly here.  This change
> >> apparently broke things.  Did it actually fix anything as well?
> >
> > Yes.  At least, I think so.  The change directly addresses a complaint
> > filed here:
> >
> > http://marc.theaimsgroup.com/?l=linux-usb-users&m=112438431718562&w=2

> Many, most, perhaps all such devices don't take more power when they
> are "enabled". Everything is already running and sucking up maximum
> current when you plug it in! If the motherboard didn't smoke when
> the device was plugged in, you might just as well let the user use
> it! Perhaps a ** WARNING ** message somewhere, but by golly, they
> got it running or else you wouldn't be able to read its parameters.

Looks like you didn't bother to read that complaint and the follow-up
messages.  Robert Marquardt's device has two configurations, one using 100
mA and the other using 500 mA.  Before my patch, Linux would always
install the high-power config -- even if the device was behind a
bus-powered hub.  According to Robert:

	This can trigger the overcurrent protection of a bus powered 
	hub which usually then switches off completely dragging down
	three other innocent devices.

	Please tell me that Linux kernel programmers are not that idiotic.

I'll avoid speculations about which kernel programmers are or are not 
idiotic...

Alan Stern

