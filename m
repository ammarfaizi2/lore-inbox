Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbRLaHS7>; Mon, 31 Dec 2001 02:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbRLaHSt>; Mon, 31 Dec 2001 02:18:49 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:22510 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S284669AbRLaHSl>;
	Mon, 31 Dec 2001 02:18:41 -0500
Date: Mon, 31 Dec 2001 00:18:22 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Mike <maneman@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Subject: Re: Oops: UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
Message-ID: <20011231001822.C12868@lynx.no>
Mail-Followup-To: Mike <maneman@gmx.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Pierre Rousselet <pierre.rousselet@wanadoo.fr>
In-Reply-To: <3C2F2948.DB59646A@gmx.net> <3C2F3455.6050209@wanadoo.fr> <3C2F47F2.BB7BFBDA@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C2F47F2.BB7BFBDA@gmx.net>; from maneman@gmx.net on Sun, Dec 30, 2001 at 05:59:30PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 30, 2001  17:59 +0100, Mike wrote:
> I tried 'e2fsck -f /dev/hdb3' and it returned:
> "Filesystem has unsupported Read-Only features while trying to open
> /dev/hdb3.

Try "tune2fs -l /dev/hdb3" or "debugfs -h /dev/hdb3" (both do the same
thing - spit out the ext2 filesystem superblock data.  What version of
e2fsck are you using?

> The SuperBlock could not be read or does not describe a correct ext2
> filesystem.
> ....If it /is/ ext2 then the Sb is corrupt, run 'e2fsck -b 8193 <device>'"
> 
> So I do 'e2fsck -b 8193 <device>' and it says: "Bad magic number in SB
> while trying to open /dev/hdb3"

You are better off trying "e2fsck -B 4096 -b 32768 /dev/hdb3" instead.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

