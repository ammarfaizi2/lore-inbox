Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSEPJWf>; Thu, 16 May 2002 05:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316616AbSEPJWe>; Thu, 16 May 2002 05:22:34 -0400
Received: from 213-98-127-214.uc.nombres.ttd.es ([213.98.127.214]:11688 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S316615AbSEPJWd>;
	Thu, 16 May 2002 05:22:33 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
In-Reply-To: <20020516020134.GC1025@dualathlon.random>
	<Pine.LNX.4.44L.0205152303500.32261-100000@imladris.surriel.com>
	<20020516023238.GE1025@dualathlon.random>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 16 May 2002 11:27:37 +0200
Message-ID: <m2g00s8mt2.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "andrea" == Andrea Arcangeli <andrea@suse.de> writes:

Hi

andrea> I'm not using the full blown initrd of most distros that is aware of the
andrea> mistery of life and of all the kernel bugs out there too, my own dumb
andrea> linuxrc just says:

andrea> echo hello world

andrea> and then returns, and ext3 gets mounted as ext2 and that's a kernel bug,
andrea> all other fs gets mounted correctly with my initrd, only ext3 gone wrong
andrea> until I fixed it.

>> --- snip from linuxrc ----
>> mount --ro -t $rootfs $rootdev /sysroot
>> pivot_root /sysroot /sysroot/initrd
>> ------
>> 
>> This way you can specify both the root fs and - if wanted -
>> special mount options to the root fs. Then you pivot_root(2)
>> to move the root fs to / and the (old) initrd to /initrd.

andrea> both lines are completly superflous, very misleading as well. I
andrea> recommend to drop such two lines from all the full blown bug-aware
andrea> linuxrc out there (of course after you apply the ordering fix to the
andrea> kernel).

I am missing something, or how do you pass the notail option to your
reiserfs rootfs when the initrd is ext2.


Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
