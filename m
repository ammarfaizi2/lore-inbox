Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbTC0XIO>; Thu, 27 Mar 2003 18:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTC0XIO>; Thu, 27 Mar 2003 18:08:14 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:22021 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261464AbTC0XIN>; Thu, 27 Mar 2003 18:08:13 -0500
Date: Fri, 28 Mar 2003 00:19:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303280008530.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> 
 <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27 Mar 2003, Alan Cox wrote:

> > How are these disks registered and how will the dev_t number look like?
> 
> Al Viro's work so far makes those issues you can defer nicely. 

I know his work, I'm just trying to find out, whether Andries understands 
it too, or if he maybe knows something I don't.

> > How will the user know about these numbers?
> 
> Devices.txt or dynamic assignment

The first case means a /dev directory with millions of dev entries.
How does the user find out about the number of partitions in the second 
case?

> > Who creates these device entries (user or daemon)?
> 
> Who cares 8)  Thats just the devfs argument all over again 8)

Why? I specifically didn't mention the kernel.
Anyone has to care, somehow this large number space must be managed.

> > SCSI has multiple majors, disks 0-15 are at major 8, disks 16-31 are at 
> > 65, ...., disks 112-127 are at major 71. Will this stay the same? Where 
> > are the disk 128-xxx?
> > Can I have now more than 15 partitions?
> 
> It becomes possible, more importantly we can begin to support
> partitioned CD-ROM both for multisession and for real partition
> tables on CD (eg Macintrash)

How exactly does this become possible?

bye, Roman

