Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287617AbRLaThT>; Mon, 31 Dec 2001 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287616AbRLaThJ>; Mon, 31 Dec 2001 14:37:09 -0500
Received: from mail.gmx.de ([213.165.64.20]:56971 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S287615AbRLaThC>;
	Mon, 31 Dec 2001 14:37:02 -0500
Message-ID: <3C30BE48.D9AC45F8@gmx.net>
Date: Mon, 31 Dec 2001 20:36:40 +0100
From: Mike <maneman@gmx.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Subject: Re: Oops: UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
In-Reply-To: <3C2F2948.DB59646A@gmx.net> <3C2F3455.6050209@wanadoo.fr> <3C2F47F2.BB7BFBDA@gmx.net> <20011231001822.C12868@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> On Dec 30, 2001  17:59 +0100, Mike wrote:
> > I tried 'e2fsck -f /dev/hdb3' and it returned:
> > "Filesystem has unsupported Read-Only features while trying to open
> > /dev/hdb3.
>
> Try "tune2fs -l /dev/hdb3" or "debugfs -h /dev/hdb3" (both do the same
> thing - spit out the ext2 filesystem superblock data.  What version of
> e2fsck are you using?
>
> > The SuperBlock could not be read or does not describe a correct ext2
> > filesystem.
> > ....If it /is/ ext2 then the Sb is corrupt, run 'e2fsck -b 8193 <device>'"
> >
> > So I do 'e2fsck -b 8193 <device>' and it says: "Bad magic number in SB
> > while trying to open /dev/hdb3"
>
> You are better off trying "e2fsck -B 4096 -b 32768 /dev/hdb3" instead.
>
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/

Sorry for the late reply....new year's eve etc...haven't been at my box for
over 24 hours.
I used e2fsck version 1.22 booted as a single user/maintenance system.
-Mike


