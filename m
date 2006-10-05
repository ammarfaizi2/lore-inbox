Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWJEUsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWJEUsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWJEUsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:48:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56848 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932175AbWJEUsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:48:51 -0400
Date: Thu, 5 Oct 2006 16:48:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610052044.00324.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Oliver Neukum wrote:

> [..]
> > > In the general case the idea seems insufficient. If I close my laptop's lid
> > > I want all input devices suspended, whether the corresponding files are
> > > opened or not. In fact, if I have port level power control I might even
> > > want to cut power to them.
> > 
> > That's a separate issue.  You were talking about runtime suspend, but 
> > closing the laptop's lid is a system suspend.
> 
> Why?

Normally people expect that shutting the lid on a laptop will cause it to 
go to sleep.  If you want different behavior, that's okay too...

> If you freeze my batch jobs or make unavailable the servers
> running on my laptop I'd be very unhappy.
> But I want to make jostling a mouse or other input device safe. Thus
> I want them to be suspended without autoresume. We need flexibility.

So you want a mode in which the input devices are suspended without remote 
wakeup.  Remote wakeup settings are configurable via 
/sys/devices/.../power/wakeup.  At this point nobody has settled on a
new API for suspending the devices.  It's quite possible that different 
drivers or different buses will use their own individual APIs.

Alan Stern

