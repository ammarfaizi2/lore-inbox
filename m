Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282833AbRK0HdE>; Tue, 27 Nov 2001 02:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282060AbRK0Hcy>; Tue, 27 Nov 2001 02:32:54 -0500
Received: from ns.suse.de ([213.95.15.193]:1041 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282835AbRK0Hcn>;
	Tue, 27 Nov 2001 02:32:43 -0500
To: Joe Korty <l-k@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <1006832357.1385.3.camel@icbm.suse.lists.linux.kernel> <5.0.2.1.2.20011127020817.009ed3d0@pop.mindspring.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2001 08:32:42 +0100
In-Reply-To: Joe Korty's message of "27 Nov 2001 08:16:04 +0100"
Message-ID: <p73lmgssm79.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <l-k@mindspring.com> writes:
> 
> I have not yet seen the patch, but one nice feature that a system call 
> interface
> could provide is the ability to *atomically* change the cpu affinities of 
> sets of
> processes

Could you quickly explain an use case where it makes a difference if 
CPU affinity settings for multiple processes are done atomically or not ? 

The only way to make CPU affinity settings of processes really atomically 
without a "consolidation window" is to
do them before the process starts up. This is easy when they're inherited --
just set them for the parent before starting the other processes. This 
works with any interface; proc based or not as long as it inherits.

-Andi
