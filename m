Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTLUOyu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTLUOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:54:50 -0500
Received: from bay8-dav32.bay8.hotmail.com ([64.4.26.89]:63241 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262386AbTLUOys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:54:48 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Sun, 21 Dec 2003 15:54:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcPHXsHf8om6yCvrQ/6oQOpTLHimTwAcvNEw
In-Reply-To: <3FE4F0D3.2020904@comcast.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV32MiRAI5RTH0000f8a2@hotmail.com>
X-OriginalArrivalTime: 21 Dec 2003 14:54:47.0290 (UTC) FILETIME=[608515A0:01C3C7D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nopes, I get the kernel panic before the driver loads or when it does,
however I'm not seeing any ataraid driver message at all. This is really
strange I think. The only thing that has changed in my setup are the
harddrives. I really need to get this working. Do you have any suggestions
what-so-ever what to do? I really appreciate your help on this.

/Nicke

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 21 december 2003 02:01
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> Hi,
> 
> Oh I forgot to say that i'm running RAID1 and it detects both drives 
> perfectly (I'm passing the IDE addresses to the kernel at boot time 
> from the lilo conf, see previous post). The system was reinstalled 
> yesterday with two brand new 80GB Western Digital disks 
> (WD800JB-00DUA3). The thing is, I have succesfully installed the 
> TX2000 card with the native ATARAID drivers before using two 30GB 
> Maxtor (something) disks and kernel 2.4-20 - 2.4.23. I wonder why I 
> can't get it up and running now. It will only work with the pre 
> compiled kernel shipped with Debian 3.0 (2.4.18-bf2.4). I have tried 
> all sorts of kernel settings. Since I have got it to work before I think
should be able to do it again.
> 
> Please advise.  
> 
> /Nicke

Hmmm. I'm pretty sure that the partitions are enumerated the same way in
2.4.23 vs. 2.4.18.  There was a change in the way IDE geometry was returned
from the kernel that caused a hiccup in the pdcraid driver around 2.4.22 I
think?  My patch just tells the pdcraid to use an alternate method of
finding the RAID superblock on each drive. Not sure what else might be the
problem. Do you see the ataraid driver fire up (looking something like
this):

ataraid/d0: ataraid/d0p1
Drive 0 is 239372 Mb (33 / 0)
Drive 1 is 239372 Mb (34 / 0)
Raid1 array consists of 2 drives.
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta

The only problem I've recently come upon with pdcraid, is when it detects
just one of the drives and fails. I didn't think that should happen with
raid1 though.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
