Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRKGVoO>; Wed, 7 Nov 2001 16:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKGVoK>; Wed, 7 Nov 2001 16:44:10 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:47355 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280954AbRKGVnf>;
	Wed, 7 Nov 2001 16:43:35 -0500
Date: Wed, 7 Nov 2001 14:42:31 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Zvi Har'El" <rl@math.technion.ac.il>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        nyh@math.technion.ac.il
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107144231.M5922@lynx.no>
Mail-Followup-To: Zvi Har'El <rl@math.technion.ac.il>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org, nyh@math.technion.ac.il
In-Reply-To: <20011107131930.H5922@lynx.no> <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il>; from rl@math.technion.ac.il on Wed, Nov 07, 2001 at 11:11:59PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  23:11 +0200, Zvi Har'El wrote:
> On Wed, 7 Nov 2001, Andreas Dilger wrote:
> > Are you SURE you are using ext3?  Check /proc/mounts to be sure.  What it
> > says in /etc/fstab is irrelevant for the root filesystem.
> >
> /proc/mounts has
> 
> /dev/root / ext2 rw 0 0
> /dev/hda6 /home ext3 rw 0 0
> 
> However, tune2fs -l on both /dev/hda1 (the root filesystem) and /dev/hda6
> Filesystem features:      has_journal sparse_super
> 
> 
> How do  fix the situation at this stage? I am using Redhat 7.2 with kernel
> 2.4.9-13

Do you have ext3 compiled into the kernel?  I suspect you have it as a module.

Also, given the large number of similar bug reports, maybe RedHat has a bug in
their mkinitrd script which doesn't try to mount the root fs with ext3?  I
don't know enough about their mkinitrd tools to say - Alan, Stephen?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

