Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290733AbSAaJgA>; Thu, 31 Jan 2002 04:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291005AbSAaJfu>; Thu, 31 Jan 2002 04:35:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6604 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291000AbSAaJfg>;
	Thu, 31 Jan 2002 04:35:36 -0500
Date: Thu, 31 Jan 2002 12:33:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] x86 idle thread should clear %fs, %gs
In-Reply-To: <20020129000419.GA18496@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0201311230520.3132-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Pavel Machek wrote:

> > so it appears that this lowlevel x86 performance bug(?) is more than 11
> > years old! :-)
>
> Probably 386's were not optimized for %fs==%gs==0 case?
>
> BTW does it really make a difference for the CPU?

whether %fs/%gs is 0 or not? With the current 2.5.3-pre6 task switching
code there definitely is a performance difference, because we optimize the
'both values are 0' case. With the original TSS-based task switching
microcode i suspect it made a difference as well. (switching between two
different %fs/%gs values should be slower.)

	Ingo

