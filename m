Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVBXTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVBXTNz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVBXTNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:13:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:29828 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262452AbVBXTNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:13:53 -0500
Date: Thu, 24 Feb 2005 11:12:43 -0800
From: Greg KH <greg@kroah.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224191243.GD11806@kroah.com>
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com> <20050224182300.GA7778@mail.muni.cz> <20050224184928.GA11490@kroah.com> <20050224190548.GA7978@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224190548.GA7978@mail.muni.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 08:05:48PM +0100, Lukas Hejtmanek wrote:
> On Thu, Feb 24, 2005 at 10:49:28AM -0800, Greg KH wrote:
> > > This is the device:
> > > http://www.msi.com.tw/program/support/download/dld/spt_dld_detail.php?UID=607&kind=6
> > > 
> > > Btw, I thought, that ehci-hcd driver handles both usb 2.0 and 1.1. Does it?
> > 
> > No, it hands off the usb 1.1 devices to the usb 1 core inside it.  This
> > is either uhci or ohci, depending on your controller chip.
> > 
> > Unless you put a USB 2.0 hub in front of a usb 1.1 device, then it gets
> > more complicated, but we'll just ignore that issue for now...
> > 
> > What does /proc/bus/usb/devices show for this device?
> 
> When connected through uhci-hcd:
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0

Your device is only reporting that it can go at 12Mbit (full speed, not
480Mbit, which is high speed.)

So it's working properly, but not labeled clearly on the box.  We've
seen this a lot, you are not alone in your confusion.

I suggest you return it and get a better device.

thanks,

greg k-h
