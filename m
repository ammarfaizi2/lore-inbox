Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTFKB5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTFKB5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:57:10 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35050
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263945AbTFKB5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:57:10 -0400
Date: Wed, 11 Jun 2003 04:10:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
Message-ID: <20030611021030.GQ26270@dualathlon.random>
References: <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com> <20030611003356.GN26270@dualathlon.random> <1055292839.24111.180.camel@tiny.suse.com> <20030611010628.GO26270@dualathlon.random> <1055296630.23697.195.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055296630.23697.195.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 09:57:11PM -0400, Chris Mason wrote:
> Ok, I see your point, we don't strictly need the waited check.  I had
> added it as an optimization at first, so that those who waited once were
> not penalized by further queue_full checks. 

I could taste the feeling of not penalizing while reading the code but
that's just a feeling, in reality if they blocked it means they set full
by themself and there was no request so they want to go to sleep no
matter ->full or not ;)

Andrea
