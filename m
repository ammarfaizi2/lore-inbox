Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUECSM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUECSM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUECSMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:12:31 -0400
Received: from farley.sventech.com ([69.36.241.87]:59308 "EHLO
	farley.sventech.com") by vger.kernel.org with ESMTP id S263826AbUECSKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:10:34 -0400
Date: Mon, 3 May 2004 11:10:33 -0700
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: Joerg Pommnitz <pommnitz@yahoo.com>, linux-usb-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Software based unplug of USB device?
Message-ID: <20040503181033.GS1542@sventech.com>
References: <20040503102120.23966.qmail@web41314.mail.yahoo.com> <20040503145413.GA31691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503145413.GA31691@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004, Greg KH <greg@kroah.com> wrote:
> On Mon, May 03, 2004 at 12:21:20PM +0200, Joerg Pommnitz wrote:
> > Hello listees,
> > we are struggling with a 3rd party USB device. It comes with its own
> > firmware and its own Linux USB serial drivers.
> 
> Which device and driver is this?  Do you have a pointer to the driver?
> 
> > Unfortunately the
> > communication between the device and the user application seems to break
> > down from time to time. This situation can easily be resolved by
> > unplugging and then re-plugging the device. Unfortunately this requires
> > manual intervention.
> > While resolving the real issue would be the preferred way to deal with
> > this problem, we would settle for a way to do a software unplug/re-plug.
> 
> Do you want to do this from within the kernel, or from userspace?  If
> from within the kernel, you should be able to drop the power to a hub
> port and reenable it, but I haven't checked to see if that works in a
> long time.

Wouldn't usb_reset_device() work? That's assuming the device isn't
totally and completely hosed.

It can be done via usbfs as well.

JE

