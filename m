Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSHFSWE>; Tue, 6 Aug 2002 14:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSHFSWD>; Tue, 6 Aug 2002 14:22:03 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53254
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315198AbSHFSWC>; Tue, 6 Aug 2002 14:22:02 -0400
Date: Tue, 6 Aug 2002 11:17:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: martin@dalecki.de
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.30 IDE 112
In-Reply-To: <3D4FBFA4.3030809@evision.ag>
Message-ID: <Pine.LNX.4.10.10208061113060.15852-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

I had this battle a long time ago.
Every little bit of disk that is out there, regardless if they should be
orphaned sectors or not, people want access.  This includes having the
kernel do stupid things like seek beyond media.

Just leave it alone.

Once all devices are 48-bit capable, then the game is over.

"All 48-bit capable shall be LBA addressed".

Nobody can force CHS crap down the pipes and thus the game is over on the
stupid concept of XXX/16/63!  Until then do everyone a favor and listen
and learn from AEB, okay?

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 6 Aug 2002, Marcin Dalecki wrote:

> Uz.ytkownik Petr Vandrovec napisa?:
> > On  6 Aug 02 at 12:27, Andries Brouwer wrote:
> > 
> >>On Tue, Aug 06, 2002 at 10:50:42AM +0200, Marcin Dalecki wrote:
> >>
> >>>- Just removaing dead obscure xlate_1024 code.
> >>
> >>Command line options must be added to ask for what this
> >>xlate_1024 code did earlier. So, some fragments of what you remove
> >>in this patch will have to come back in some form.
> > 
> > 
> > FYI I had to use hda=cyls,255,63 to repartition my HDD. BIOS refused
> > to report proper size (120GB) when partition table was empty, or when
> > it contained partitions created for xxx/16/63 geometry. It reported
> > size ~600MB, and actively refused to allow access above this limit...
> > 
> > With removed (either completely, or just disabling as it is now) xlate_1024 
> > code please talk to [cs]fdisk maintainer (and other) to print big fat
> > warning and to allow specify BIOS heads/sectors, otherwise partitioning
> > of empty disk in the way compatible with non-Linux OSes (Netware, Windows)
> > is not an easy task.
> 
> Sidenote 1. - they can do the recalculation done by xlate_1024 themself 
> of  course.
> 
> Sidenote 2. - Linux is thinking xxx/16/63 is the best way to deal with 
> big disks. Phenix BIOS docu says xxxx/255/63 is the way to go.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

