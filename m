Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292986AbSBVUce>; Fri, 22 Feb 2002 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292989AbSBVUcZ>; Fri, 22 Feb 2002 15:32:25 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:5124 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292986AbSBVUcK>; Fri, 22 Feb 2002 15:32:10 -0500
Date: Fri, 22 Feb 2002 12:19:52 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andre Hedrick <andre@linuxdiskcert.org>,
        =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <3C76A4D8.A7838605@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10202221210430.2519-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Jeff Garzik wrote:

> Andre Hedrick wrote:
> > Also not that ATA/IDE drivers were not using 2.4 PCI API and likewise was
> > stable for a while.
> 
> Stable?  Yes.  But it's not modular nor compatible with current efforts
> like 2.4 cardbus or 2.4 hotplug pci or 2.5 device mode.  If one cannot
> do
> 	modprobe piix4_ide
> and have the right things happen automatically, the system is not
> modular.  If it doesn't use the PCI API, it's implementing CardBus
> support in a non-standard way if at all.

Now what happens if you have more than one HOST of the same kind or the
"SAME HOST" with multiple functions but are really one HOST?

I do not see how this will handle the problem.
But obviously I have been to far down making sure the DATA got to platter
correct and most likely missed a few things. :-/

> > > This is need for transparented support for cardbus and hotplug PCI, not
> > 
> > This is HOST level operation not DEVICE, and you do not see the differenc.
> 
> I do.  I am talking about a HOST api here.

Okay we are getting some place now, cause what I was reading and seeing in
the changes registers a DRIVE to the PCI API and not a HOST.

> 
> > It is a shame that I will now have to start from scratch to create another
> > API for hotplug device for ATA/ATAPI that was migrating into SCSI because
> > of the ide-scsi driver.
> 
> Why not work with Patrick to make sure his device model properly
> supports disks?

I thought there were a few conversations to address this point.
What everyone is maybe missing is PATA (parallel ata) does not permit
"Disconnect/Release".

Maybe I need to sit down w/ Patrick to figure out how to pound the model
into my thick head.

Much of my unwillingness to move rapid is because the past has shown
massive problem, and Linus has never permitted rapid design changes in the
ata/atapi stack.  So much if this is a shock to the system.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

