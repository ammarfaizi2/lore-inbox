Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTBXNFI>; Mon, 24 Feb 2003 08:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbTBXNFI>; Mon, 24 Feb 2003 08:05:08 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:59782 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266968AbTBXNFH>; Mon, 24 Feb 2003 08:05:07 -0500
Message-ID: <3E5A1671.5060202@namesys.com>
Date: Mon, 24 Feb 2003 15:56:17 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  comments on st_blksize and f_bsize for 2.5
References: <3E526C94.3020109@namesys.com> <20030224102009.GB14024@win.tue.nl>
In-Reply-To: <20030224102009.GB14024@win.tue.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

>On Tue, Feb 18, 2003 at 08:25:40PM +0300, Hans Reiser wrote:
>
>  
>
>>Since a few applications, and the linux manpages, seem to not really 
>>understand what these are for, they need comments like SUSv2 has for 
>>them.  A larger discussion will be provided if requested.
>>    
>>
>
>  
>
>>+	unsigned int	st_blksize;	/* Optimal I/O size */
>>    
>>
>
>  
>
>>+	int f_bsize;	/* Filesystem blocksize */
>>    
>>
>
>Yes, discussion - I wouldnt mind seeing details.
>
>The trivial part is st_blksize: all agree.
>Quoting the man page:
>
>       The value st_blksize gives the "preferred" blocksize
>       for efficient file system I/O.  (Writing to a file in
>       smaller chunks may cause an inefficient read-modify-rewrite.)
>
Oh my, I must confess that we read just the comment on the struct in the 
manpage:

                 blksize_t     st_blksize;  /* blocksize for filesystem 
I/O */

and not the text below it which is correct if less clear than it could be.

How about using our comment on the struct on the manpage as it is more 
clear? 


How about instead saying in the manpage body:

Historically, st_blksize was the block size, and applications would do 
I/O's at that size for greater efficiency of IO.  Now, after some 
evolution, st_blksize represents the most efficient size of an IO to 
that file, and no longer always represents the actual size of blocks in 
the underlying filesystem.


Or you could even use the longer comment on the struct, but then I have 
always liked lng comments more than most....;-)

-- 
Hans


