Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319035AbSHFJpb>; Tue, 6 Aug 2002 05:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319036AbSHFJpb>; Tue, 6 Aug 2002 05:45:31 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:22790 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319035AbSHFJpa>; Tue, 6 Aug 2002 05:45:30 -0400
Message-ID: <3D4F9B71.3060409@namesys.com>
Date: Tue, 06 Aug 2002 13:48:33 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
References: <Pine.LNX.4.33L2.0208021507420.14068-100000@dragon.pdx.osdl.net> <1028552648.1251.26.camel@laptop.americas.sgi.com> <3D4E80BA.5040701@namesys.com> <20020806001643.GC9754@pegasys.ws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:

>On Mon, Aug 05, 2002 at 05:42:18PM +0400, Hans Reiser wrote:
>  
>
>>You might also mention that I think the limits imposed by Linux are the 
>>only meaningful ones, as we would change our limits as soon as Linux 
>>did, and it was Linux that selected our limits for us.  We would have 
>>changed already if Linux didn't make it pointless to change it on Intel. 
>>Reiser4 will have 64 bit blocknumbers that will be semi-pointless until 
>>64 bit CPUs are widely deployed, and I am simply guessing this will be 
>>not very far into reiser4's lifecycle.  Really, the couple of #defines 
>>that constitute these size limits, plus some surrounding code, are not 
>>such a big thing to change (except that it constitutes a disk format 
>>change).
>>    
>>
>
>Hans,
>
>My recollection is that reiser4 isn't released yet.  Why not
>set the reiser4 disk format with 64 bit blocknumbers from
>dot?  32 bit archs could write zeros and otherwise ignore
>the upper 32 bits and refuse to mount if filesystem size
>would cause overflow.  That way you avoid on-disk format
>change mid cycle.  That seems a lot less overhead than
>coping with different datatypes.
>
>Of course if you'd rather support another on-disk format
>to squeeze a bit more data onto small drives i can understand.
>
>  
>
We are using 64 bit blocknumbers in reiser4, and letting linux limit 
them.  Perhaps my writing style was rather lacking in clarity.....

Linux is going to use some hacks in 2.5 that will let it go moderately 
above the 2.4 limits.  64 bit blocknumbers seem the most flexible thing 
in the face of what will be ever evolving hacks followed by the 
introduction of 64 bit CPUs into the mainstream.

-- 
Hans



