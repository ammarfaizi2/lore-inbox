Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbUCYTUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbUCYTUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:20:54 -0500
Received: from ns.suse.de ([195.135.220.2]:36528 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263519AbUCYTUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:20:53 -0500
Date: Thu, 25 Mar 2004 16:21:21 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: jun.nakajima@intel.com, ricklind@us.ibm.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040325162121.5942df4f.ak@suse.de>
In-Reply-To: <20040325190944.GB12383@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<20040325154011.GB30175@wotan.suse.de>
	<20040325190944.GB12383@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 20:09:45 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> also, the best place to do fork() blancing is not at
> wake_up_forked_process() time, but prior doing the MM copy. This patch
> does it there. At wakeup time we've already copied all the pagetables
> and created tons of dirty cachelines.

That won't help for threaded programs that use clone(). OpenMP is such a case.

-Andi
