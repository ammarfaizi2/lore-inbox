Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281915AbRLAWWz>; Sat, 1 Dec 2001 17:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281914AbRLAWWg>; Sat, 1 Dec 2001 17:22:36 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:19330 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281913AbRLAWWZ>;
	Sat, 1 Dec 2001 17:22:25 -0500
Message-ID: <3C09580F.5F323195@pobox.com>
Date: Sat, 01 Dec 2001 14:22:07 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Charles-Edouard Ruault <ce@ruault.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
In-Reply-To: <3C0954D5.6AA3532B@ruault.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles-Edouard Ruault wrote:

> Hi there,
>
> i've experienced very weird behaviour with kernel 2.4.16 ( on at least 2
> different machines with different motherboards & CPUs ).
> I'm having ext2 filesystem problems on both machines now, one is totally
> unusable i need to reinstall it from scratch.

Are you sure? perhaps a forced fsck of all
filesystems would do the trick. New linux users
coming from a microsoft background are too
quick to reinstall as a means of maintenance.

>
> I've noticed the problem on different points :
> - first lots of problems with symlinks ....
>  unable to compile the kernel for example it bails out with "too many
> symlinks levels" ,
>
> /usr/include/asm/pgtable.h:109:33:
> /usr/src/linux/include/asm/pgtable-2level.h: Too many levels of symbolic
> links

Yes, it looks like the filesystem is corrupted.

> I backtracked to kernel 2.4.14 and now after doing an fsck on all my
> partitions ( only one problem reported on /home ) , everything is back
> to normal.

Have you tried 2.4.16 since the fsck?

> I've read that there was a filesystem problem in 2.4.15 that is supposed
> to be fixed in 2.4.16.

That is the case,

> These 2 machines did run 2.4.15 from it's birtday until 2.4.16 was born
> so maybe the problem was created in 2.4.15 but showed up in 2.4.16 ...
> If someone has an explanation to this behaviour, i would be really happy

Of course.

The 2.4.15 filesystem corruption problem occurred
on shutdown. When you booted up into 2.4.16, the
filesystem was corrupt and you began to see the
strange symptoms. when you backtracked to 2.4.14
and did the fsck, the problems were corrected.

I'll bet $20 that 2.4.16 runs fine now as well.

cu

jjs


