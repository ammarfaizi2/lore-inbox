Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTLSPGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 10:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTLSPGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 10:06:44 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:48042 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263299AbTLSPGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 10:06:43 -0500
Date: Fri, 19 Dec 2003 07:06:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [PATCH] improve rwsem scalability (was Re: [CFT][RFC] HT scheduler)
Message-ID: <35510000.1071846377@[10.10.2.4]>
In-Reply-To: <3FE2E67A.70809@cyberone.com.au>
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au> <3FD91F5D.30005@cyberone.com.au> <Pine.LNX.4.58.0312120440400.14103@devserv.devel.redhat.com> <3FDA5842.9090109@cyberone.com.au> <3FDBB261.5010208@cyberone.com.au> <3FDFE95C.9050901@cyberone.com.au> <3FE2E67A.70809@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What do you think? Is there any other sorts of benchmarks I should try?
>> The improvement I think is significant, although volanomark is quite
>> erratic and doesn't show it well.
>> 
>> I don't see any problem with moving the wakeups out of the rwsem's 
>> spinlock.
>> 
> 
> Actually my implementation does have a race because list_del_init isn't
> atomic. Shouldn't be difficult to fix if anyone cares about it... otherwise
> I won't bother.

If you can fix it up, I'll get people here to do some more testing on the
patch on other benchmarks, etc.

M.

