Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVDKInk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVDKInk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVDKInj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:43:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44264 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261729AbVDKImh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:42:37 -0400
Date: Mon, 11 Apr 2005 10:42:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050411084217.GA9784@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A02F64C64@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A02F64C64@orsmsx407>
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


* Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:

> >OTOH, deadlock detection is another issue. It's quite expensive and i'm
> >not sure we want to make it a runtime thing. But for fusyn's deadlock
> >detection and safe teardown on owner-exit is a must-have i suspect?
> 
> Not really. Deadlock check is needed on PI, so it can be done at the 
> same time (you have to walk the chain anyway). In any other case, it 
> is an option you can request (or not).

well, i was talking about the mutex code in PREEMPT_RT. There deadlock 
detection is an optional debug feature. You dont _have_ to do deadlock 
detection for the kernel's locks, and there's a difference in 
performance.

	Ingo
