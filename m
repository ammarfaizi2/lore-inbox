Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUH3UPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUH3UPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUH3UPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:15:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8955 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268904AbUH3UP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:15:27 -0400
Date: Mon, 30 Aug 2004 22:15:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: What policy for BUG_ON()?
Message-ID: <20040830201519.GH12134@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me try to summarize the different options regarding BUG_ON, 
concerning whether the argument to BUG_ON might contain side effects, 
and whether it should be allowed in some "do this only if you _really_ 
know what you are doing" situations to let BUG_ON do nothing.

Options:
1. BUG_ON must not be defined to do nothing
1a. side effects are allowed in the argument of BUG_ON
1b. side effects are not allowed in the argument of BUG_ON
2. BUG_ON is allowed to be defined to do nothing
2a. side effects are allowed in the argument of BUG_ON
2b. side effects are not allowed in the argument of BUG_ON

It would be good if there was a decision which of the four choices 
should become documented policy.


<--  snip  -->

My personal opinions:

IMHO, 1b doesn't make much sense, since in the case of 1. side effects 
are never a problem.

IMHO, 2b is bad since it might cause nasty heisenbugs if BUG_ON does  
nothing, and preserving the side effects is easy.

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

