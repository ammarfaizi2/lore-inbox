Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbTCaXrd>; Mon, 31 Mar 2003 18:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261937AbTCaXrc>; Mon, 31 Mar 2003 18:47:32 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:31638 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S261935AbTCaXrb>; Mon, 31 Mar 2003 18:47:31 -0500
Date: Mon, 31 Mar 2003 15:58:48 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
In-Reply-To: <Pine.LNX.4.44.0303311122070.5431-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303311551040.2220-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Linus Torvalds wrote:

> On Mon, 31 Mar 2003, Wayne Whitney wrote:
> >
> > I run dosemu 1.0.2.1 on the 2.5.x kernels.  Upgrading from 2.5.64 to
> > 2.5.65 (or 2.5.66) causes dosemu to no longer work:  it locks up the
> > machine shortly after I run it.
> 
> There appears to be at least one bug (that is longstanding but might be 
> made worse by the MSR stuff). However, that one should matter only with 
> preemption enabled. What's your configuration?

UP with preempt.  2.5.66 with the patch you sent still locks up.  I should
mention that I am running two copies of a hacked XFree86 on two different
sets of KVM hardware, but that doesn't require any kernel patches (well, a
small one to the input layer).

> Also, do you actually have a new library that uses SYSENTER (ie recent 
> redhat beta), and whct kind of CPU do you have?

Well, I have glibc-2.3.1-51, from RedHat Rawhide February 20, so it sounds
like that uses SYSENTER.  The CPU is an Althon XP, stepping 6-6-2.

Cheers, Wayne


