Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSFTXyo>; Thu, 20 Jun 2002 19:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSFTXyn>; Thu, 20 Jun 2002 19:54:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28147 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315941AbSFTXyk>;
	Thu, 20 Jun 2002 19:54:40 -0400
Message-ID: <3D126B28.16C88E2B@mvista.com>
Date: Thu, 20 Jun 2002 16:54:16 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: rml@tech9.net, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
References: <1024538711.921.85.camel@sinai>
		<20020619.190147.38450820.davem@redhat.com>
		<1024539334.917.110.camel@sinai> <20020619.192342.128398093.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Robert Love <rml@tech9.net>
>    Date: 19 Jun 2002 19:15:34 -0700
> 
>    Could there possibly be any interaction between SERIAL_BH and TIMER_BH?
> 
> Or the drivers... these are the questions that must be answered before
> we can consider the patch.
> 
> Also the TIMER_BH patch has to attend to the deliver_to_old_ones issue
> before it may be considered further.

Is the only network issue?  Is it possible that the network code uses bh_locking to protect against timers?  Moveing timers to softirqs would invalidate this sort of protection.  Is this an issue?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
