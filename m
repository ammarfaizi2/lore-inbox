Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbUKIShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUKIShz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUKIShy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:37:54 -0500
Received: from [12.177.129.25] ([12.177.129.25]:11204 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261615AbUKISgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:36:22 -0500
Message-Id: <200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Blaisorblade <blaisorblade_spam@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       cw@f00f.org
Subject: Re: Synchronization primitives in UML (was: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty sighandler) 
In-Reply-To: Your message of "Tue, 09 Nov 2004 18:44:35 +0100."
             <200411091844.44218.blaisorblade_spam@yahoo.it> 
References: <200411052036.55541.blaisorblade_spam@yahoo.it> <20041106051306.GA3038@ccure.user-mode-linux.org>  <200411091844.44218.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Nov 2004 15:48:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it said:
> I also understand now what all this is for. When I have time for this,
> I'll at  least copy and paste your mail into a comment, with any
> needed adjustment.

That would be a good idea.

> For the semaphore issue, I have some ideas (like using futexes) which
> need to  be developed a bit:

> 1) I want to create a semaphore API in os_*. 
> 2) It will be able to use socketpairs. 
> 3) It will be able to use futexes, if they are
> non-persistant and usable  without too much issues (the same way we
> are going to support Async I/O). 
> 4) It will be used first by the code
> which could really benefit from the  performance increase.
> 5) It won't
> use persistant objects.

This all sounds good, although there are simplicity benefits to just using
one underlying mechanism, as long as there are no overriding disadvantages
to it.

> Any comment on these issues? Also, apart TT context switching, is
> there any  other performance-sensitive use of semaphores, which would
> benefit from using  futexes? 

Offhand, I think context switching is the most sensitive one.

> Yes, semget and friends are uglier.
> But don't think that the current nested code is simple to read - three
>  semaphores at a time, without a clear name, are not the clearer code
> on the  world. 

What nested code are you talking about?

				Jeff

