Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSCDGXG>; Mon, 4 Mar 2002 01:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291809AbSCDGW5>; Mon, 4 Mar 2002 01:22:57 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:9460 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291787AbSCDGWu>;
	Mon, 4 Mar 2002 01:22:50 -0500
Date: Sun, 3 Mar 2002 23:18:51 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020303231851.N4188@lynx.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com> <20020303223103.J4188@lynx.adilger.int> <3C8308FE.FC4FA42@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8308FE.FC4FA42@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 04, 2002 at 12:41:18AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 04, 2002  00:41 -0500, Jeff Garzik wrote:
> Andreas Dilger wrote:
> > Actually, there are a whole bunch of performance issues with 1kB block
> > ext2 filesystems.  For very small files, you are probably better off
> > to have tails in EAs stored with the inode, or with other tails/EAs in
> > a shared block.  We discussed this on ext2-devel a few months ago, and
> > while the current ext2 EA design is totally unsuitable for that, it
> > isn't impossible to fix.
> 
> IMO the ext2 filesystem design is on it's last legs ;-)   I tend to
> think that a new filesystem efficiently handling these features is far
> better than dragging ext2 kicking and screaming into the 2002's :)

That's why we have ext3 ;-).  Given that reiserfs just barely has an
fsck that finally works most of the time, and they are about to re-do
the entire filesystem for reiser-v4 in 6 months, I'd rather stick with
glueing features onto an ext2 core than rebuilding everything from
scratch each time.

Given that ext3, and htree, and all of the other ext2 'hacks' seem to
do very well, I think it will continue to improve for some time to come.
A wise man once said "I'm not dead yet".

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

