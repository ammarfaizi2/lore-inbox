Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTLKNdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbTLKNdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:33:42 -0500
Received: from holomorphy.com ([199.26.172.102]:44517 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264944AbTLKNcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:32:13 -0500
Date: Thu, 11 Dec 2003 05:32:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031211133207.GE8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Anton Blanchard <anton@samba.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Mark Wong <markw@osdl.org>
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD8715F.9070304@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> It will get contention anyway if they're all pounding on the same futex.
>> OTOH, if they're all threads in the same process, they can hit other
>> problems. I'll try to find out more about hackbench.


On Fri, Dec 12, 2003 at 12:30:07AM +1100, Nick Piggin wrote:
> Oh, sorry I was talking about volanomark. hackbench AFAIK doesn't use
> futexes at all, just pipes, and is not threaded at all, so it looks like
> a different problem to the volanomark one.
> hackbench runs into trouble at large numbers of tasks too though.

Volano is all one process address space so it could be ->page_table_lock;
any chance you could find which spin_lock() call the pounded chunk of the
lock section jumps back to?


-- wli
