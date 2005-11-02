Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVKBOkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVKBOkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVKBOkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:40:25 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46278 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965053AbVKBOkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:40:24 -0500
Date: Wed, 2 Nov 2005 15:40:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rt1
Message-ID: <20051102144015.GA19845@elte.hu>
References: <20051030133316.GA11225@elte.hu> <1130876293.6178.6.camel@cmn3.stanford.edu> <1130899662.12101.2.camel@cmn3.stanford.edu> <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com> <1130900716.29788.22.camel@localhost.localdomain> <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com> <1130902342.29788.23.camel@localhost.localdomain> <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com> <20051102102116.3b0c75d1@mango.fruits.de> <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Carlos Antunes <cmantunes@gmail.com> wrote:

> > running the code i simply get:
> >
> > ~$ ./timing
> > Failed to create thread # 382

i suspect this is due to the stack ulimit being too high. Try something 
like 'ulimit -s 128', which will make it 128K, instead of the default 
8MB.

	Ingo
