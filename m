Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRJKGIw>; Thu, 11 Oct 2001 02:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272593AbRJKGIm>; Thu, 11 Oct 2001 02:08:42 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:33520 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272636AbRJKGIb>; Thu, 11 Oct 2001 02:08:31 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 11 Oct 2001 00:08:14 -0600
To: arvest@orphansonfire.com
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
Message-ID: <20011011000814.B23927@turbolinux.com>
Mail-Followup-To: arvest@orphansonfire.com,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110110121270.21168-100000@weyl.math.psu.edu> <01101100452300.00621@lithium>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01101100452300.00621@lithium>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 11, 2001  00:45 -0500, arvest@orphansonfire.com wrote:
> > On Thu, 11 Oct 2001 arvest@orphansonfire.com wrote:
> > >   I can get the system booted enough to work on (and totaly up) with this
> > > partition failing.  I dont know what more information from fdisk I can
> > > give you, sda9 is there with .10, and gone with .11  It even allowed me
> > > to add a new partition (i didnt save)  I tried sfdisk but it gave me
> > > these errors.
>
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 17783250 512-byte hdwr sectors (9105 MB)
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
> omitting empty partition (9)
>  
> /dev/sda1   *         1       501    513008   83  Linux
> /dev/sda2           502      3698   3273728   83  Linux
> /dev/sda3          3699      4199    513024   83  Linux
> /dev/sda4          4200      8683   4591616    5  Extended
> /dev/sda5          4200      4700    513008   83  Linux
> /dev/sda6          4701      5725   1049584   83  Linux
> /dev/sda7          5726      5918    197616   82  Linux swap
> /dev/sda8          5919      6419    513008   83  Linux

You probably need to go into fdisk and change the partition type of
sda9 from "0" to "83" (or any other non-zero type).  There is a
reason that it is saying "omitting empty partition (9)" at boot,
and "fdisk -l" doesn't list it - because type "0" means "I don't exist".

In fdisk, use the "t" option to set the type of sda9.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

