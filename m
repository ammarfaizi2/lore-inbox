Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278113AbRJKFpd>; Thu, 11 Oct 2001 01:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278112AbRJKFpX>; Thu, 11 Oct 2001 01:45:23 -0400
Received: from dialup-65-169-128-102.olp.net ([65.169.128.102]:2432 "EHLO
	dialup-65-169-128-102.olp.net") by vger.kernel.org with ESMTP
	id <S278110AbRJKFpP>; Thu, 11 Oct 2001 01:45:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: arvest@orphansonfire.com
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
Date: Thu, 11 Oct 2001 00:45:23 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.GSO.4.21.0110110121270.21168-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110110121270.21168-100000@weyl.math.psu.edu>
X-identity: qwertyatorphansonfire
MIME-Version: 1.0
Message-Id: <01101100452300.00621@lithium>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 October 2001 00:23, Alexander Viro wrote:
> On Thu, 11 Oct 2001 arvest@orphansonfire.com wrote:
> >   I can get the system booted enough to work on (and totaly up) with this
> > partition failing.  I dont know what more information from fdisk I can
> > give you, sda9 is there with .10, and gone with .11  It even allowed me
> > to add a new partition (i didnt save)  I tried sfdisk but it gave me
> > these errors.
>
> Sigh... OK, dmesg|grep sda on both kernels + fdisk -l /dev/sda (also on
> both).

  Ok, heres .10

Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17783250 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
omitting empty partition (9)
 
Disk /dev/sda: 64 heads, 32 sectors, 8683 cylinders
Units = cylinders of 2048 * 512 bytes
 
   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1       501    513008   83  Linux
/dev/sda2           502      3698   3273728   83  Linux
/dev/sda3          3699      4199    513024   83  Linux
/dev/sda4          4200      8683   4591616    5  Extended
/dev/sda5          4200      4700    513008   83  Linux
/dev/sda6          4701      5725   1049584   83  Linux
/dev/sda7          5726      5918    197616   82  Linux swap
/dev/sda8          5919      6419    513008   83  Linux

heres .11

Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17783250 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
omitting empty partition (9)
 
Disk /dev/sda: 64 heads, 32 sectors, 8683 cylinders
Units = cylinders of 2048 * 512 bytes
 
   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1       501    513008   83  Linux
/dev/sda2           502      3698   3273728   83  Linux
/dev/sda3          3699      4199    513024   83  Linux
/dev/sda4          4200      8683   4591616    5  Extended
/dev/sda5          4200      4700    513008   83  Linux
/dev/sda6          4701      5725   1049584   83  Linux
/dev/sda7          5726      5918    197616   82  Linux swap
/dev/sda8          5919      6419    513008   83  Linux

  sda9 is mounted, and it does have its file system intact even though fdisk 
says its ommiting empty partition 9.  Ill save you the eye strain, diff came 
up empty.

