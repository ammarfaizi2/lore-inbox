Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292976AbSBVUWY>; Fri, 22 Feb 2002 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292985AbSBVUWO>; Fri, 22 Feb 2002 15:22:14 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2564 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292976AbSBVUWG> convert rfc822-to-8bit; Fri, 22 Feb 2002 15:22:06 -0500
Date: Fri, 22 Feb 2002 12:09:47 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Greg KH <greg@kroah.com>
cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020222200750.GE9558@kroah.com>
Message-ID: <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Greg KH wrote:

> On Thu, Feb 21, 2002 at 10:01:14PM +0100, Gérard Roudier wrote:
> > 
> > I have investigated it, but it didn't seem to allow the boot order set by
> > user in sym53c8xx HBA NVRAMs to be applied, breaking as a result all
> > systems depending on it. Since it is transparently handled by the
> > sym53c8xx driver and just behaves _as_ user expects, my guess is that
> > numerous users may just have their system relying on it.
> 
> But as Jeff noted, it is _required_ for PCI hotplug functionality.
> Because allmost all of the SCSI drivers are not using this over 2 year
> old interface, they will not work properly on large machines that now
> support PCI hotplug.  Much to my dismay.
> 
> Init order works off of PCI probing order.  If the network people can
> handle this, the SCSI people can :)

Does INT13/INT19 Bios call mean anything?

Last time I checked, ethernet devices are not invoked here but I could be
wrong given PXE.


> > Propose a kernel API that does not break more features that it adds and I
> > will be glad to use it.
> 
> Huh?  This is not a new API.  What does it break for you?

The problem is how do you deal with multiple HOSTs given there drivers are
not (have not checked lately) capable of discrete HOST addition and
removal.

SCSI/ATA share the same problem IIRC, the host/chipset drivers load all
the device hosts who match that driver code.

What am I missing?

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

