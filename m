Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314889AbSEHTKd>; Wed, 8 May 2002 15:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314906AbSEHTKc>; Wed, 8 May 2002 15:10:32 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17422
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314889AbSEHTKc>; Wed, 8 May 2002 15:10:32 -0400
Date: Wed, 8 May 2002 12:08:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <5.1.0.14.2.20020508195954.040d2a80@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10205081201170.30697-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

You have a practical model that is coming togather nicely (compliments
from the old man), there is a change in the industry to use MMIO based ATA
HBA's.  We are currently in a transistion state of affairs, so the problem
Benjamin address that everyone has overlooked is going to bite hard and
soon.  There will even be HBA's whose channels will be split between IOMIO
and MMIO, thus being able to select between access calls is urgent.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Wed, 8 May 2002, Anton Altaparmakov wrote:

> At 19:55 08/05/02, Andre Hedrick wrote:
> >On Wed, 8 May 2002, Anton Altaparmakov wrote:
> >
> > > </me ignorant>Um, what about the IDE PCI cards which have 4 channels on
> > > them? Like these two:
> > >
> > > Adaptec 2400 4Ch IDE Raid Controller
> > > RocketRaid 404 4Ch ATA133 Raid Host Adaptor
> >
> >It is not an issue since they broadcast as single channel pairs per host.
> >Martin is winning the argument hands down.
> 
> Thanks, I was just wondering not trying to argument...
> 
> Best regards,
> 
>          Anton
> 
> 
> -- 
>    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> -- 
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
> 

