Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWFWIXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWFWIXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWFWIXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:23:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:43153 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751103AbWFWIXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:23:13 -0400
Date: Fri, 23 Jun 2006 10:18:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kirill Korotaev <dev@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] sched: CPU hotplug race vs. set_cpus_allowed()
Message-ID: <20060623081815.GA919@elte.hu>
References: <449BA349.6040901@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449BA349.6040901@openvz.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5013]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill Korotaev <dev@openvz.org> wrote:

> Looks like there is a race between set_cpus_allowed() and 
> move_task_off_dead_cpu(). __migrate_task() doesn't report any err 
> code, so task can be left on its runqueue if its cpus_allowed mask 
> changed so that dest_cpu is not longer a possible target. Also, 
> chaning cpus_allowed mask requires rq->lock being held.
> 
> Signed-Off-By: Kirill Korotaev <dev@openvz.org>

good one!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
