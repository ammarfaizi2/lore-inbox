Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVBCD0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVBCD0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 22:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVBCD0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 22:26:00 -0500
Received: from gizmo05bw.bigpond.com ([144.140.70.40]:28614 "HELO
	gizmo05bw.bigpond.com") by vger.kernel.org with SMTP
	id S262801AbVBCDZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 22:25:49 -0500
Message-ID: <420199B7.1000607@bigpond.net.au>
Date: Thu, 03 Feb 2005 14:25:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: "Jack O'Quin" <joq@io.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com> <42014C10.60407@bigpond.net.au> <20050203025407.GB15334@nietzsche.lynx.com>
In-Reply-To: <20050203025407.GB15334@nietzsche.lynx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Thu, Feb 03, 2005 at 08:54:24AM +1100, Peter Williams wrote:
> 
>>As Ingo said in an earlier a post, with a little ingenuity this problem 
>>can be solved in user space.  The programs in question can be setuid 
>>root so that they can set RT scheduling policy BUT have their 
>>permissions set so that they only executable by owner and group with the 
>>group set to a group that only contains those users that have permission 
>>to run this program in RT mode.  If you wish to allow other users to run 
>>the program but not in RT mode then you would need two copies of the 
>>program: one set up as above and the other with normal permissions.
> 
> 
> Again, in my post that you snipped you didn't either read or understand
> what I was saying regarding QoS,

I guess that I thought that it was overkill for the problem under 
discussion and probably won't solve it anyway.  Giving any task special 
preferential (emphasis on the preferential) treatment should require 
authorization by a suitably privileged entity at some stage.  So the 
problem of how ordinary users manage to launch tasks that receive 
preferential treatment will remain.

> nor about the large scale issues regarding
> dual/single kernel development environments. Ultimately this stuff requires
> non-trivial support in kernel space, a softirq thread migration mechanism
> and a frame driven scheduler to back IO submission across async boundaries.
> 
> My posts where pretty clear on this topic and lot of this has origins
> coming from SGI IRIX. Yes, SGI IRIX. One of the only system man enough
> to handle this stuff.
> 
> Ancient, antiquated Unix scheduler semantics (sort and run) and lack of
> control over critical facilities like softirq processing are obstacles
> to getting at this.

Sorry for upsetting you,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
