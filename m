Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266951AbRGKXq5>; Wed, 11 Jul 2001 19:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbRGKXqr>; Wed, 11 Jul 2001 19:46:47 -0400
Received: from node-cffb9242.powerinter.net ([207.251.146.66]:39918 "HELO
	switchmanagement.com") by vger.kernel.org with SMTP
	id <S266951AbRGKXqa>; Wed, 11 Jul 2001 19:46:30 -0400
Message-ID: <3B4CE556.9000608@switchmanagement.com>
Date: Wed, 11 Jul 2001 16:46:30 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Lance Larsh <llarsh@oracle.com>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lance Larsh wrote:

>On Wed, 11 Jul 2001, Brian Strand wrote:
>
>>Our Oracle configuration is on reiserfs on lvm on Mylex.
>>
>I can pretty much tell you it's the reiser+lvm combination that is hurting
>you here.  At the 2.5 kernel summit a few months back, I reported that
>
Why did it get so much worse going from 2.2.16 to 2.4.4, with an 
otherwise-identical configuration?  We had reiserfs+lvm under 2.2.16 too.

>
>some of our servers experienced as much as 10-15x slowdown after we moved
>to 2.4.  As it turned out, the problem was that the new servers (with
>identical hardware to the old servers) were configured to use reiser+lvm,
>whereas the older servers were using ext2 without lvm.  When we rebuilt
>the new servers with ext2 alone, the problem disappeared.  (Note that we
>also tried reiserfs without lvm, which was 5-6x slower than ext2 without
>lvm.)
>
>I ran lots of iozone tests which illustrated a huge difference in write
>throughput between reiser and ext2.  Chris Mason sent me a patch which
>improved the reiser case (removing an unnecessary commit), but it was
>still noticeably slower than ext2.  Therefore I would recommend that
>at this time reiser should not be used for Oracle database files.
>
How do ext2+lvm, rawio+lvm, ext2 w/o lvm, and rawio w/o lvm compare in 
terms of Oracle performance?  I am going to try a migration if 2.4.6 
doesn't make everything better; do you have any suggestions as to the 
relative performance of each strategy?

Thanks,
Brian


