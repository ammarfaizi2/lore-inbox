Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVKKPqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVKKPqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVKKPqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:46:38 -0500
Received: from silver.veritas.com ([143.127.12.111]:56882 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750825AbVKKPqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:46:38 -0500
Date: Fri, 11 Nov 2005 15:45:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:487
In-Reply-To: <200511102046.03290.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0511111529260.17057@goblin.wat.veritas.com>
References: <200511102046.03290.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Nov 2005 15:46:38.0071 (UTC) FILETIME=[1A21D870:01C5E6D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Alistair John Strachan wrote:
> Hi Hugh,
> 
> I was searching the list today for the subject line and found a response you 
> had written to Sandro Tosi on the 5th of this month.
> 
> I've had a similar oops on 2.6.14, my memory is checked and is okay, however I 
> cannot say reliably whether it is a kernel bug because I had the proprietary 
> NVIDIA driver loaded at the time, which I'm aware is a taboo on this list.

Thanks for the info.  Don't worry about the taboo.  But yes, it is
conceivable that the nVidia driver interferes in some way here,
and we simply don't know how advise on that.

> My system is entirely different from the reporter's, I'm running an x86-64 
> kernel, non-SMP but with PREEMPT. I've reported this to linux-bugs@nvidia.com 
> who told me simply that "preempt kernels have known stability issues". Having 
> recompiled without preempt, I have not yet encountered the problem, but since 
> it's so rare it's impossible to reproduce anyway.

Good, yes, do follow their advice.  But I hope they'll be doing
something to solve whatever their problems are with PREEMPT.

> Here's the oops (though it's from a tainted kernel, so I don't expect you to 
> even look at it ;-)).
> 
> I'm going to run with the patch you posted for a few weeks to see if it 
> happens again (just to tempt fate, I'll keep preempt enabled).

Okay, even better, please do tempt fate if you're willing, and let me
know if you get any "Bad rmap" or "Bad page state" messages (the more
the better from my point of view).  Though of course the nVidia means
it's not very likely that I'll be able to deduce much from the info.

Thanks,
Hugh
