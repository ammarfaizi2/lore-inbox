Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268338AbSIRRsM>; Wed, 18 Sep 2002 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268344AbSIRRsL>; Wed, 18 Sep 2002 13:48:11 -0400
Received: from holomorphy.com ([66.224.33.161]:35819 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268338AbSIRRrm>;
	Wed, 18 Sep 2002 13:47:42 -0400
Date: Wed, 18 Sep 2002 10:47:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918174729.GW3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel@vger.kernel.org
References: <20020918173653.GV3530@holomorphy.com> <Pine.LNX.4.44.0209181044240.1384-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209181044240.1384-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, William Lee Irwin III wrote:
>> There were only 10K tasks, with likely consecutively-allocated PID's,
>> and some minor background fork()/exit() activity, but there are more
>> offenders on the read side than get_pid() itself.
>> There is no question of PID space: the full 2^30 was configured in
>> the tests done after the PID space expansion. 

On Wed, Sep 18, 2002 at 10:46:35AM -0700, Linus Torvalds wrote:
> I bet the lockup was something else. There have been other bugs recently 
> with the task state changes, and the lockup may just have been a regular 
> plain lockup. Thread exit has been kind of fragile lately, although it 
> looks better now.
> 		Linus

Pretty much the same tasklist iteration issues have been visible
running benchmarks on kernels from 2.4.early up. 2.5.x activity on this
front was somewhat stymied by architecture support issues whose causes
were not discovered until 2.5.20 or thereabouts, and perhaps also the
fact little time was specifically allocated to addressing it.


Bill
