Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWHOLgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWHOLgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965370AbWHOLgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:36:54 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3176 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965361AbWHOLgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:36:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eoFarz0imIiGOUIxO42sWPsRYZitEY4AkjpbE8boKVIJcxcVKqvYRWzb+CDbbSBLaRIpmHlePkAAbUmvIT16bCXyBPl95sFCGtBydS8I9TKts0NSO1Za6eQDdokoAp8ZjR9/qmCdgpPEoiKT4d8fSFE9jtM+fE8EG250nBxACqc=
Message-ID: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
Date: Tue, 15 Aug 2006 13:36:52 +0200
From: "Carsten Otto" <carsten.otto@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Daily crashes, incorrect RAID behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

System specs below (iCH7R, software raid 5)

My problems continue, even with a new and good power supply.
1) The system loses a disk about every week, only a hard reboot solves that
2) In the last three nights the system lost all disk access and
trashed the file systems

Regarding 1)
The system works normally and suddenly one disk does not respond.
After a soft reboot the BIOS does not recognize the disk, here a hard
reboot helps. Whenever I start my normal system in this situation, my
file systems get trashed. I think the software raid thinks the failed
disks (which lost several hours of write accesses) is OK and then
merges the data. When I delete the disk (or create another raid on the
partitions) I can add the disk without problems. This might be a bug,
at least it is _very_ annoying.

Regarding 2)
The system works as usual, but stops whenever disk access is needed
(some cached webpages work, but ssh login does not). On the screen I
see some scrolling messages telling me:
DriveReadySeekComplete (I do not recall the exact words, sorry) for one disk
many ext3 errors ("Something % 4 != 0, inode ..., something ..., )
After a reboot with the failed disk removed (to avoid the problem of
1) the system's file system is totally corrupt, fsck.ext3 finds a lot
of errors.
In my opinion this should not happen in a raid 5, am I correct?

Sidenotes:
The hard disk all are OK, I checked them.
The system choses the failing disks at random. I do not see a pattern here.
After I reported similar problems here I got the hint to get a better
power supply. I did that (600W now) but that does not help.
However, after the upgrade to the new power supply the system worked
fine for almost two weeks (then the weekly crashes started).

System specs:
Kernel 2.6.17.8 and newer
Software raid 5
Asus P5LB2 with iCH7R
Pentium D 805 (Dual Core)
2 GB PC533
4x Maxtor 300GB (Sata2)
1x Samsung 200GB (Pata)
Intel PCIe network

Thanks vor _every_ hint, I am desperate. The system is quite new and
only makes problems.
-- 
Carsten Otto
carsten.otto@gmail.com
www.c-otto.de
