Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSHENjU>; Mon, 5 Aug 2002 09:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318459AbSHENjU>; Mon, 5 Aug 2002 09:39:20 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:48142 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318455AbSHENjT>; Mon, 5 Aug 2002 09:39:19 -0400
Message-ID: <3D4E80BA.5040701@namesys.com>
Date: Mon, 05 Aug 2002 17:42:18 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
References: <Pine.LNX.4.33L2.0208021507420.14068-100000@dragon.pdx.osdl.net> <1028552648.1251.26.camel@laptop.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:

>  
>
>>For a LinuxWorld presentation in August, I have asked each of the
>>4 journaling filesystems (ext3, reiserfs, JFS, and XFS) what their
>>filesystem/filesize limits are.  Here's what they have told me.
>>
>>                      ext3fs     reiserfs     JFS     XFS
>>max filesize:         16 TB#      1 EB       4 PB$   8 TB%
>>max filesystem size:   2 TB      17.6 TB*    4 PB$   2 TB!
>>
>>Notes:
>>#: think sparse files
>>*: 4 KB blocks
>>$: 16 TB on 32-bit architectures
>>%: 4 KB pages
>>!: block device limit
>>    
>>
>
>Randy,
>
>If those are the numbers you are presenting then make it clear that
>for XFS those are the limits imposed by the the Linux kernel. The
>core of XFS itself can support files and filesystems of 9 Exabytes.
>I do not think all the filesystems are reporting their numbers in
>the same way.
>
>Steve
>
>
>  
>
You might also mention that I think the limits imposed by Linux are the 
only meaningful ones, as we would change our limits as soon as Linux 
did, and it was Linux that selected our limits for us.  We would have 
changed already if Linux didn't make it pointless to change it on Intel. 
 Reiser4 will have 64 bit blocknumbers that will be semi-pointless until 
64 bit CPUs are widely deployed, and I am simply guessing this will be 
not very far into reiser4's lifecycle.  Really, the couple of #defines 
that constitute these size limits, plus some surrounding code, are not 
such a big thing to change (except that it constitutes a disk format 
change).

-- 
Hans



