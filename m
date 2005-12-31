Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVLaLMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVLaLMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVLaLMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:12:20 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:36264 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751078AbVLaLMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:12:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Sat, 31 Dec 2005 22:12:03 +1100
User-Agent: KMail/1.9
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
References: <20051227190918.65c2abac@localhost> <20051231113446.3ad19dbc@localhost> <20051231115213.4a2e01ba@localhost>
In-Reply-To: <20051231115213.4a2e01ba@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512312212.03613.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 December 2005 21:52, Paolo Ornati wrote:
> On Sat, 31 Dec 2005 11:34:46 +0100
>
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> > > It is a patch against the 2.6.15-rc7 kernel and includes some other
> > > scheduling patches from the -mm kernels.
> >
> > Yes, this fixes both my test-case (transcode & little program), they
> > get priority 25 instead of ~16.
> >
> > But the priority of DD is now ~23 and so it still suffers a bit:
>
> I forgot to mention that even the others "interactive" processes
> don't get a good priority too.
>
> Xorg for example, while only moving the cursor around, gets priority
> 23/24. And when cpu-eaters are running (at priority 25) it isn't happy
> at all, the cursor begins to move in jerks and so on...

This is why Ingo, Nick and myself think that a tweak to the heavily field 
tested current cpu scheduler is best for 2.6 rather than any gutting and 
replacement of the interactivity estimator (which even though this scheme is 
simple and easy to understand, it clearly is an example of). Given that we 
have a "2.6 forever" policy, it also means any significant cpu scheduler 
rewrite, even just of the interactivity estimator, is nigh on impossible to 
implement.

Cheers,
Con
