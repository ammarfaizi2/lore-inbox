Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTJ1BjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTJ1BjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:39:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263808AbTJ1BjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:39:05 -0500
Date: Mon, 27 Oct 2003 17:30:13 -0800
From: Greg KH <greg@kroah.com>
To: davidm@hpl.hp.com
Cc: vojtech@suse.cz, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: serious 2.6 bug in USB subsystem?
Message-ID: <20031028013013.GA3991@kroah.com>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 02:35:09PM -0800, David Mosberger wrote:
> One-line summary: plug-in your USB keyboard, see your machine die.

Any chance to know where the machine dies?  Any oops you can help us out
with?

> So, I have this non-name USB keyboard (with built-in 2-port USB hub)
> which reliably crashes 2.6.0-test{8,9} on both x86 and ia64.  In
> retrospect, it's clear to me that the same keyboard also occasionally
> crashes 2.4 kernels, but there the problem appears more seldom.
> Perhaps once in 10 reboots and once the machine is booted and the
> keyboard is running, it keeps on working.  The keyboard in question is
> a BTC 5141H.

If you do not load the HID driver, and disable automatic loading of the
hid driver (echo '/sbin/true' > /proc/sys/kernel/hotplug) and plug in
the device, does it still crash?

If not, can you get us the output of /proc/bus/usb/devices and lsusb
with the device plugged in?

If not, does then loading the hid driver cause the problem?

thanks,

greg k-h
