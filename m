Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTLKNXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTLKNXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:23:09 -0500
Received: from holomorphy.com ([199.26.172.102]:38885 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264928AbTLKNXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:23:07 -0500
Date: Thu, 11 Dec 2003 05:23:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031211132301.GD8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Anton Blanchard <anton@samba.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Mark Wong <markw@osdl.org>
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD86C70.5000408@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> If this thing is heavily threaded, it could be mm->page_table_lock.

On Fri, Dec 12, 2003 at 12:09:04AM +1100, Nick Piggin wrote:
> I'm not sure how threaded it is, probably very. Would inline spinlocks
> help show up mm->page_table_lock?
> It really looks like .text.lock.futex though, doesn't it? Would that be
> the hashed futex locks? I wonder why it suddenly goes downhill past about
> 140 rooms though.

It will get contention anyway if they're all pounding on the same futex.
OTOH, if they're all threads in the same process, they can hit other
problems. I'll try to find out more about hackbench.


-- wli
