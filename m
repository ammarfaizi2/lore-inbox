Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318093AbSGMFHY>; Sat, 13 Jul 2002 01:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318094AbSGMFHX>; Sat, 13 Jul 2002 01:07:23 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:13065 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318093AbSGMFHW>;
	Sat, 13 Jul 2002 01:07:22 -0400
Date: Fri, 12 Jul 2002 22:09:52 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Removal of pci_find_* in 2.5
Message-ID: <20020713050952.GA13030@kroah.com>
References: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com> <3D2FAF94.7070100@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2FAF94.7070100@mandrakesoft.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 15 Jun 2002 04:05:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 12:41:56AM -0400, Jeff Garzik wrote:
> Matt_Domsch@Dell.com wrote:
> >In both these cases, the pci_find_device() functions use an explict 
> >ordering
> >to make it far more likely we can still boot the system after adding new
> >hardware.  Unless/until there's a method for telling the kernel/modules 
> >that
> >a particular device is the boot device (ala BIOS EDD 3.0 if vendors were to
> >get around to implementing such) explict ordering in the drivers is the 
> >only
> >way we can build complex storage solutions and boot reliably.
> 
> 
> IMO what devices are boot devices is a policy decision.  Depending on 
> pci_find_device() use in a driver's kernel code, or kernel link 
> ordering, is simply hard-coding something that should really be in 
> userspace.  Depending on pci_find_device logic / link order to 
> still-boot-the-system after adding new hardware sounds like an 
> incredibly fragile hope, not a reliable system users can trust.

Exactly.

In the way we are moving naming policy out to userspace, you will be
able to specify exactly which disk, on which pci bus that you want to
boot from (remember initramfs will let us run userspace programs before
the boot disk is touched by the kernel.)

Yes, it still involves some handwaving at this moment in time, but it
will happen, and I do know about this requirement :)

thanks,

greg k-h
