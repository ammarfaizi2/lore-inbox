Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270767AbUJURGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270767AbUJURGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbUJURBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:01:10 -0400
Received: from brown.brainfood.com ([146.82.138.61]:8582 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S270465AbUJUQ7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:59:35 -0400
Date: Thu, 21 Oct 2004 11:59:33 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
In-Reply-To: <Pine.LNX.4.58.0410201125350.1219@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.58.0410211158100.1241@gradall.private.brainfood.com>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
 <20041020094508.GA29080@elte.hu> <Pine.LNX.4.58.0410201125350.1219@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Adam Heath wrote:

> On Wed, 20 Oct 2004, Ingo Molnar wrote:
>
> >
> > i have released the -U8 Real-Time Preemption patch:
> >
> >   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
>
> Grr.  I got this -U8 mail *before* I got the -U7 mail.
>
> All thruout these U# kernels, I get stalls in X(everything pauses, not sure if
> remote pings stop).  Nothing shows in dmesg when this occurs.

Got some input on this.

Heavy disk and/or network i/o seems to cause the pauses.  Doing a copy over
nfs(writing to disk), or using scp gives me 1-2 MB/s.  If I boot plain rc4, I
get full network speed(10-11 MB/s with nfs, 5-8 MB/s with scp).
