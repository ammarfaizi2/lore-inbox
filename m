Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934509AbWKYC4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934509AbWKYC4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 21:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934530AbWKYC4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 21:56:08 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:37069
	"EHLO saville.com") by vger.kernel.org with ESMTP id S934509AbWKYC4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 21:56:07 -0500
Message-ID: <4567B0CC.4030802@saville.com>
Date: Fri, 24 Nov 2006 18:56:12 -0800
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de> <20061124202514.GA7608@elte.hu>
In-Reply-To: <20061124202514.GA7608@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> 
> a new CPU is added. If the TSC isnt sync on SMP then it quickly gets 
> pretty messy, and we should rather take a look at /why/ these apps are 
> using RDTSC.
> 
> 	Ingo
> -

I use RDTSC in get a cheap method of measuring time. What other choices are
there for a low overhead high frequency time source?

By low overhead a kernel call is way to expensive, I want to minimally impact
the code and have many of these calls through out the code. One of the
ways I use it is to instrument multi-threaded applications and then use
the TSC to compare when actions occur between threads. i.e. I use it as a
time stamp counter and neither precision or accuracy is too important.
On the other hand the more precise and accurate the better:)

Cheers,

Wink Saville


