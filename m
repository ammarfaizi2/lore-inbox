Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSKMSiS>; Wed, 13 Nov 2002 13:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSKMSiS>; Wed, 13 Nov 2002 13:38:18 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:24051 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262480AbSKMSiR>; Wed, 13 Nov 2002 13:38:17 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 13 Nov 2002 11:42:46 -0700
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 recovery
Message-ID: <20021113184246.GD9930@clusterfs.com>
Mail-Followup-To: Andrei Ivanov <andrei.ivanov@ines.ro>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0211131906120.6956-300000@webdev.ines.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211131906120.6956-300000@webdev.ines.ro>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 13, 2002  19:13 +0200, Andrei Ivanov wrote:
> Hello, I have an ext3 formated partition on a harddrive that just got tons
> of badblocks and I'm trying to recover as much data as possible from that
> partition.
> If I try e2fsck /dev/hdb3 I get this error:
> 
> e2fsck 1.32 (09-Nov-2002)
> Group descriptors look bad... trying backup blocks...
> e2fsck: Invalid argument while checking ext3 journal for /
> 
> So I tried to remove the journal and make e2fsck treat the partition as an
> ext2 one, but no luck, although tune2fs -O ^has_journal /dev/hdb3 doesn't
> give me any message, except it's version string.
> 
> If I pass fsck the backup superblock myself, it still refuses to run:
> e2fsck -b 32768 /dev/hdb3
> e2fsck: Invalid argument while checking ext3 journal for /
> 
> Attached you will find some info (dmesg and hdparm). If you need any more
> info, tell me.

I would suggest "dd if=bad_drive of=good_drive conv=sync,noerror"
and then do all of your recovery on the good drive.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

