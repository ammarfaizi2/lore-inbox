Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSHJLAw>; Sat, 10 Aug 2002 07:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSHJLAw>; Sat, 10 Aug 2002 07:00:52 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:4247 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316838AbSHJLAv> convert rfc822-to-8bit; Sat, 10 Aug 2002 07:00:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [RFC] USB driver conversion to use "struct device_driver"
Date: Sat, 10 Aug 2002 11:57:28 +0200
User-Agent: KMail/1.4.1
Cc: Patrick Mochel <mochel@osdl.org>
References: <20020810001005.GA29490@kroah.com>
In-Reply-To: <20020810001005.GA29490@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208101157.28759.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 10. August 2002 02:10 schrieb Greg KH:
> Hi all,

> The USB subsystem only binds drivers to USB "interfaces".  A USB device
> may have many "interfaces", so a single device may have many drivers
> attached to it, handling different portions of it (think of a USB
> speaker, which has a audio driver for the audio stream, and a HID driver
> for the speaker buttons.)  Because of this I had to create a "empty"
> device driver that I attach to the USB device structure.  This ensures
> it shows up properly in the driverfs tree, and that no USB drivers try
> to bind to it.

Hi,

the probe/disconnect changes are an improvement.
But what do we call a device? IMHO the device in
terms of driverfs is the interface, thus the usb_device
should be seen as a bus, which interfaces are attached to.

	Regards
		Oliver

