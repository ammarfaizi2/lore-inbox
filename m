Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268823AbSIRR60>; Wed, 18 Sep 2002 13:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268824AbSIRR6Y>; Wed, 18 Sep 2002 13:58:24 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:49368 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S268823AbSIRR6T>;
	Wed, 18 Sep 2002 13:58:19 -0400
Date: Wed, 18 Sep 2002 12:00:04 -0600
From: yodaiken@fsmlabs.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918120004.A13778@hq.fsmlabs.com>
References: <Pine.LNX.4.44.0209181026550.1230-100000@home.transmeta.com> <Pine.LNX.4.44.0209181939150.24891-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209181939150.24891-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 18, 2002 at 07:54:53PM +0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 07:54:53PM +0200, Ingo Molnar wrote:
> or a phone line server that handles 100 thousand phone lines starts up
> 100K threads, one per line. No need to restart any of those threads, and
> in fact it will never happen. They do use helper threads to do less timing
> critical stuff. Now the whole phone system locks up for 1.5 minutes every
> 2 weeks or 2 months when the PID range overflows, how great. Now make that
> 400 thousand phonelines, the lockup will will last 24 minutes.

So Solaris made a stupid design decision to encourage people to use a
thread per call on these big systems and Linux should make the same
decision for compatibility?

I can see why people want this: they have huge ugly systems that they would
like to port to Linux with as little effort as possible. But it's not
free for the OS either. 

It's interesting to see that as Linux moves into the phone space owned by
Sun, two things are happening. (1)There is pressure to expand Linux to simply
match Solaris properties and (2) the entire technological and business
basis of those huge 100K+ thread racks is beginning to collapse.


---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

