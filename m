Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVEDLmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVEDLmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 07:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVEDLmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 07:42:44 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:20450 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261594AbVEDLmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 07:42:39 -0400
Date: Wed, 4 May 2005 13:42:34 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Joe <joecool1029@gmail.com>
Cc: 7eggert@gmx.de, linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Empty partition nodes not created (was device node issues with
 recent mm's and udev)
In-Reply-To: <d4757e600505032049716c811b@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0505041337110.12821@be1.lrz>
References: <3ZVNP-5cq-7@gated-at.bofh.it>  <E1DTAgo-0002uD-F0@be1.7eggert.dyndns.org>
 <d4757e600505032049716c811b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2005, Joe wrote:

> On 5/3/05, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
> <7eggert@gmx.de> wrote:
> > Joe <joecool1029@gmail.com> wrote:
> > 
> > > Here is the partition table from fdisk, fdisk does run fine.. its just
> > > the fact this node is not created that threw me off before.
> > >
> > >    Device Boot      Start         End      Blocks   Id  System
> > > /dev/sdb1   *           1           2       16033+   0  Empty
> > > /dev/sdb2   *           6        2431    19486845    b  W95 FAT32
> > > /dev/sdb3               3           5       24097+  83  Linux
> > >
> > > Notice, /dev/sdb1 is a Empty partition... in /dev I only have sdb,
> > > sdb2, and sdb3.  No sdb1.  Any help would be appreciated.
> > 
> > Some vendors depend on empty partitions not showing up. That's why this
> > patch was introduced.
> 
> It would be interesting to see just how important it is to hide this. 

The size and position values were quite random, and the useless extra
partition caused some problems.

> > BTW: Is there a special reason you why choose "empty"?
> > Is this partition showing up in other systems at all?
> 
> Actually, yes there is.. its a firmware partition that would normally
> not be mounted, but in order to dd new firmware versions to it, I
> depended on the node... which has ceased to exist.

So it isn't empty.-) I asume it will be in a custom system, so you can
hijack the compaq partition type (which was used for a similar purpose).

BTW: If you can do that, you should move the partition to the end of the
disk into the slower area of he disk.

-- 
"Bravery is being the only one who knows you're afraid."
-David Hackworth
