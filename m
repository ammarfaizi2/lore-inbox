Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUCaCaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 21:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUCaCaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 21:30:15 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:55133 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261680AbUCaCaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 21:30:12 -0500
Message-ID: <406A2D2E.3010601@yahoo.com.au>
Date: Wed, 31 Mar 2004 12:30:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Erich Focht <efocht@hpce.nec.com>,
       mbligh@aracnet.com, ak@suse.de, jun.nakajima@intel.com,
       ricklind@us.ibm.com, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [patch] new-context balancing, 2.6.5-rc3-mm1
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403300030.25734.efocht@hpce.nec.com> <4069384B.9070108@yahoo.com.au> <200403301204.14303.efocht@hpce.nec.com> <20040330030242.56221bcf.akpm@osdl.org> <20040330161438.GA2257@elte.hu> <20040330161910.GA2860@elte.hu> <20040330162514.GA2943@elte.hu> <20040330210312.GA6706@elte.hu>
In-Reply-To: <20040330210312.GA6706@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've attached sched-balance-context.patch, which is the current version
> of fork()/clone() balancing, against 2.6.5-rc3-mm1.
> 
> Changes:
> 
>  - only balance CLONE_VM threads
> 
>  - take ->cpus_allowed into account when balancing.
> 
> i've checked kernel recompiles and while they didnt hurt from fork()
> balancing on an 8-way SMP box, i implemented the thread-only balancing
> nevertheless.

You'd probably want to be testing on a NUMA to bring out any
problems.
