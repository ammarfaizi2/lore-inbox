Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276552AbRJKQrK>; Thu, 11 Oct 2001 12:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276562AbRJKQrB>; Thu, 11 Oct 2001 12:47:01 -0400
Received: from [209.202.108.240] ([209.202.108.240]:7697 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S276547AbRJKQqp>; Thu, 11 Oct 2001 12:46:45 -0400
Date: Thu, 11 Oct 2001 12:46:57 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <01101111415700.05168@lithium>
Message-ID: <Pine.LNX.4.33.0110111245490.25209-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 arvest@orphansonfire.com wrote:

> On Thursday 11 October 2001 01:08, Andreas Dilger wrote:
> > On Oct 11, 2001  00:45 -0500, arvest@orphansonfire.com wrote:
> > > > On Thu, 11 Oct 2001 arvest@orphansonfire.com wrote:
> > > > >   I can get the system booted enough to work on (and totaly up) with
> > > > > this partition failing.  I dont know what more information from fdisk
> > > > > I can give you, sda9 is there with .10, and gone with .11  It even
> > > > > allowed me to add a new partition (i didnt save)  I tried sfdisk but
> > > > > it gave me these errors.
> > >
> > > Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> > > SCSI device sda: 17783250 512-byte hdwr sectors (9105 MB)
> > >  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
> > > omitting empty partition (9)
> > >
> > > /dev/sda1   *         1       501    513008   83  Linux
> > > /dev/sda2           502      3698   3273728   83  Linux
> > > /dev/sda3          3699      4199    513024   83  Linux
> > > /dev/sda4          4200      8683   4591616    5  Extended
> > > /dev/sda5          4200      4700    513008   83  Linux
> > > /dev/sda6          4701      5725   1049584   83  Linux
> > > /dev/sda7          5726      5918    197616   82  Linux swap
> > > /dev/sda8          5919      6419    513008   83  Linux
> >
> > You probably need to go into fdisk and change the partition type of
> > sda9 from "0" to "83" (or any other non-zero type).  There is a
> > reason that it is saying "omitting empty partition (9)" at boot,
> > and "fdisk -l" doesn't list it - because type "0" means "I don't exist".
> >
> > In fdisk, use the "t" option to set the type of sda9.
>
>   sda9 doesnt show in fdisk.  Cylinders 6420-8683 are shown free.

Ouch. You may have to use partedit from PartitionMagic (or some other
low-level partition editor) to manually change the partition type.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

