Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTL3CLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTL3CLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:11:13 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:39670 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264334AbTL3CLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:11:10 -0500
Date: Mon, 29 Dec 2003 19:11:06 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4] Is a negative rsect in /proc/partitions normal?
Message-ID: <20031229191106.I6209@schatzie.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031230014429.GL1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031230014429.GL1882@matchmail.com>; from mfedyk@matchmail.com on Mon, Dec 29, 2003 at 05:44:29PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 29, 2003  17:44 -0800, Mike Fedyk wrote:
> I'm running 2.4.23-rc5, and I've been running bonnie, burnMMX and burnK7 for
> the last few days on my 3 drive md raid5 array, and I noticed that my
> rsects[1] have gone negative.  I might consider this normal but /proc/stat
> (which only shows hda) doesn't show any negative numbers for the same
> stats[2]
> 
> Is this a bug?
> 
> [1]
> major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
> 
>   56     0  160086528 hdi 240438349 1318355451 -414508366 16504630 101146331 1132637971 1281537580 24939164 -3 18108868 28693926
>   56     3  159694132 hdi3 240438290 1318355420 -414508552 16503120 101146229 1132637930 1281537288 24937454 0 19884967 309062
>   33     0  160086528 hde 240516418 1321486397 -388859454 40325686 90645794 1146603482 1312002136 18444936 -3 14785505 12315041
>   33     2  159790522 hde2 240516417 1321486394 -388859462 40325686 90645794 1146603482 1312002136 18444936 0 24147141 26883069
>    3     0  160086528 hda 240675036 1318323453 -412885008 27008859 110939441 1126008079 1306648420 28401642 -3 24294848 41908774
>    3     3  159694132 hda3 240467546 1317699583 -419535288 24234589 110932078 1125988609 1306423136 28337002 0 4327510 10687939

Probably just somewhere printing out %ld instead of %lu or similar.  I'm
sure a trivial patch to fix it would be accepted.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

