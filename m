Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269969AbSISGKJ>; Thu, 19 Sep 2002 02:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269977AbSISGKJ>; Thu, 19 Sep 2002 02:10:09 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:64752 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269969AbSISGKI>; Thu, 19 Sep 2002 02:10:08 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 19 Sep 2002 00:13:01 -0600
To: Shawn Starr <spstarr@sh0n.net>
Cc: sct@redhat.com, akpm@digeo.com, Con Kolivas <conman@kolivas.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with contest 0.34
Message-ID: <20020919061301.GB13929@clusterfs.com>
Mail-Followup-To: Shawn Starr <spstarr@sh0n.net>, sct@redhat.com,
	akpm@digeo.com, Con Kolivas <conman@kolivas.net>,
	linux-kernel@vger.kernel.org
References: <200209182118.12701.spstarr@sh0n.net> <200209182140.30364.spstarr@sh0n.net> <1032403983.3d893c0f8986b@kolivas.net> <200209190016.26609.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209190016.26609.spstarr@sh0n.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2002  00:16 -0400, Shawn Starr wrote:
> These results compare EXT3 against EXT2 with rmap using the contest tool
> you can get it at: http://contest.kolivas.net
> 
> These tests are from a Athlon MP 2000+ w/ 512MB RAM
> 
> noload:
> 
> Kernel					Time            	CPU
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            259.47		99%
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            267.66          	97%
> 
> process_load:
> 
> Kernel                  			Time            	CPU
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            318.91          	80%
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            324.44          	79%
> 
> io_halfmem:
> 
> Kernel                  			Time			CPU
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            306.82          	87%
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            461.74          	57%
> 
> io full mem:
> 
> Kernel					Time			CPU
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            325.39          	82%
> 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            411.47          	64%

I don't see this as hugely surprising.  ext3 uses more CPU than ext2.
If you are using up the CPU doing other things, then naturally ext3
will take a longer wall-clock time to complete the same tasks as ext2.

I know that Andrew has been doing a bunch of work to reduce ext3 CPU
usage/locking/etc., but I think that is all in 2.5 kernels.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

