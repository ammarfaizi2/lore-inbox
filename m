Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUIHC7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUIHC7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUIHC7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:59:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:17656 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269008AbUIHC71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:59:27 -0400
Subject: Re: [patch 2/2] cpu hotplug notifier for updating sched domains
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <413E6C49.5080106@cyberone.com.au>
References: <200409071849.i87Inw3f143238@austin.ibm.com>
	 <413E55D8.8030608@cyberone.com.au> <1094608996.8015.5.camel@booger>
	 <413E6C49.5080106@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1094612104.10229.25.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 21:55:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 21:19, Nick Piggin wrote:
> Nathan Lynch wrote:
> 
> >On Tue, 2004-09-07 at 19:44, Nick Piggin wrote:
> >>and get rid of everywhere I had been doing cpus_and(tmp, ..., 
> >>cpu_online_map).
> >>
> 
> ^^^ This should still be done, of course. That can come later.
> 
> >>This may also make your patch 1/2 unnecessary? What do you think?
> >>
> >
> >Well, we have to "lie" to arch_init_sched_domains a little bit when
> >bringing a cpu online, by setting the soon-to-be-online cpu's bit in the
> >argument mask.  So I think the first patch is still necessary.
> >
> >
> 
> Can't we do everything in the CPU_UP_ONLINE case though?

I guess I overlooked that possibility.  I'll give it a try.  If it works
ok, the first patch can go.

Nathan

