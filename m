Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWIBIIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWIBIIO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 04:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWIBIIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 04:08:14 -0400
Received: from colin.muc.de ([193.149.48.1]:2054 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750825AbWIBIIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 04:08:13 -0400
Date: 2 Sep 2006 10:08:11 +0200
Date: Sat, 2 Sep 2006 10:08:11 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Frank v Waveren <fvw@var.cx>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-ID: <20060902080811.GA15569@muc.de>
References: <1156927468.29250.113.camel@localhost.localdomain> <20060831204612.73ed7f33.akpm@osdl.org> <1157100979.29250.319.camel@localhost.localdomain> <20060901020404.c8038837.akpm@osdl.org> <1157103042.29250.337.camel@localhost.localdomain> <20060901201305.f01ec7d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901201305.f01ec7d2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if this is related to the occasional hrtimr_run_queues() lockup
> which Andi is encountering.

I'm not sure all of my lockups are related to this. It was just one
case I caught when the system was still usable enough to Sysrq

I did a bisect yesterday but i ended up in some /proc patches which
didn't look too likely. Repeating it currently.

-Andi

-- 
VGER BF report: H 0.000684748
