Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWH2RMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWH2RMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbWH2RMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:12:22 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:21419
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S965162AbWH2RMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:12:21 -0400
Date: Tue, 29 Aug 2006 10:11:54 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060829171154.GA11627@gnuppy.monkey.org>
References: <20060823210558.GA17606@gnuppy.monkey.org> <20060823210842.GB17606@gnuppy.monkey.org> <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com> <20060824014658.GB19314@gnuppy.monkey.org> <20060825071957.GA30720@gnuppy.monkey.org> <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com> <20060826104923.GA7879@gnuppy.monkey.org> <e6babb600608281133q3597c42dsa88820ddd82f9d01@mail.gmail.com> <20060828202827.GA3625@gnuppy.monkey.org> <e6babb600608282105v7d8c90b0g6631414b3f868e3c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608282105v7d8c90b0g6631414b3f868e3c@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 09:05:27PM -0700, Robert Crocombe wrote:
> On 8/28/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> 
> >I was unclear in explain that __put_task_struct() should never
> >appear with free_task() in a stack trace as you can clearly see
> >from the implementation. All it's suppose to do is wake a thread,
> >so "how?" you're getting those things simultaneously in the stack
> >trace is completely baffling to me. Could you double check to see
> >if it's booting the right kernel ? maybe make sure that's calling
> >that version of the function with printks or something ?
> 
> So I built another kernel with the most recent "t6" patches from
> scratch and stuck in a directory 2.6.17-rt8-mrproper.
> 
> [rcrocomb@spanky ~]$ cd kernel/
> [rcrocomb@spanky kernel]$ rm -Rf test_2.6.17-rt8/
> [rcrocomb@spanky kernel]$ tar xf source/linux-2.6.16.tar
> [rcrocomb@spanky kernel]$ mv linux-2.6.16/ 2.6.17-rt8-mrproper
> [rcrocomb@spanky kernel]$ cd 2.6.17-rt8-mrproper/
> [rcrocomb@spanky 2.6.17-rt8-mrproper]$ patch -s -p1 < 
> ../patches/patch-2.6.17
> [rcrocomb@spanky 2.6.17-rt8-mrproper]$ patch -s -p1 <
> ../patches/patch-2.6.17-rt8
> [rcrocomb@spanky 2.6.17-rt8-mrproper]$ patch -s -p0 < ../patches/t6.diff
> [rcrocomb@spanky 2.6.17-rt8-mrproper]$ uname -r
> 2.6.17-rt8_UP_00

I'm going to ask what seems like a really stupid question. What's "t6" ?
and what's the relationship of that to my patches ?

[side note: I'm headed to Burning Man tomorrow and won't be on a computer
for 6 days until I come back]

bill

