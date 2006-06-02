Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWFBHMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWFBHMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWFBHMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:12:25 -0400
Received: from mail1.kontent.de ([81.88.34.36]:3780 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751244AbWFBHMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:12:25 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB devices fail unnecessarily on unpowered hubs
Date: Fri, 2 Jun 2006 09:12:37 +0200
User-Agent: KMail/1.8
Cc: David Liontooth <liontooth@cogweb.net>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org
References: <20060601030140.172239b0.akpm@osdl.org> <20060601164327.GB29176@kroah.com> <447F8057.4000109@cogweb.net>
In-Reply-To: <447F8057.4000109@cogweb.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606020912.37832.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. Juni 2006 02:03 schrieb David Liontooth:

> The MaxPower value does not appear to be a reliable index of this. My
> USB stick has a MaxPower value of 178mA and works flawlessly off an
> unpowered hub. Unfortunately devices don't seem to tell us what their

It works flawlessly on all hubs you tested, iff other ports are unused.
Unfortunately it needs to work on all hubs, even if all ports are used.

> udev could surely pick up on the MaxPower value and tolerate up to a
> 100% underrun on USB flash drives. That would likely still 90% of the
> pain right there, maybe all of it.

udev can do all it wants if it is running with sufficient priviledge level.
That doesn't change the need for a safe default. The system must run
safely even if udev has gone south or is not installed.
 
> What are the reasons not to do this? What happens if a USB stick is
> underpowered to one unit? Nothing? Slower transmission? Data loss? Flash
> memory destruction? If it's just speed, it's a price well worth paying.

Data loss. Possibly even on other devices and not reproducible.
 
> This is a great opportunity for a small exercise in empathy, utilizing
> that little long-neglected mirror neuron. Thousands of USB sticks
> inexplicably go dead in people's familiar hubs on keyboards and desks;
> Linux kernel coders dream sweet dreams of not violating USB power rules.
> I appreciate Andrew's support for a real-worldly solution.

Maybe we should generate a specific "over power budget" event.

Sympathy is well and good, but partial here. Any option will screw one
group. In this case we go with the standard.

	Regards
		Oliver
