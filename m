Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbTCOVrD>; Sat, 15 Mar 2003 16:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbTCOVrD>; Sat, 15 Mar 2003 16:47:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:28176 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261597AbTCOVrC>;
	Sat, 15 Mar 2003 16:47:02 -0500
Date: Sat, 15 Mar 2003 13:46:23 -0800
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.64
Message-ID: <20030315214623.GB13446@kroah.com>
References: <10476033263399@kroah.com> <10476033262095@kroah.com> <20030315104901.A3923@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315104901.A3923@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 10:49:01AM +0100, Vojtech Pavlik wrote:
> On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> >  static struct pci_driver amd8111_driver = {
> > -	.name		= "amd8111 smbus 2.0",
> > +	.name		= "amd8111 smbus",
> 
> The 2.0 was quite intentional in the .name, because the 8111 has *two*
> SMBus busses, one SMBus 1.1 and one SMBus 2.0. This driver is only for
> the 2.0 SMBus controller.

Ah, I removed the "2.0" portion because it was larger than the 16
character limit for pci driver names (it shows up in sysfs garbled if
it's bigger).

Would "amd8111 smbus 2" be an ok name?

thanks,

greg k-h
