Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130145AbRBTTHj>; Tue, 20 Feb 2001 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130337AbRBTTH1>; Tue, 20 Feb 2001 14:07:27 -0500
Received: from slc169.modem.xmission.com ([166.70.9.169]:34826 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130145AbRBTTHL>; Tue, 20 Feb 2001 14:07:11 -0500
To: Michal Vitecek <M.Vitecek@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: maximum process size on i386?
In-Reply-To: <20010220120358.A8211@fuf.sh.cvut.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Feb 2001 10:16:19 -0700
In-Reply-To: Michal Vitecek's message of "Tue, 20 Feb 2001 12:03:58 +0100"
Message-ID: <m1vgq5xokc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Vitecek <M.Vitecek@sh.cvut.cz> writes:

>  hello list,
> 
>    i apologize if this is way off-topic but noone i asked in my
>  whereabounds would help: what is the maximum task size for 2.4.x on a
>  i386 box and how do i change it (if possible)?
3 gigabytes of virtual address space.

>    i have processes that have to be really over 1gb (database engines) but
>  unfortnately, when one reaches over 900mb kswapd starts eating 50+% of 1
>  cpu and the whole thing gets slower.
You don't have enough ram?

>    so i tried to decrease __PAGE_OFFSET in include/asm-i386/page.h to
>  0x80000000 which as i learned should increase the task limit to ~2gb, but
>  the kernel _won't even boot_ (halts right after lilo loads it, no output
>  is written).

That decreases the task size.  The implementation in 2.4. is totally
different from 2.2. and the process virtual address space size does
not change in 2.4. 

>    the machine is 8xp3 xeon, 4gb ram, kernel 2.4.1-ac10, CONFIG_HIGHMEM
>  and CONFIG_HIGHMEM4G are set.

It looks like you might have a legitimate problem with your database
task, but you haven't provided enough information about it's behavior,
and it's expected behavior for anyone to diagnose what is going wrong
with your machine.


Eric
