Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317664AbSGPAX1>; Mon, 15 Jul 2002 20:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317715AbSGPAX0>; Mon, 15 Jul 2002 20:23:26 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:20239 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317664AbSGPAX0>;
	Mon, 15 Jul 2002 20:23:26 -0400
Date: Mon, 15 Jul 2002 17:25:30 -0700
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
Message-ID: <20020716002530.GA32431@kroah.com>
References: <20020713003601.GA12118@kroah.com> <m1znwuoyze.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1znwuoyze.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 17 Jun 2002 23:22:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 02:07:01PM -0600, Eric W. Biederman wrote:
> 
> The driver is a mtd map driver.  It knows there is a rom chip behind 
> a pci->isa bridge.  And it needs to find the pci->isa bridge to
> properly set it up to access the rom chip (enable writes and the
> like).  
> 
> It isn't a driver for the pci->isa bridge, (I'm not even certain we
> have a good model for that).  So it does not use pci_register_driver.
> 
> If you can give me a good proposal for how to accomplish that kind of
> functionality I would be happy to use the appropriate
> xxx_register_driver.

I don't think there is a good way for you to convert over to
_register_driver(), that's the main reason I'm keeping the pci_find_*
functions around, they are quite useful for lots of situations.

It doesn't sound like you are worrying about your device working in a
pci hotplug system, and you would probably be willing do any pci device
conversion work to the new driver model yourself, right?  :)

thanks,

greg k-h
