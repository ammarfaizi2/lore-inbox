Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292981AbSBVUCD>; Fri, 22 Feb 2002 15:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292980AbSBVUB4>; Fri, 22 Feb 2002 15:01:56 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:7457 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S292981AbSBVUBk> convert rfc822-to-8bit; Fri, 22 Feb 2002 15:01:40 -0500
Date: Thu, 21 Feb 2002 22:01:14 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <3C76A053.55A32E77@mandrakesoft.com>
Message-ID: <20020221215503.M1666-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
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

I have investigated it, but it didn't seem to allow the boot order set by
user in sym53c8xx HBA NVRAMs to be applied, breaking as a result all
systems depending on it. Since it is transparently handled by the
sym53c8xx driver and just behaves _as_ user expects, my guess is that
numerous users may just have their system relying on it.

> This is need for transparented support for cardbus and hotplug PCI, not
> some pie-in-the-sky code asthetic.  This will become further important
> as 2.5.x transitions more and more to Mochel's driver model work, which
> will among other things provide a sane power management model.
>
> To tangent, IDE and SCSI hotplug issues are interesting, because a lot
> of people forget or mix up the two types of hotplug, board (host)
> hotplug and drive hotplug.

Propose a kernel API that does not break more features that it adds and I
will be glad to use it.

  Gérard.

