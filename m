Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWAANl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWAANl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 08:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWAANl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 08:41:28 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:59645 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932207AbWAANl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 08:41:28 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Reed <bradreed1@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060101115121.034e6bb7@galactus.example.org>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <20060101115121.034e6bb7@galactus.example.org>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 08:41:16 -0500
Message-Id: <1136122876.6039.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 11:51 +0200, Bradley Reed wrote:

> And you could have saved the time and effort of replying, as you had
> nothing useful to say. Why do you expect kernel users (non-developers) 
> to jump through hoops and cripple their systems in order to provide bug
> reports? Exactly how could I have tested MPLayer realistically without
> Xv support? It isn't that easy to swap video cards in a laptop.

Hi Bradley,

I never even noticed that it was a tainted kernel.  But you did have a
same problem as someone without it.  I too have two machines with NVidia
cards that are not very useful without the binary drivers. Thus the next
two machines I bought (a server, and a laptop) I made damn well that it
didn't have a NVidia card in them (I used to be a devoted NVidia
consumer, now I'm a frustrated one).

The reason that I will no long run test kernels with NVidia is that that
module has caused more bugs than I could stand.  __Especially__ with the
-rt patch.  I'm very surprised that you actually have the nvidia module
working with that patch, since it does things that the nvidia module
doesn't even know about.  I gave up trying to modify the nvidia stuff to
work with the -rt patch almost a year ago.  Too much black magic going
on in the binary part.

> 
> I noticed that after trying a new kernel a user space tool, which
> worked fine under earlier kernels, was no longer working. Linus himself
> said that this is worth pointing out. I did so. 

I agree that it is good to point it out, even if it was just a
coincidence that you had the same problem with someone that didn't have
a tainted kernel.  It did help me to know exactly where the bug was.
But don't be surprised if someone tells you to try it without the
tainting module before they look any further.  If you say you can't,
then they very well might just ignore your post.

> 
> Yes, I was very fortunate in that someone else with a non-tainted
> kernel noticed a similar bug with /dev/rtc, and even more fortunate
> that Steven Rostedt provided a patch that worked for both of us. As I
> had said in my original post I was not expecting that, but thought the
> bug was worth reporting.
> 
> DO YOU REALLY PREFER USERS NOT REPORT BUGS?

I say 'no', I don't want users to _not_ report bugs.  Even if it
increases the noise out there.  It's up to the developer to decide if
they want to look further, or just tell the user "sorry, I can't waste
my time if there's a chance that the problem is in code I can't see".

Cheers,

-- Steve


