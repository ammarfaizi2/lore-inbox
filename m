Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTFKMLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTFKMLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:11:12 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:31919 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264396AbTFKMLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:11:11 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030611021030.GQ26270@dualathlon.random>
References: <200306041235.07832.m.c.p@wolk-project.de>
	 <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030611003356.GN26270@dualathlon.random>
	 <1055292839.24111.180.camel@tiny.suse.com>
	 <20030611010628.GO26270@dualathlon.random>
	 <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055334254.24111.209.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jun 2003 08:24:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 22:10, Andrea Arcangeli wrote:
> On Tue, Jun 10, 2003 at 09:57:11PM -0400, Chris Mason wrote:
> > Ok, I see your point, we don't strictly need the waited check.  I had
> > added it as an optimization at first, so that those who waited once were
> > not penalized by further queue_full checks. 
> 
> I could taste the feeling of not penalizing while reading the code but
> that's just a feeling, in reality if they blocked it means they set full
> by themself and there was no request so they want to go to sleep no
> matter ->full or not ;)

You're completely right, as the patch changed I didn't realize waited
wasn't needed anymore ;-)

Are you adding the hunk from yesterday to avoid unplugs when q->rq.count
!= 0?

-chris


