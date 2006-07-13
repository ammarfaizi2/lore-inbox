Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWGMJdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGMJdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWGMJdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:33:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:2232 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964867AbWGMJdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:33:14 -0400
Date: Thu, 13 Jul 2006 11:24:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Albert Cahalan <acahalan@gmail.com>
Cc: torvalds@osdl.org, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, bunk@stusta.de, akpm@osdl.org,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
Message-ID: <20060713092432.GA11812@elte.hu>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <20060713070445.GA30842@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713070445.GA30842@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5005]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> utrace enables something like 'transparent live debugging': an app 
> crashes in your distro, a window pops up, and you can 'hand over' a 
> debugging session to a developer you trust. Or you can instruct the 
> system to generate a coredump. Or you can generate a shorter summary 
> of the crash, sent to a central site.

not to mention that utrace could be used to move most of the ELF 
coredumping code out of the kernel. (the moment you have access to all 
crashed threads userspace can construct its own coredump - instead of 
having the kernel construct a coredump file) Roland's patch does not go 
as far yet, but it could be a possible target.

	Ingo
