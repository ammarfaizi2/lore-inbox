Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSIZXMH>; Thu, 26 Sep 2002 19:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSIZXMH>; Thu, 26 Sep 2002 19:12:07 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:52911 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261550AbSIZXMG> convert rfc822-to-8bit; Thu, 26 Sep 2002 19:12:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pciand usb
Date: Fri, 27 Sep 2002 01:35:17 +0200
User-Agent: KMail/1.4.1
Cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0209261522340.910-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.33L2.0209261522340.910-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209270135.18010.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This raises a generally interesting question:  When should a driver
> module be loaded?

It is an interesting question, but it is not a kernel problem :-)

[..]
> I think it's clear that the answer must depend on the particular driver,
> and that no single scheme involving usage counts (or the equivalent) can
> suffice for every situation.
>
> Is there a way to let the kernel provide a variety of mechanisms and let
> the device driver (or even the user) select which one gets used?

That is more or less what is in place. There's a kernel aspect to the problem,
because the kernel needs to implement an unload if nothing is bound to method,
as user space cannot do that without a race.

	Regards
		Oliver

