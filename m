Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSGBKUG>; Tue, 2 Jul 2002 06:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSGBKUF>; Tue, 2 Jul 2002 06:20:05 -0400
Received: from smtp01.web.de ([194.45.170.210]:18696 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S316051AbSGBKUF>;
	Tue, 2 Jul 2002 06:20:05 -0400
Date: Tue, 2 Jul 2002 12:21:55 +0200
From: Timo Benk <t_benk@web.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timo Benk <t_benk@web.de>
Subject: Re: allocate memory in userspace
Message-ID: <20020702102155.GA9965@toshiba>
Reply-To: Timo Benk <t_benk@web.de>
References: <20020701172659.GA4431@toshiba.suse.lists.linux.kernel> <p73vg7ywk79.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vg7ywk79.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 11:30:34AM +0200, Andi Kleen wrote:
> Timo Benk <t_benk@web.de> writes:
> 
> > I am a kernel newbie and i am writing a module. I 
> > need to allocate some memory in userspace because
> > i want to access syscalls like open(), lstat() etc.
> > I need to call these methods in the kernel, and in
> > my special case there is no other way, but i 
> > do not want to reimplement all the syscalls.
> > 
> > I read that it should be possible, but i cannot
> > find any example or recipe on how to do it.
> 
> mm_segment_t oldfs = get_fs(); 
> set_fs(KERNEL_DS); 
> ret = sys_yoursyscall(kernelargs ...) 
> set_fs(oldfs); 
Thank you very much for that hint.

> Do not even think about using mmap or accessing sys_call_table for this.
> Your other post was so tasteless that it would be good if you retracted
> it with a followup because it would be very bad to have such an bad example 
> in the l-k archives open to innocent search machine users uncommented.
I will post a followup, but please tell me
a) a good doc for that topic where i can read why it is so bad
b) a reference for the do_mmap call

While searching through the ng archives i just found (lots of) hints
that this can be done with mmap, so that was my approach to solve
the problem.

Maybe it will be better that you (or any other) will comment what
is so bad, as i told in my first post i am a newbie, so please keep
that in mind.

-timo

-- 
gpg key fingerprint = 6832 C8EC D823 4059 0CD1  6FBF 9383 7DBD 109E 98DC

