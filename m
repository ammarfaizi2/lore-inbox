Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWJEVZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWJEVZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWJEVZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:25:05 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:37080 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S932222AbWJEVZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:25:01 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Thu, 5 Oct 2006 23:25:39 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052325.39690.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2006 22:48 schrieb Alan Stern:
> On Thu, 5 Oct 2006, Oliver Neukum wrote:
[..] 
> > If you freeze my batch jobs or make unavailable the servers
> > running on my laptop I'd be very unhappy.
> > But I want to make jostling a mouse or other input device safe. Thus
> > I want them to be suspended without autoresume. We need flexibility.
> 
> So you want a mode in which the input devices are suspended without remote 
> wakeup.  Remote wakeup settings are configurable via 
> /sys/devices/.../power/wakeup.  At this point nobody has settled on a
> new API for suspending the devices.  It's quite possible that different 
> drivers or different buses will use their own individual APIs.

I have a few observations, but no solution either:
- if root tells a device to suspend, it shall do so
- the issues of manual & automatic suspend and remote wakeup are orthogonal
- there should be a common API for all devices
- there's no direct connection between power save and open()

The question when a device is in use is far from trivial.

	Regards
		Oliver
