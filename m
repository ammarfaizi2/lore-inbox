Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSGBJ2H>; Tue, 2 Jul 2002 05:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGBJ2G>; Tue, 2 Jul 2002 05:28:06 -0400
Received: from ns.suse.de ([213.95.15.193]:62223 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316715AbSGBJ2F>;
	Tue, 2 Jul 2002 05:28:05 -0400
To: Timo Benk <t_benk@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: allocate memory in userspace
References: <20020701172659.GA4431@toshiba.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Jul 2002 11:30:34 +0200
In-Reply-To: Timo Benk's message of "1 Jul 2002 19:29:57 +0200"
Message-ID: <p73vg7ywk79.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Benk <t_benk@web.de> writes:

> I am a kernel newbie and i am writing a module. I 
> need to allocate some memory in userspace because
> i want to access syscalls like open(), lstat() etc.
> I need to call these methods in the kernel, and in
> my special case there is no other way, but i 
> do not want to reimplement all the syscalls.
> 
> I read that it should be possible, but i cannot
> find any example or recipe on how to do it.

mm_segment_t oldfs = get_fs(); 
set_fs(KERNEL_DS); 
ret = sys_yoursyscall(kernelargs ...) 
set_fs(oldfs); 

Do not even think about using mmap or accessing sys_call_table for this.
Your other post was so tasteless that it would be good if you retracted
it with a followup because it would be very bad to have such an bad example 
in the l-k archives open to innocent search machine users uncommented.

-Andi
