Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282084AbRKWJMN>; Fri, 23 Nov 2001 04:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281823AbRKWJMD>; Fri, 23 Nov 2001 04:12:03 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:16909 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S282084AbRKWJLn>; Fri, 23 Nov 2001 04:11:43 -0500
Message-ID: <3BFE1245.1030300@namesys.com>
Date: Fri, 23 Nov 2001 12:09:25 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Joel Beach <joelbeach@optushome.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Maximum (efficient) partition sizes for various filesystem types...
In-Reply-To: <001401c170d3$ea40cc10$1e50a8c0@kinslayer> <E165lCN-00061N-00@the-village.bc.nu> <20011122203000.B11821@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

>Hi,
>
>On Mon, Nov 19, 2001 at 09:58:43AM +0000, Alan Cox wrote:
>
>>>For instance, the Debian guide says that, due to Ext2 efficiency, partitions
>>>greater than 6-7GB shouldn't be created. Is this true for Ext3/ReiserFS.
>>>
>>I've run several 45-200Gb ext2 and ext3 partitions with no problem. I'm not
>>sure what the origin of the Debian guide comemnt is but I've never heard
>>it from an ext2 developer
>>
>
>The largest filesystem I use with ext3 at the moment is 40GB, and it
>is 98% full and is used *constantly* (it contains my main build
>trees).  I'm not sure where the 6-7GB limit idea comes from but I've
>got very few filesystems smaller than that, and they are still all
>ext3.
>
>Cheers,
> Stephen
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>

I bet the origin is the time it takes to run fsck.  If so, run any 
journaling filesystem and you'll be okay.  We have 2 terabyte systems 
out there, I bet ext3 does also.

hans

