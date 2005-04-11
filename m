Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVDKI6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVDKI6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVDKI6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:58:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61674 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261739AbVDKI61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:58:27 -0400
Date: Mon, 11 Apr 2005 10:57:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050411085737.GA11109@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A02F64C65@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A02F64C65@orsmsx407>
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

> Let me re-phrase then: it is a must have only on PI, to make sure you 
> don't have a loop when doing it. Maybe is a consequence of the 
> algorithm I chose. -However- it should be possible to disable it in 
> cases where you are reasonably sure it won't happen (such as kernel 
> code). In any case, AFAIR, I still did not implement it.

are there cases where userspace wants to disable deadlock-detection for 
its own locks?

the deadlock detector in PREEMPT_RT is pretty much specialized for 
debugging (it does all sorts of weird locking tricks to get the first 
deadlock out, and to really report it on the console), but it ought to 
be possible to make it usable for userspace-controlled locks as well.

	Ingo
