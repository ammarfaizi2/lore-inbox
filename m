Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270161AbSISGj1>; Thu, 19 Sep 2002 02:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270163AbSISGj1>; Thu, 19 Sep 2002 02:39:27 -0400
Received: from h106-129-61.datawire.net ([207.61.129.106]:10653 "EHLO
	newmail.datawire.net") by vger.kernel.org with ESMTP
	id <S270161AbSISGj0> convert rfc822-to-8bit; Thu, 19 Sep 2002 02:39:26 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with contest 0.34
Date: Thu, 19 Sep 2002 01:44:20 -0400
User-Agent: KMail/1.4.6
Cc: sct@redhat.com, akpm@digeo.com, Con Kolivas <conman@kolivas.net>,
       linux-kernel@vger.kernel.org
References: <200209182118.12701.spstarr@sh0n.net> <200209190016.26609.spstarr@sh0n.net> <20020919061301.GB13929@clusterfs.com>
In-Reply-To: <20020919061301.GB13929@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209190144.20212.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, all the tests were done in single user mode =)

On September 19, 2002 02:13 am, Andreas Dilger wrote:
> On Sep 19, 2002  00:16 -0400, Shawn Starr wrote:
> > These results compare EXT3 against EXT2 with rmap using the contest tool
> > you can get it at: http://contest.kolivas.net
> >
> > These tests are from a Athlon MP 2000+ w/ 512MB RAM
> >
> > noload:
> >
> > Kernel					Time            	CPU
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            259.47		99%
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            267.66          	97%
> >
> > process_load:
> >
> > Kernel                  			Time            	CPU
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            318.91          	80%
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            324.44          	79%
> >
> > io_halfmem:
> >
> > Kernel                  			Time			CPU
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            306.82          	87%
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            461.74          	57%
> >
> > io full mem:
> >
> > Kernel					Time			CPU
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            325.39          	82%
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            411.47          	64%
>
> I don't see this as hugely surprising.  ext3 uses more CPU than ext2.
> If you are using up the CPU doing other things, then naturally ext3
> will take a longer wall-clock time to complete the same tasks as ext2.
>
> I know that Andrew has been doing a bunch of work to reduce ext3 CPU
> usage/locking/etc., but I think that is all in 2.5 kernels.
>
> Cheers, Andreas
> --
> Andreas Dilger
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> http://sourceforge.net/projects/ext2resize/

