Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288752AbSAIDHm>; Tue, 8 Jan 2002 22:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288753AbSAIDHc>; Tue, 8 Jan 2002 22:07:32 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:39673 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288752AbSAIDHP>;
	Tue, 8 Jan 2002 22:07:15 -0500
Date: Tue, 8 Jan 2002 20:07:05 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Kervin Pierre <kpierre@fit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs corruption recovery?
Message-ID: <20020108200705.S769@lynx.adilger.int>
Mail-Followup-To: Kervin Pierre <kpierre@fit.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C3BB082.8020204@fit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C3BB082.8020204@fit.edu>; from kpierre@fit.edu on Tue, Jan 08, 2002 at 09:52:50PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 08, 2002  21:52 -0500, Kervin Pierre wrote:
> I install and used 2.4.17 for about a week before my filesystem 
> corrupted.  I've tried 'fsck -a' but it complains that there was no 
> valid superblock found.

Try "e2fsck -B 4096 -b 32768 <device>" instead.

> Are there any tools or techniques that will recover data from the 
> corrupted filesystem even if there isn't a valid superblock?  Or is 
> there a way to write a temporary superblock so I can access the 
> information on the disk?

The ext2 format (includes ext3) has backup superblocks for just this reason.

> Lastly, if all else fails I'm going to try sending the drive one of 
> those 'file recovery companies'.  Does anyone have a recommendation for 
> a particular company?  I'm guessing that there'll be a few that wouldn't 
> know what to do with a ext3 partition.

Is the data really that valuable, and you don't have a backup?  It may
cost you several thousand dollars to do a recovery from such a company.
Yet, it isn't worth doing backups, it appears.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

