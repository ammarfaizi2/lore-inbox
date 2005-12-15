Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVLOSD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVLOSD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVLOSD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:03:26 -0500
Received: from mail1.kontent.de ([81.88.34.36]:665 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750844AbVLOSD0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:03:26 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: Repeated USB disconnect and reconnect with Wacom Intuos3 6x11 tablet
Date: Thu, 15 Dec 2005 19:03:54 +0100
User-Agent: KMail/1.8
Cc: Denny Priebe <spamtrap@siglost.org>, linux-kernel@vger.kernel.org
References: <20051213184600.GA4283@nostromo.dyndns.info> <20051215144254.GA19794@nostromo.dyndns.info> <20051215163122.GC14512@kroah.com>
In-Reply-To: <20051215163122.GC14512@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512151903.54690.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. Dezember 2005 17:31 schrieb Greg KH:
> > Could it be that the usb driver doesn't check for a connect status change
> > while there's a process reading /dev/input/{mouse,event}? so that I do not
> > see these disconnects while reading the tablet data? 
> 
> No, it's an electronic signal happening on the USB hub, the hub notifies
> the kernel when a disconnect happens, it has nothing to do with the
> driver connected to the actual device.
> 
> So I really think that this is an electronic issue, sorry.  Can you
> return this device and get a replacement one?

We start the URB on open and stop it on close. Is it possible that
Windows keeps it on all the time and we have a device that is so
broken it cannot cope with anything else?

	Regards
		Oliver
