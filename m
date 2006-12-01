Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031738AbWLATRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031738AbWLATRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031736AbWLATRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:17:48 -0500
Received: from ns1.suse.de ([195.135.220.2]:36541 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031738AbWLATRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:17:47 -0500
Date: Fri, 1 Dec 2006 11:17:30 -0800
From: Greg KH <gregkh@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Message-ID: <20061201191730.GA3539@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA4907273@ssvlexmb2.amd.com> <20061201184123.GA2996@suse.de> <20061201190426.14911.qmail@stuge.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201190426.14911.qmail@stuge.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 08:04:26PM +0100, Peter Stuge wrote:
> On Fri, Dec 01, 2006 at 10:41:23AM -0800, Greg KH wrote:
> > On Fri, Dec 01, 2006 at 10:26:19AM -0800, Lu, Yinghai wrote:
> > > Anyone is working on creating one usb_serial_driver for USB debug
> > > device without using host debug port?
> > 
> > I can do that in about 15 minutes if you give me the device ids for
> > the usb debug device that you wish to have.
> 
> The host (aka remote) end of the NET20DC debug device has vid 0x0525
> and pid 0x127a.

You can use the usb-serial generic driver with those ids (as module
parameters) today, with no kernel changes needed.

> > Or you can also use the generic usb-serial driver today just fine
> > with no modification.  Have you had a problem with using that
> > option?
> 
> Does it check for a debug descriptor and attach to the device if one
> is found? Neat!

No, sorry, you need to use the device ids.

thanks,

greg k-h
