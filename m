Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTKIQFP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 11:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTKIQFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 11:05:15 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:24196 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262570AbTKIQFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 11:05:10 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 9 Nov 2003 08:05:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
In-Reply-To: <122840000.1068393498@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0311090801130.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Martin J. Bligh wrote:

> I think the confusing bit is this:
> 
> this_rq->prev_cpu_load[i] = rq_src->nr_running;
> 
> where "this_rq->prev_cpu_load[i]" doesn't intuitively look like what it
> means ;-) Even just 's/i/cpu/' would help a bit, or something (like 
> wrapping it in macros). Seems it is correct as was though - thanks for 
> explaining it.

Maybe something like:

 * We fend off statistical fluctuations in runqueue lengths by
 * saving the runqueue length (as seen by the balancing CPU) during the 
 * previous load-balancing operation and using the smaller one the current 
 * and saved lengths.


- Davide



