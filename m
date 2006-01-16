Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWAPKZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWAPKZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 05:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWAPKZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 05:25:50 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:15570
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932319AbWAPKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 05:25:50 -0500
Date: Mon, 16 Jan 2006 02:22:55 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Message-ID: <20060116102255.GA19401@gnuppy.monkey.org>
References: <20060115042449.GA9871@gnuppy.monkey.org> <Pine.LNX.4.44L0.0601160926360.4219-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601160926360.4219-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 09:35:42AM +0100, Esben Nielsen wrote:
> On Sat, 14 Jan 2006, Bill Huey wrote:
> I am not precisely sure what you mean by "false reporting".
> 
> Handing off BKL is done in schedule() in sched.c. I.e. if B owns a normal
> mutex, A will give BKL to B when A calls schedule() in the down-operation
> of that mutex.

Task A holding BKL would have to drop BKL when it blocks against a mutex held
by task B in my example and therefore must hit schedule() before any pi boost
operation happens. I'll take another look at your code just to see if this is
clear.

bill

