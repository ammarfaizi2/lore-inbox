Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWBPRWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWBPRWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWBPRWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:22:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56792 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932321AbWBPRWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:22:02 -0500
Date: Thu, 16 Feb 2006 18:20:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-ID: <20060216172007.GB29151@elte.hu>
References: <20060215151711.GA31569@elte.hu> <20060216145823.GA25759@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216145823.GA25759@linuxtv.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Johannes Stezenbach <js@linuxtv.org> wrote:

> Anyway: If a process can trash its robust futext list and then die 
> with a segfault, why are the futexes still robust? In this case the 
> kernel has no way to wake up waiters with FUTEX_OWNER_DEAD, or does 
> it?

that's memory corruption - which robust futexes do not (and cannot) 
solve. Robustness is mostly about handling sudden death (e.g. which is 
due to oom, or is due to a user killing the task, or due to the 
application crashing in some non-memory-corrupting way), but it cannot 
handle all possible failure modes.

	Ingo
