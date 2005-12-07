Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVLGNHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVLGNHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVLGNHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:07:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22433 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751031AbVLGNHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:07:33 -0500
Date: Wed, 7 Dec 2005 14:06:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
       johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <20051207113324.GA28646@elte.hu>
Message-ID: <Pine.LNX.4.61.0512071401110.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de>
 <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu>
 <4396B81E.4030605@yahoo.com.au> <20051207104900.GA26877@elte.hu>
 <4396C2EB.1000203@yahoo.com.au> <20051207113324.GA28646@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2005, Ingo Molnar wrote:

> maybe 'struct timer' and 'struct hrtimer' is the right solution after 
> all, and our latest queue doing 'struct timer_list' + 'struct hrtimer' 
> is actually quite close to it.
> 
> 'struct ptimer' does have a bit of vagueness in it at first sight, do 
> you agree with that? (does it mean 'process'? 'posix'? 'precision'?) 
> 
> also, hrtimers on low-res clocks do have high internal resolution, but 
> they are not precise timing mechanisms in the end, due to the low-res 
> clock. So the more generic name would be 'high-resolution timers', not 
> 'precision timers'. (also, the name 'precision timers' sounds a bit 
> funny too, but i dont really know why.)

My ptimer suggestion was based on your "funny" name "high-precision 
timer". Sorry Ingo, that joke is on you. :-)
Anyway, anything else than ktimer is fine with me.

bye, Roman
