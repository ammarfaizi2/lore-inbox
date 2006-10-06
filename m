Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWJFOJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWJFOJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJFOJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:09:08 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:45264 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S932349AbWJFOJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:09:06 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>, linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Fri, 6 Oct 2006 16:09:45 +0200
User-Agent: KMail/1.8
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610060904.51936.oliver@neukum.org> <20061006112742.GL29353@elf.ucw.cz>
In-Reply-To: <20061006112742.GL29353@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061609.45796.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Oktober 2006 13:27 schrieben Sie:
> > with being required to down the interfaces to do so. Suspension should
> > be as transparent as possible.
> 
> What you want is fairly hard to implement in kernel, and it is not
> clear if it is kernel job after all. "Transparent" is nice, but
> "simple kernel code" is nice, too.
> 
> If you have very simple&easy&nice&transparent kernel code that can do
> what you want, fine; but maybe we want to trade "transparent" for
> "KISS".

It seems to me that a network driver needs to have the ability to drop
packets onto the floor while disconnect() is running. In the case of
a disconnection triggered by usbfs a lack of this ability is a race condition.
I've done an implementation of kaweth which allows suspending the interface
while it is alive.

	Regards
		Oliver

