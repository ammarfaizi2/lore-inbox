Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280430AbRKXWuW>; Sat, 24 Nov 2001 17:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRKXWuN>; Sat, 24 Nov 2001 17:50:13 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:65273 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280430AbRKXWuH>;
	Sat, 24 Nov 2001 17:50:07 -0500
Date: Sat, 24 Nov 2001 15:49:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011124154955.B17277@lynx.no>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E167Fuw-00001K-00@DervishD> <Pine.LNX.4.33.0111231944430.2891-100000@fargo> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011124115411.C25094@joshua.mesa.nl> <20011124131902.A537@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011124131902.A537@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Sat, Nov 24, 2001 at 01:19:02PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 24, 2001  13:19 -0800, Mike Castle wrote:
> On Sat, Nov 24, 2001 at 11:54:11AM +0100, Marcel J.E. Mol wrote:
> > Hm, the e2fsck check does not work for me...
> > The .journal file still exists after
> > 
> >    # umount /dev/hda11
> >    # e2fsck -f /dev/hda11
> >    # mount /dev/hda11
> >    # rpm -q e2fsprogs
> >    e2fsprogs-1.25-1
> 
> I was just going to comment on this as well.  I cannot get this to work as
> advertised on a homegrown system as well.
> 
> Even tune2fs -l | grep inode and ls -i .journal show it's still using the
> same inode.
> 
> Actually, a quick look through the code, I can't see where e2fsck would
> take measures to hide .journal.  At least not in 1.25.

OK, my bad.  This is in my version of e2fsprogs (from Ted's BitKeeper
repository), but is not in an official release of e2fsprogs yet.  It
will be in 1.26, but for now I don't even think there is a WIP release
which has it.  Sorry for the confusion.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

