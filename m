Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSGLRRl>; Fri, 12 Jul 2002 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSGLRRk>; Fri, 12 Jul 2002 13:17:40 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:32450 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S316681AbSGLRRi>;
	Fri, 12 Jul 2002 13:17:38 -0400
Message-ID: <3D2F1158.6060608@zianet.com>
Date: Fri, 12 Jul 2002 11:26:48 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020709
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <1026490866.5316.41.camel@thud> <20020712170532.GI8738@clusterfs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compared reiserfs with notails and with tails to
ext3 in journaled mode about a month ago.
Strangely enough the machine that was being
built is eventually slated for a mail machine.  I used
postmark to simulate the mail environment.

Benchmarks are available here:
http://labs.zianet.com

Let me know if I am missing any info on there.

Steven

Andreas Dilger wrote:

>On Jul 12, 2002  10:21 -0600, Dax Kelson wrote:
>  
>
>>ext3 data=ordered
>>ext3 data=writeback
>>reiserfs
>>reiserfs notail
>>
>>http://www.gurulabs.com/ext3-reiserfs.html
>>
>>Any suggestions or comments appreciated.
>>    
>>
>
>Did you try data=journal mode on ext3?  For real-life workloads sync-IO
>workloads like mail (e.g.  not benchmarks where the system is 100% busy)
>you can have considerable performance benefits from doing the sync IO
>directly to the journal instead of partly to the journal and partly to
>the rest of the filesystem.
>
>The reason why "real life" is important here is because the data=journal
>mode writes all the files to disk twice - once to the journal and again
>to the filesystem, so you must have some "slack" in your disk bandwidth
>in order to benefit from this increased throughput on the part of the
>mail transport.
>
>Cheers, Andreas
>--
>Andreas Dilger
>http://www-mddsp.enel.ucalgary.ca/People/adilger/
>http://sourceforge.net/projects/ext2resize/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



