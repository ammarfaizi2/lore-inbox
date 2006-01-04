Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWADWGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWADWGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWADWGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:06:14 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:61856 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932144AbWADWGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:06:11 -0500
Date: Wed, 4 Jan 2006 17:06:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060104213405.GC1761@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0601041703350.26871-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Pavel Machek wrote:

> > As I mentioned in the thread (currently happening, BTW) on the linux-pm
> > list, what you want to do is accept a string that reflects an actual state
> > that the device supports. For PCI devices that support low-power states,
> > this would be "D1", "D2", "D3", etc. For USB devices, which only support
> > an "on" and "suspended" state, the values that this patch parses would
> > actually work.
> 
> We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> and I'm not sure about those "D1" and "D2" parts. Userspace should not
> have to know about details, it will mostly use "on"/"suspend" anyway.

It would be good to make the details available so that they are there when
needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
"suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
for "D3".

Alan Stern

