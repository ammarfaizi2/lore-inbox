Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSAEQUf>; Sat, 5 Jan 2002 11:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288856AbSAEQUZ>; Sat, 5 Jan 2002 11:20:25 -0500
Received: from mout0.freenet.de ([194.97.50.131]:60582 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S288855AbSAEQUT>;
	Sat, 5 Jan 2002 11:20:19 -0500
Message-ID: <3C37172E.2020306@athlon.maya.org>
Date: Sat, 05 Jan 2002 16:09:34 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020105
X-Accept-Language: en-us
MIME-Version: 1.0
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
CC: Stephan von Krawczynski <skraw@ithnet.com>, brownfld@irridia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33.0201050355300.11089-100000@shell1.aracnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M. Edward (Ed) Borasky wrote:

> On Sat, 5 Jan 2002, Andreas Hartmann wrote:
> 
> 
>>I don't like special test-programs. They seldom show up the reality.
>>What we need is a kernel that behaves fine in reality - not in
>>testcases.  And before starting the test, take care, that most of ram
>>is already used for cache or buffers or applications.
>>
> 
> OK, here's some pseduo-code for a real-world test case. I haven't had a
> chance to code it up, but I'm guessing I know what it's going to do. I'd
> *love* to be proved wrong :).


I would like to try it with the oom-patch, which needed less swap in my 
tests. It could be a good test to verify the results of the rsync-test.


> # build and boot a kernel with "Magic SysRq" turned on
> # echo  1 > /proc/sys/kernel/sysrq
> # fire up "nice --19 top" as "root"
> # read "MemTotal" from /proc/meminfo
> 
> # now start the next two jobs concurrently
> 
> # write a disk file with "MemTotal" data or more in it
> 
> # perform a 2D in-place FFT of total size at least "MemTotal/2" but less
> # than "MemTotal"
> 
> Watch the "top" window like a hawk. "Cached" will grow because of the
> disk write and "free" will drop because the page cache is growing and
> the 2D FFT is using *its* memory.


Could you please tell me a programm, that does 2D FFT? I would like to 
do this test, too!

Regards,
Andreas Hartmann

