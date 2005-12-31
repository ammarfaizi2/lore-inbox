Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVLaEsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVLaEsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 23:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVLaEso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 23:48:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751298AbVLaEso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 23:48:44 -0500
Date: Fri, 30 Dec 2005 20:48:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
In-Reply-To: <1136001615.3050.5.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0512302047040.3249@g5.osdl.org>
References: <1135726300.22744.25.camel@mindpipe> 
 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> 
 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> 
 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu> 
 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe> 
 <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe> 
 <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe> 
 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>  <1135991732.31111.57.camel@mindpipe>
  <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org> <1136001615.3050.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Lee Revell wrote:
> 
> This increments rdp->count twice - is that intentional?

No. Just stupid. Remove the second one.

> Also what was the story deal with the commented out code?

You can't do it that way, since rcu_call_bh() will be called when calling 
rcu_do_batch() is not valid.

		Linus
