Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUHJIhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUHJIhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUHJIhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:37:22 -0400
Received: from unthought.net ([212.97.129.88]:3009 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261987AbUHJIfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:35:54 -0400
Date: Tue, 10 Aug 2004 10:35:53 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
Message-ID: <20040810083553.GB27443@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	John Richard Moser <nigelenki@comcast.net>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
References: <4117D98C.2030203@comcast.net> <200408100042.37159.vda@port.imtp.ilyichevsk.odessa.ua> <41180443.9030900@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41180443.9030900@comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 07:09:55PM -0400, John Richard Moser wrote:
...
> Now, we could try another approach at this, below.
> 
> /* get_food(char **a)
> * Gets the current food.
> *
> * INPUT:
> *  - char **a
> *    Pointer to a pointer for the outputted food.
> * OUTPUT:
> *  - Return
> *    none.
> *  - *a
> *    Set to a copy of the current food.
> * PROCESS:
> *  - Set '*a' to a newly allocated block of memory containing a copy
> *    of the current food (global_food)
> * STATE CHANGE:
> *  none.
> */
...

There's just more to it than this.

Even in the almost "self explanatory" example you gave, even with your
suggested style of commenting, there are still problems:

Your comments do not describe who's responsible for allocating/freeing
which memory areas the various pointers point at.

Your get_food() function will cause a write at address 0 if malloc()
fails.

So, you have provided some good examples that no particular commenting
style is going to solve the common problems that all larger C software
projects face to some extent (memory management and error handling).

...
> These comment blocks are *MUCH* more verbose.

Agreed  :)

> They describe the process 
> loosely, but do give enough information to allow understanding without 
> questions.

That's where I disagree.

They do provide an illusion of knowledge though (for example, you did
not mention the built-in segfault mechanism, that was a hidden feature).

> The large amount of extra commentary is worth it, IMHO.

Comments are good.  Frequent comments are very good - if they are
correct and actually helpful.

I view it this way; if code is not commented, the only explanation is
that the author didn't feel it was worth commenting.  Code that is not
worth even a comment, should be removed from whatever project it is in,
to be replaced by something actually worth commenting.   (no, I'm not
bashing any particular part of the Linux kernel or anything like that -
this is my personal view for projects that I'm involved in).

However; comments are NOT a substitute for all the other aspects
required for good and reliable code.

Comments are one little part of the larger puzzle.  Ignoring their
importance is inexcusable - but they are not the magic silver bullet all
by themselves either.


My 0.02 Euro
 (as someone working on another large project that actually needs
  to run reliably)

-- 

 / jakob

