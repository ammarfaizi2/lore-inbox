Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292993AbSBVUqz>; Fri, 22 Feb 2002 15:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSBVUqe>; Fri, 22 Feb 2002 15:46:34 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8452 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292990AbSBVUq1>; Fri, 22 Feb 2002 15:46:27 -0500
Date: Fri, 22 Feb 2002 12:34:12 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Greg KH <greg@kroah.com>
cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020222202917.GF9558@kroah.com>
Message-ID: <Pine.LNX.4.10.10202221227260.2519-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Greg KH wrote:

> On Fri, Feb 22, 2002 at 12:09:47PM -0800, Andre Hedrick wrote:
> > 
> > Does INT13/INT19 Bios call mean anything?
> 
> To me, no.  I do not know anything about IDE.  :)
> 
> I thought we were talking about SCSI PCI drivers here.

Under x86 SCSI is hooked w/ INT13/INT19 calls, that is how you can boot a
SCSI "Direct-Access", that is why I moved away from ATA and was hoping it
would be "generic storage"

> > The problem is how do you deal with multiple HOSTs given there drivers are
> > not (have not checked lately) capable of discrete HOST addition and
> > removal.
> > 
> > SCSI/ATA share the same problem IIRC, the host/chipset drivers load all
> > the device hosts who match that driver code.
> > 
> > What am I missing?
> 
> Nothing.  It is the same problem for IDE PCI drivers.  In order for PCI
> Hotplug to work on these devices, they have to implement the 2.4 pci
> interface.  If they do that, they work with PCI hotplug systems.  If
> they do not, they don't.

Okay, but where is a card that is capable, and cardbus is not the same
issue.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

