Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031740AbWLATT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031740AbWLATT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031739AbWLATT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:19:27 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37307 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1031736AbWLATT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:19:26 -0500
Date: Fri, 1 Dec 2006 11:19:16 -0800
From: Greg KH <gregkh@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Message-ID: <20061201191916.GB3539@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 10:55:48AM -0800, Lu, Yinghai wrote:
> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de] 
> 
> >I can do that in about 15 minutes if you give me the device ids for the
> >usb debug device that you wish to have.
> 
> >Or you can also use the generic usb-serial driver today just fine with
> >no modification.  Have you had a problem with using that option?
> 
> We are talking about using USB debug device/EHCI debug port in LinuxBIOS
> in legacy free PC.
> Because one AM2+MCP55 MB doesn't have serial port.
> 
> I guess Eric is working on USB debug device/EHCI debug port for
> earlyprintk or printk.

Well, earlyprintk will not work, as you need PCI up and running.

And I have some code that barely works for this already, perhaps Eric
and I should work together on this :)

> So we need one client program on host side. So it would great if we
> could use current USB stack for 
> the clients on system even without debug port.

Yes, that will work just fine today using the usb-serial generic driver.
I'll knock up a "real" driver for the device later today and send it to
Linus, as it's trivial to do so, and will make it simpler than using the
module parameters.

thanks,

greg k-h
