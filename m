Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752219AbWAEVnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbWAEVnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbWAEVnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:43:39 -0500
Received: from digitalimplant.org ([64.62.235.95]:6621 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1752219AbWAEVni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:43:38 -0500
Date: Thu, 5 Jan 2006 13:43:33 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <Pine.LNX.4.44L0.0601041703350.26871-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.50.0601051342470.17046-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0601041703350.26871-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jan 2006, Alan Stern wrote:

> On Wed, 4 Jan 2006, Pavel Machek wrote:
>
> > > As I mentioned in the thread (currently happening, BTW) on the linux-pm
> > > list, what you want to do is accept a string that reflects an actual state
> > > that the device supports. For PCI devices that support low-power states,
> > > this would be "D1", "D2", "D3", etc. For USB devices, which only support
> > > an "on" and "suspended" state, the values that this patch parses would
> > > actually work.
> >
> > We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> > "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> > and I'm not sure about those "D1" and "D2" parts. Userspace should not
> > have to know about details, it will mostly use "on"/"suspend" anyway.
>
> It would be good to make the details available so that they are there when
> needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
> "suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
> for "D3".

Do it in userspace; the kernel doesn't need to know about "on" or
"suspend". It should just validate and forward requests to enter specific
states.

Thanks,


	Patrick

