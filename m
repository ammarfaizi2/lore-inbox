Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269984AbSISG1Z>; Thu, 19 Sep 2002 02:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269996AbSISG1Z>; Thu, 19 Sep 2002 02:27:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:19082 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S269984AbSISG1Y>;
	Thu, 19 Sep 2002 02:27:24 -0400
Message-ID: <3D896F73.5D1265B5@digeo.com>
Date: Wed, 18 Sep 2002 23:32:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Shawn Starr <spstarr@sh0n.net>, sct@redhat.com,
       Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with 
 contest 0.34
References: <200209182118.12701.spstarr@sh0n.net> <200209182140.30364.spstarr@sh0n.net> <1032403983.3d893c0f8986b@kolivas.net> <200209190016.26609.spstarr@sh0n.net> <20020919061301.GB13929@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 06:32:19.0932 (UTC) FILETIME=[4E19D1C0:01C25FA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> ...
> > Kernel                                        Time                    CPU
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            325.39                82%
> > 2.4.20-pre7-rmap14a-xfs-uml-shawn12d            411.47                64%
> 
> I don't see this as hugely surprising.  ext3 uses more CPU than ext2.
> If you are using up the CPU doing other things, then naturally ext3
> will take a longer wall-clock time to complete the same tasks as ext2.

Yup.  But here the CPU load is less; obviously some more seeking
was done.  That's fairly normal for ext3 - it has to write the journal
as well as the filesystem....
 
> I know that Andrew has been doing a bunch of work to reduce ext3 CPU
> usage/locking/etc., but I think that is all in 2.5 kernels.
> 

I had a little patch.  Stephen is working on the big fix.
