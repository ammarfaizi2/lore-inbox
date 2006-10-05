Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWJEVqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWJEVqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWJEVqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:46:00 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55556 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932274AbWJEVpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:45:25 -0400
Date: Thu, 5 Oct 2006 17:45:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610052325.39690.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0610051732190.7346-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Oliver Neukum wrote:

> I have a few observations, but no solution either:
> - if root tells a device to suspend, it shall do so

Probably everyone will agree on that.

> - the issues of manual & automatic suspend and remote wakeup are orthogonal

Except for the fact that remote wakeup kicks in only when a device is 
suspended.

> - there should be a common API for all devices

It would be nice, wouldn't it?  But we _already_ have several vastly
different power-management APIs.  Consider for example DPMI and IDE 
spindown.

> - there's no direct connection between power save and open()

Why shouldn't a device always be put into a power-saving mode whenever it 
isn't open?  Agreed, you might want to reduce its power usage at times 
even when it is open...

> The question when a device is in use is far from trivial.

Yes.  It has to be decided by each individual driver.  For simple 
character-oriented devices, "open" is a good first start.

Alan Stern

