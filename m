Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTFDK2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTFDK2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:28:37 -0400
Received: from ns.suse.de ([213.95.15.193]:55813 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263025AbTFDK2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:28:36 -0400
Date: Wed, 4 Jun 2003 12:42:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Message-ID: <20030604104215.GN4853@suse.de>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <Pine.LNX.4.55L.0305291609580.14835@freak.distro.conectiva> <20030604102241.GM3412@x30.school.suse.de> <200306041235.07832.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306041235.07832.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04 2003, Marc-Christian Petersen wrote:
> On Wednesday 04 June 2003 12:22, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > are you really sure that it is the right fix?
> > I mean, the batching has a basic problem (I was discussing it with Jens
> > two days ago and he said he's already addressed in 2.5, I wonder if that
> > could also have an influence on the fact 2.5 is so much better in
> > fariness)
> > the issue with batching in 2.4, is that it is blocking at 0 and waking
> > at batch_requests. But it's not blocking new get_request to eat requests
> > in the way back from 0 to batch_requests. I mean, there are two
> > directions, when we move from batch_requests to 0 get_requests should
> > return requests. in the way back from 0 to batch_requests the
> > get_request should block (and it doesn't in 2.4, that is the problem)
> do you see a chance to fix this up in 2.4?

Nick posted a patch to do so the other day and asked people to test.

-- 
Jens Axboe

