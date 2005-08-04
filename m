Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVHDMMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVHDMMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVHDML5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:11:57 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:31932 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262491AbVHDMLK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:11:10 -0400
Message-ID: <3235.192.168.201.6.1123157467.squirrel@www.masroudeau.com>
Date: Thu, 4 Aug 2005 13:11:07 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: Re: IDE disk and HPA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > My question is now: why is an HPA disabled i.e. disprotected when
> > > detected? Why not let the HPA alone, because a certain set of disk
> > > sectors shall not be accessible by the OS?
> >
> > Because the HPA is most commonly used to hide all but a fraction of a
> > disk to work with older BIOSes.
>
> But as to my knowledge, the HPA was had been introduced to allow HW
> vendors to store things like diagnostic programs in a part of the
> disk protected from partitioning and filesystems.
> The point is, IF there is an HPA, there MIGHT be a partitioning
> scheme and some filesystems on the disk which rely on the size of
> disk being the native size MINUS the HPA.

  If those HW vendors want to store software in the HPA of the IDE
 hard disk, and they employ people able to read the IDE specifications,
 they know that this HPA can be protected by password and so Linux
 just display a failure when trying to restore the capacity of the
 Hard Disk - because it lacks the unlocking password.

  Note that this HPA is a good place to store a bootloader too, in fact
 I like to think of it as the big floppy drive of the PC which no more
 have any floppy drive: create a FAT filesystem of 64 Mbytes there and
 copy all the floppy you used to have there. Your bootloader, if it
 is good enough, will be able to run software from this area.

  I also have to add that it is finally time to read the ATA 4
 specification (published in august 1998) or any newer version, for
 instance at:
 http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf
 around page 30 / page 46 about "6.10 Security Mode feature set".
 Pay attentiong to the last sentense of "6.10.4 Frozen mode".
  If you are using the right bootloader someone has already taken care
 of that detail for you - you are not disk2brick virus sensitive, and
 you do not care much of the blankdisk virus neither - whatever the
 OSes you are using.

  Etienne.

--
 http://gujin.org

