Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSEVBX3>; Tue, 21 May 2002 21:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSEVBX2>; Tue, 21 May 2002 21:23:28 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:45816 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316822AbSEVBX1>; Tue, 21 May 2002 21:23:27 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 21 May 2002 19:21:33 -0600
To: Jon Hedlund <JH_ML@invtools.com>
Cc: sct@redhat.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel - Ext3 & Raid patches
Message-ID: <20020522012133.GE13211@turbolinux.com>
Mail-Followup-To: Jon Hedlund <JH_ML@invtools.com>, sct@redhat.com,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <3CEA7866.23557.390B7FFC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 21, 2002  16:40 -0500, Jon Hedlund wrote:
> Last September Stephan told someone on the linux-kernel list that 
> Ext3 and Raid 1 didn't work together on the 2.2 kernel. 
> Has this been fixed or have I just been lucky?

You've just been lucky.  I forget the exact scenario, but it is
something like if journal replay is happening while the RAID is being 
reconstructed after a crash you can get garbage written to your disk.

> Three times in the last 9 months one of the drives reported errors 
> and dropped offline, each time I have fdisked the bad drive, 
> formatted it, fsck'ed it and found no problems, fdisked it again, and 
> raidhotadd'ed it back in and it restored the array without problems.

This is probably a matter of block remapping replacing bad sectors when
you try to write to it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

