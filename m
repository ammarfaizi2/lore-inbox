Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276535AbRJKQmA>; Thu, 11 Oct 2001 12:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276552AbRJKQlu>; Thu, 11 Oct 2001 12:41:50 -0400
Received: from dialup-65-169-128-157.olp.net ([65.169.128.157]:58497 "EHLO
	dialup-65-169-128-157.olp.net") by vger.kernel.org with ESMTP
	id <S276535AbRJKQll>; Thu, 11 Oct 2001 12:41:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: arvest@orphansonfire.com
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: 2.4.11 loses sda9
Date: Thu, 11 Oct 2001 11:41:57 -0500
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110110121270.21168-100000@weyl.math.psu.edu> <01101100452300.00621@lithium> <20011011000814.B23927@turbolinux.com>
In-Reply-To: <20011011000814.B23927@turbolinux.com>
X-identity: qwertyatorphansonfire
MIME-Version: 1.0
Message-Id: <01101111415700.05168@lithium>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 October 2001 01:08, Andreas Dilger wrote:
> On Oct 11, 2001  00:45 -0500, arvest@orphansonfire.com wrote:
> > > On Thu, 11 Oct 2001 arvest@orphansonfire.com wrote:
> > > >   I can get the system booted enough to work on (and totaly up) with
> > > > this partition failing.  I dont know what more information from fdisk
> > > > I can give you, sda9 is there with .10, and gone with .11  It even
> > > > allowed me to add a new partition (i didnt save)  I tried sfdisk but
> > > > it gave me these errors.
> >
> > Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> > SCSI device sda: 17783250 512-byte hdwr sectors (9105 MB)
> >  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
> > omitting empty partition (9)
> >
> > /dev/sda1   *         1       501    513008   83  Linux
> > /dev/sda2           502      3698   3273728   83  Linux
> > /dev/sda3          3699      4199    513024   83  Linux
> > /dev/sda4          4200      8683   4591616    5  Extended
> > /dev/sda5          4200      4700    513008   83  Linux
> > /dev/sda6          4701      5725   1049584   83  Linux
> > /dev/sda7          5726      5918    197616   82  Linux swap
> > /dev/sda8          5919      6419    513008   83  Linux
>
> You probably need to go into fdisk and change the partition type of
> sda9 from "0" to "83" (or any other non-zero type).  There is a
> reason that it is saying "omitting empty partition (9)" at boot,
> and "fdisk -l" doesn't list it - because type "0" means "I don't exist".
>
> In fdisk, use the "t" option to set the type of sda9.

  sda9 doesnt show in fdisk.  Cylinders 6420-8683 are shown free.  
