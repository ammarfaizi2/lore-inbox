Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVHPNYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVHPNYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVHPNYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:24:55 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:58768 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965213AbVHPNYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:24:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Date: Tue, 16 Aug 2005 23:23:32 +1000
User-Agent: KMail/1.8.2
Cc: tony@atomide.com, tuukka.tikkanen@elektrobit.com, akpm@osdl.org,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org, ak@muc.de,
       george@mvista.com
References: <20050812201946.GA5327@in.ibm.com> <200508160230.52860.kernel@kolivas.org> <20050816131942.GD8608@in.ibm.com>
In-Reply-To: <20050816131942.GD8608@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508162323.33333.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005 23:19, Srivatsa Vaddagiri wrote:
> On Tue, Aug 16, 2005 at 02:30:51AM +1000, Con Kolivas wrote:
> > Time definitely was lost the longer the machine was running.
>
> I think I found the reason for time drift. Basically cur_timer->mark_offset
> doesnt expect to be called from non-timer interrupt handler. Hence it drops
> one jiffy from the lost count. I fixed this in some "crude" fashion and
> time has not drifted so far or is pretty much close to what it was in
> pre-smp version.  Will find a neat way to fix this and post a patch soon.
>
> > You mean disable it at runtime or not compile it in at all? Disabling it
> > at runtime caused what I described to you as PIT mode (long stalls etc).
>
> I think I have recreated this on a machine here. Disabling
> CONFIG_DYN_TICK_APIC at compile-time didnt seem to make any difference.
> Will look at this problem next.

Excellent. 

Mind you the APIC dyntick never really worked well on the pre-smp version on 
any hardware I tried it on so if you get both the APIC and PIT version 
working well you're doing great.

Thanks!
Con
