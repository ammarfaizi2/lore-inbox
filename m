Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290245AbSAOSmr>; Tue, 15 Jan 2002 13:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290238AbSAOSmn>; Tue, 15 Jan 2002 13:42:43 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:16655 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290244AbSAOSll>;
	Tue, 15 Jan 2002 13:41:41 -0500
Date: Tue, 15 Jan 2002 10:38:14 -0800
From: Greg KH <greg@kroah.com>
To: Dmitri Kassatkine <dmitri.kassatkine@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb.c patch -> successfuly read usb descriptors on some USB device
Message-ID: <20020115183814.GD27059@kroah.com>
In-Reply-To: <3C43FD9D.8050706@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C43FD9D.8050706@nokia.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 18 Dec 2001 14:45:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 11:59:57AM +0200, Dmitri Kassatkine wrote:
> Hi,
> 
> Sometimes USB subsystem cannot get USB descriptor.
> 
> Jan 15 10:44:21 selma kernel: hub.c: USB new device connect on bus1/1, assigned device number 25
> Jan 15 10:44:21 selma kernel: usb.c: couldn't get all of config descriptors
> Jan 15 10:44:21 selma kernel: usb.c: unable to get device 25 configuration (error=-110)
> 
> Here is patch how to fix it for 2.4.17. It works for 2.4.16 as well.
> It necassary to read descriptor at once, not first 8 byte first.

Then this device does not match the USB spec.

> It works well now for NSM USB Bluetooth dongle.

Has this device gone through the USB certification process?  There are a
_lot_ of USB bluetooth devices out there that violate the USB spec, and
have not been certified.

thanks,

greg k-h
