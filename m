Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287604AbSAEIhg>; Sat, 5 Jan 2002 03:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287613AbSAEIh1>; Sat, 5 Jan 2002 03:37:27 -0500
Received: from mout1.freenet.de ([194.97.50.132]:51346 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S287604AbSAEIhL>;
	Sat, 5 Jan 2002 03:37:11 -0500
Message-ID: <3C36BBAA.1010609@athlon.maya.org>
Date: Sat, 05 Jan 2002 09:39:06 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011231
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: brownfld@irridia.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <200201040019.BAA30736@webserver.ithnet.com>	<3C360D6E.9020207@athlon.maya.org> <20020104215503.7c43dac2.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

[...]

>>If you have applications, which doesn't 
>>access to much memory, you can't view the problems.
>>If you access more than 1G (and you do not just copy, but rsync e.g.) 
>>and you have only 512MB of RAM, the machine swaps a lot with most actual 
>>2.4.-kernels (patches).
>>
> 
> Can you provide a simple and reproducible test case (e.g. some demo source),
> where things break? I am very willing to test it here.
> 

It's easy - take a grown inn-newsserver-partition with reiserfs (*) (a 
lot of small files and a lot of directories), about 1,3 GB or more, and 
do a complete rsync to this partition to transport it somewhere else. 
But you have to do it with a existing target, no empty target, so that 
rsync must scan the whole target partition, too.

I don't like special test-programs. They seldom show up the reality. 
What we need is a kernel that behaves fine in reality - not in testcases.
And before starting the test, take care, that most of ram is already 
used for cache or buffers or applications.

I did this test with several VM-patches and there are huge differences 
in swap consumption between them: 319MB with 2.4.17rc2 and 59MB with 
2.4.17 oom-patch (max).
It's more than a little difference :-).


Regards,
Andreas Hartmann


(*) If I had DSL, I would send it to you (as tar.gz) - but with modem, 
it's a bit too much :-)!
But your squid cache should be fine, too. It has a similar structure: a 
lot of small files and a lot of subdirectories. But I think, that your 
squid cache size isn't as high as my inn-partition.

