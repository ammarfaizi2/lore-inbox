Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVBCCzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVBCCzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVBCCzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:55:04 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:43014 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262484AbVBCCyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:54:35 -0500
Date: Wed, 2 Feb 2005 18:54:07 -0800
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203025407.GB15334@nietzsche.lynx.com>
References: <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com> <42014C10.60407@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42014C10.60407@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 08:54:24AM +1100, Peter Williams wrote:
> As Ingo said in an earlier a post, with a little ingenuity this problem 
> can be solved in user space.  The programs in question can be setuid 
> root so that they can set RT scheduling policy BUT have their 
> permissions set so that they only executable by owner and group with the 
> group set to a group that only contains those users that have permission 
> to run this program in RT mode.  If you wish to allow other users to run 
> the program but not in RT mode then you would need two copies of the 
> program: one set up as above and the other with normal permissions.

Again, in my post that you snipped you didn't either read or understand
what I was saying regarding QoS, nor about the large scale issues regarding
dual/single kernel development environments. Ultimately this stuff requires
non-trivial support in kernel space, a softirq thread migration mechanism
and a frame driven scheduler to back IO submission across async boundaries.

My posts where pretty clear on this topic and lot of this has origins
coming from SGI IRIX. Yes, SGI IRIX. One of the only system man enough
to handle this stuff.

Ancient, antiquated Unix scheduler semantics (sort and run) and lack of
control over critical facilities like softirq processing are obstacles
to getting at this.

bill

