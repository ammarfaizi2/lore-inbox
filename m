Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292985AbSBVUZe>; Fri, 22 Feb 2002 15:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292987AbSBVUZY>; Fri, 22 Feb 2002 15:25:24 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:64295 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S292985AbSBVUZN> convert rfc822-to-8bit; Fri, 22 Feb 2002 15:25:13 -0500
Date: Thu, 21 Feb 2002 22:24:22 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Greg KH <greg@kroah.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020222200750.GE9558@kroah.com>
Message-ID: <20020221221842.V1779-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
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
>
> > Propose a kernel API that does not break more features that it adds and I
> > will be glad to use it.
>
> Huh?  This is not a new API.  What does it break for you?

Thanks for the reply. But my concern is user convenience in _average_
here. Basically, I want the 99% of users that cannot afford neither need
nor want PCI hotplug to have their system just dead in order to make happy
the 1%.

In other word, I donnot care about this 1% if it makes run a tiny risk to
the 99% to get inconvenience a single second. Btw, I am among the 99%.

  Gérard.

