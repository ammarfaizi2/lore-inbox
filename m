Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVHBME7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVHBME7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVHBME6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:04:58 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:58816 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261463AbVHBME1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:04:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Tue, 2 Aug 2005 22:04:04 +1000
User-Agent: KMail/1.8.2
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
References: <200508021443.55429.kernel@kolivas.org> <200508022054.22276.kernel@kolivas.org> <20050802113137.GK15903@atomide.com>
In-Reply-To: <20050802113137.GK15903@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508022204.05562.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 21:31, Tony Lindgren wrote:
> * Con Kolivas <kernel@kolivas.org> [050802 03:54]:
>
> > I need to ask you why you think limiting the maximum Hz is a bad idea? On
> > a laptop, say we have set the powersave governor, we have already told
> > the kernel we are interested in maximising power saving at the expense of
> > performance. Would it not be appropriate for this to be linked in a way
> > that sets maximum Hz to some value that maximises power save (whatever
> > that value is) at that time?
>
> With dyntick the system will run at max HZ only when busy. It is possible
> that cutting down max HZ might cause some savings while busy, but I would
> assume the savings are minimal.
>
> I personally prefer to have the performance available when needed, and
> max savings while idle.

That's what I felt too but wasn't sure about the power saving. However what 
you say makes complete sense; if the machine is loaded then the extra power 
overhead of 1000 vs 100 ticks is meaningless, but throughput may be of 
concern. However I managed to get it booted on my p4 at home and while I'm 
using it under load I find it rarely gets to 1000Hz during realistic loads. 
I'll be posting a fresh patch shortly with the last few cleanups I could 
find, that I'm now running on 2.6.13-rc5.

Cheers,
Con
