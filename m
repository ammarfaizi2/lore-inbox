Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTK2JSs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 04:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTK2JSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 04:18:47 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:29644 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263740AbTK2JSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 04:18:45 -0500
Date: Sat, 29 Nov 2003 10:18:43 +0100
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129091843.GA2430@iliana>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 07:16:31AM +0200, Szakacsits Szabolcs wrote:
> 
> On Sat, 29 Nov 2003, Andrew Clausen wrote:
> > On Fri, Nov 28, 2003 at 03:24:52PM +0100, Andries Brouwer wrote:
> > >
> > > There is no such thing as a "correct" disk geometry.
> > 
> > Yes there is.  "Correct" is defined by the BIOS.  It is important
> > for boot loaders (in particular Windows).  
> 
> I suspected the same ... What Windows you mean? DOS (9x/ME/etc) or NT based
> (NT4/2000/XP/2003)? All?
> 
> > I'm not sure if this is still a big issue worth worrying about.
> 
> IMHO it might be. At least I'm getting an increasing number of emails from
> people who can't boot Windows anymore after resizing and repartitioning
> NTFS on Linux. Everybody thinks it's the Linux NTFS code's fault but so far
> it was always about the repartitioning going wrong. I just had to write a
> FAQ entry about this issue recently
> 
> 	http://mlf.linux.rulez.org/mlf/ezaz/ntfsresize.html#troubleshoot
> 
> Some users, having problems, did mention the usage of 2.6 kernel. If the
> geometry changed during the fdisk, etc process then it could result also
> booting problem? It's just a speculation because I've never had enough
> information to investigate.
> 
> Also, can Parted save/restore the full and exact partition table a
> scriptable way? I mean something like this:
> 
> 	sfdisk -d /dev/hda > hda.pt       # save
> 	sfdisk /dev/hda < hda.pt          # restore
> 
> sfdisk can't recover geometry so apparently no one-liner, widely available,
> partition table backup/recovery is possible at present on Linux :-o
> dd if=/dev/hda of=hda.mbr bs=512 count=1 won't save the logical partitions.

Yes, that would be a good idea, it would be even nice to automatically
save the partition table the first time parted access the harddisk. The
problem is that it needs to be saved on a separate harddisk though, or
printed or something such.

The partition table saving/restoring would be part of the partition
table specific code, so you could know the logical partitions or
whatever your precise non-mbr partition table mandates.

Friendly,

Sven Luther


