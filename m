Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292979AbSBVT7n>; Fri, 22 Feb 2002 14:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292980AbSBVT7d>; Fri, 22 Feb 2002 14:59:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34067
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292979AbSBVT7Y> convert rfc822-to-8bit; Fri, 22 Feb 2002 14:59:24 -0500
Date: Fri, 22 Feb 2002 11:46:46 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <3C76A053.55A32E77@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10202221143290.2519-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Jeff Garzik wrote:

> Gérard Roudier wrote:
> > On Fri, 22 Feb 2002, Jeff Garzik wrote:
> > > Only 1-2 SCSI drivers do PCI probing "the right way"...  IIRC aic7xxx is
> > > one of them.
> > 
> > Could you, please, not mix PCI probing and SCSI probing.
> > 
> > Average user does not care about PCI probing. But it does care on booting
> > the expected kernel image and mounting the expected partitions.
> > It also doesn't care of code aesthetical issue even with free software
> > since average user is not a kernel hacker.
> 
> Most SCSI drivers are not using the 2.4 PCI API, which has been
> documented and stable for a while now.

Also not that ATA/IDE drivers were not using 2.4 PCI API and likewise was
stable for a while.

> This is need for transparented support for cardbus and hotplug PCI, not

This is HOST level operation not DEVICE, and you do not see the differenc.

> some pie-in-the-sky code asthetic.  This will become further important
> as 2.5.x transitions more and more to Mochel's driver model work, which
> will among other things provide a sane power management model.
> 
> To tangent, IDE and SCSI hotplug issues are interesting, because a lot
> of people forget or mix up the two types of hotplug, board (host)
> hotplug and drive hotplug.

It is a shame that I will now have to start from scratch to create another
API for hotplug device for ATA/ATAPI that was migrating into SCSI because
of the ide-scsi driver.

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

