Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUCCD1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUCCD1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:27:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:15323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262341AbUCCD1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:27:37 -0500
Date: Tue, 2 Mar 2004 19:27:37 -0800
From: Greg KH <greg@kroah.com>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB driver troubles: OHCI vs. UHCI
Message-ID: <20040303032737.GA16680@kroah.com>
References: <E1AyM9d-00022O-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AyM9d-00022O-00@penngrove.fdns.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 06:30:37PM -0800, John Mock wrote:
> I've been using a homebrew USB driver for a PIC microprocessor development
> board (Microchip PICkit, which uses the HID 'knothole'), based the 2.4.21
> USB skeleton driver (with a few minor changes) for many months now on a 
> PowerMac 8500 with an add-on OHCI board.  I tried compiling for a Sony 
> VAIO R505EL, which uses the UHCI driver, with poor results.  
> 
> Under 2.4.22, it works the first time the device is opened, but hangs on
> subsequent operations until the device is power cycled or the UHCI driver
> is module is removed/re-installed again.

Sounds like a problem with your driver.

> I tried updating it to 2.6.1-rc2 and it quickly gets an error, saying 
> 
>     [skel]_write - failed submitting write urb, error -22.
> 
> Thinking i had messed up the driver, i generated a current kernel (2.6.3)
> on the PowerMac, and the updated driver worked the first time with the
> OHCI board.
> 
> Is this a known problem with 2.6.xx, and if so, what does it mean??

No it isn't.

> Any idea what the skeleton driver isn't doing under 2.4.2x which causes
> a device to enter a hung state on subsequent opens on UCHI (but not OHCI)?
> 
> As of a few minutes ago, i have a workaround.  But i'm still quite puzzled
> and hope someone else has been here before.

Care to post the driver?

thanks,

greg k-h
