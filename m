Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVG2SXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVG2SXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVG2SXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:23:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261385AbVG2SXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:23:17 -0400
Date: Fri, 29 Jul 2005 11:22:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-Id: <20050729112212.62ad0907.akpm@osdl.org>
In-Reply-To: <200507291540.02278.dominik.karall@gmx.net>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<200506211520.44645.dominik.karall@gmx.net>
	<20050728215458.5f8bc27f.akpm@osdl.org>
	<200507291540.02278.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> On Friday 29 July 2005 06:54, Andrew Morton wrote:
> > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > On Tuesday 07 June 2005 13:29, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc
> > > >6/2. 6.12-rc6-mm1/
> > >
> > > After looking in my dmesg output today, I saw following error with
> > > 2.6.12-rc6-mm1, maybe it's usefull to you. I don't know when it exactly
> > > happens, cause I never used mono last time, I just did an emerge mono on
> > > my gentoo system, maybe this forced the failure.
> > >
> > > note: mono[26736] exited with preempt_count 1
> > > scheduling while atomic: mono/0x10000001/26736
> > >
> > > Call Trace:<ffffffff803e13ea>{schedule+122}
> > > <ffffffff8013197b>{vprintk+635} <ffffffff803e2738>{cond_resched+56}
> > > <ffffffff80164de3>{unmap_vmas+1587} <ffffffff8016a560>{exit_mmap+128}
> > > <ffffffff8012e7bf>{mmput+31} <ffffffff80133466>{do_exit+438}
> > > <ffffffff8013bf25>{__dequeue_signal+501}
> > >        <ffffffff801340c8>{do_group_exit+280}
> > > <ffffffff8013e147>{get_signal_to_deliver+1575}
> > >        <ffffffff8010de92>{do_signal+162}
> > > <ffffffff8012d1e0>{default_wake_function+0}
> > >        <ffffffff8010e8e1>{sys_rt_sigreturn+577}
> > > <ffffffff8010eb3f>{sysret_signal+28}
> > >        <ffffffff8010ee27>{ptregscall_common+103}
> >
> > A couple of people reported this, but all seems to have gone quiet.  Is it
> > fixed in later -mm's?   Is 2.6.13-rc4 running OK?
> >
> > Thanks.
> 
> hi andrew!
> 
> I'm sorry, but it's not fixed in current 2.6.13-rc3-mm3. I did an emerge mono 
> right now to test it, and I got this one:
> Jul 29 15:26:37 [kernel] note: mono[11138] exited with preempt_count 1
> Jul 29 15:26:50 [kernel] file[14627]: segfault at 00002aaaab453000 rip 
> 00002aaaaaf652cf rsp 00007fffffe43b50 error 4
> Jul 29 15:26:50 [kernel] file[14633]: segfault at 00002aaaab453000 rip 
> 00002aaaaaf652cf rsp 00007fffffcc87a0 error 4
> Jul 29 15:26:51 [kernel] file[14669]: segfault at 00002aaaab453000 rip 
> 00002aaaaaf652cf rsp 00007fffff905f80 error 4
> 
> DEBUG_KERNEL/ PREEMPT/ SPINLOCK are enabled, but I didn't get more info about 
> the bug. Did I forget any debug option?

Gee, I don't know how to find this one.  Do you know if the problem is
specific to -mm?
