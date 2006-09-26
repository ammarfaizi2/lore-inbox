Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWIZMCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWIZMCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIZMCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:02:07 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63110 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751194AbWIZMCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:02:04 -0400
Date: Tue, 26 Sep 2006 13:54:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
       Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 1/2] lockdep: lockdep_set_class_and_subclass
Message-ID: <20060926115404.GA18283@elte.hu>
References: <20060926113150.294656000@chello.nl> <20060926113748.089037000@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926113748.089037000@chello.nl>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Add lockdep_set_class_and_subclass() to the lockdep annotations.
> 
> This annotation makes it possible to assign a subclass on lock init. 
> This annotation is meant to reduce the _nested() annotations by 
> assigning a default subclass.
> 
> One could do without this annotation and rely on lockdep_set_class() 
> exclusively, but that would require a manual stack of struct 
> lock_class_key objects.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

thanks, this extension to lockdep.c looks good to me - provided it 
solves the problem :-)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
