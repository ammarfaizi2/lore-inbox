Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVENGiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVENGiC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 02:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVENGiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 02:38:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19351 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262593AbVENGh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 02:37:57 -0400
Date: Sat, 14 May 2005 08:37:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does smp_reschedule_interrupt really reschedule?
Message-ID: <20050514063741.GA12217@elte.hu>
References: <1116008299.4728.19.camel@localhost.localdomain> <20050513182631.GA15916@elte.hu> <1116010280.4728.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116010280.4728.29.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> In finish_task_switch, where is need_resched set?

why should it be set? It's the final portion of a context-switch, not 
the initiator of a context-switch. need_resched is usually set by the 
wakeup code, or by the preemption code.

	Ingo
