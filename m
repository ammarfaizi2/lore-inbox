Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316492AbSE3IrV>; Thu, 30 May 2002 04:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSE3IrV>; Thu, 30 May 2002 04:47:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53007 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316492AbSE3IrU>;
	Thu, 30 May 2002 04:47:20 -0400
Message-ID: <3CF5E698.2020806@mandrakesoft.com>
Date: Thu, 30 May 2002 04:45:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <Pine.LNX.4.44.0205292019090.9971-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

>On Wed, 29 May 2002, Jeff Garzik wrote:
>
>  
>
>>Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
>>he wanted an evolution to a new build system... not an unreasonable 
>>request to at least consider.  Despite Keith's quality of code (again -- 
>>I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
>>very "take it or leave it dammit".  Not the best way to win friends and 
>>influence people.
>>
>>If Keith is indeed leaving it, I'm hoping someone will maintain it, or 
>>work with Kai to integrate it into 2.5.x.
>>    
>>
>
>Oh well, it really wasn't my intention to start the good old kbuild-2.5
>thread at all.
>
>Anyway, I believe kbuild-2.5 has lots of useful ideas and I'll go pick 
>pieces - from kbuild-2.5, from dancing-makefiles, from stuff I've done 
>myself and work on improving the current build system. But I believe in 
>make, and don't think I'll move away from it.
>
>One thing these patches show is that gradual improvement is actually
>possible, so far the kbuild process has gained quite some features with a
>lot of small patches - and some bigger ones, but these are only trivial
>cleanups.
>
>Of course it happened that I introduced some bugs in the process, but the
>fact that fixes were posted to linux-kernel by the next morning shows that
>it's obviously possible for other people to grasp what's going on and fix
>bugs. Rules.make is some 400 lines currently, that's quite a difference to 
>kbuild-2.5 core's 30000 lines of code.
>
>Anyway, fortunately it's not up to me to decide what happens. From my 
>perspective the plan is to go on with this gradual improvement, in
>particular 
>o fix dependencies / modversions (that includes "make dep" going away)
>o allow for separate objdir (this one is actually easy for 95% of the
>  compiled files which use standard rules, and lots of work for the 
>  remaining 5%. So it'll take time to remove the 5% special cases, after
>  that things are pretty easy)
>  
>

A small request to add to the list:

Current 2.4.x kernels build (at least on x86) with
     -nostdinc -I /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.0.4/include
added to CFLAGS...  IMOit is a good idea in general to build all kernel 
code this way.  (note that userland programs created during build should 
not use this rule, of course)


