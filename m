Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281023AbRKLVxx>; Mon, 12 Nov 2001 16:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281027AbRKLVxo>; Mon, 12 Nov 2001 16:53:44 -0500
Received: from tourian.nerim.net ([62.4.16.79]:34055 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S281023AbRKLVxZ>;
	Mon, 12 Nov 2001 16:53:25 -0500
Message-ID: <3BF044D3.8060503@free.fr>
Date: Mon, 12 Nov 2001 22:53:23 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011110
X-Accept-Language: en-us
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: File System Performance
In-Reply-To: <3BF02702.34C21E75@zip.com.au>,	<00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>	<3BEFF9D1.3CC01AB3@zip.com.au>	<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> 	<3BF02702.34C21E75@zip.com.au>	<1005595583.13307.5.camel@jen.americas.sgi.com> 	<3BF03402.87D44589@zip.com.au> <1005600431.13303.10.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>
>I tried an experiment which puzzled me somwhat:
>
>> mount /xfs
>> cd /xfs/lord/xfs-linux
>> time tar cf /dev/null linux
>>
>
>real    0m7.743s
>user    0m0.510s
>sys     0m1.380s
>
>>hdparm -t /dev/sda5
>>
>
>/dev/sda5:
> Timing buffered disk reads:  64 MB in  3.76 seconds = 17.02 MB/sec
>
>>du -sk linux
>>
>173028  linux
>
>The tar got ~21 Mbytes/sec.
>
Things I'll check :

0/ rerun this test !!!
1/ is there cache on the scsi controler ?
2/ xfs data cached at mount ? (I don't believe so)
3/ "hdparm -t" is on crack.
4/ du reports a disk usage way ahead of files' sizes total (don't know 
xfs enough to estimate this propability) and tar won't read the whole 
"du -sk" data.


2/ "time mount /xfs" could help (if mount + tar times are below 
expected, this case can be eliminated).
3/ ask hdparm's maintener.
4/ tar, check tar size.

