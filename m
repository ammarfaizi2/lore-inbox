Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbVGADpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbVGADpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 23:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbVGADpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 23:45:44 -0400
Received: from colo.tr0n.com ([66.207.132.11]:7096 "EHLO tr0n.com")
	by vger.kernel.org with ESMTP id S263206AbVGADp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 23:45:26 -0400
Message-ID: <42C4BC11.1000005@nauticom.net>
Date: Thu, 30 Jun 2005 23:44:17 -0400
From: Chet Hosey <chosey@nauticom.net>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <200506300141.j5U1f5Hm004913@laptop11.inf.utfsm.cl>
In-Reply-To: <200506300141.j5U1f5Hm004913@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

I think you probably meant to reply publicly. I'm taking the liberty of
CC'ing the two mailing lists to which I'd replied.

>Chet Hosey <chosey@nauticom.net> wrote:
>  
>
>
>>The point of such ventures is that by placing features at a lower level you get to keep the advantages of UNIX in the first place
>>    
>>
>
>You mean "simple interfaces", "elegance of design", "one way to do each
>thing", "tools that can be endlessly combined"? You are advocating throwing
>all that out the window, for no discernible gain.
>
>  
>
No, I'm not. I'm saying that implementing features which cannot be
utilized by core UNIX utilities limits the utility of those features.
How can tools be "endlessly combined" when they can't interact with the
objects that a GUI _insists_ are there?

>>                                                          -- namely,
>>that many small tools can do neat things with most objects. By placing
>>everything in a largish userspace library instead of at a system level
>>(kernel, libc, etc.) you're essentially saying that, for instance, vi
>>would have to be rewritten in order to interact with objects presented
>>by the VFS. So would bash, fmt, sort, less, aspell, or anything else
>>that can open a file. You'd end up with a situation in which you see
>>objects via the VFS browser (file manager) that no longer exist when you
>>want to drop to a shell to use common UNIX utilities and find that the
>>object doesn't actually exist to the OS itself.
>>    
>>
>
>So what? Files can get deleted under your feet right now too.
>
>  
>
What does a file disappearing have to do with an inconsistent UI? The
fact that files can get deleted isn't an inconsistency. It's the fact
that the filesystem behaves differently based on the interface chosen
(GUI vs. command-line), and that's a bad thing. If you delete a file,
it's gone everywhere. If it were gone in one place but still present in
another view of the same directory your analogy would hold more water.

>>This sounds like Joel Spolsky's law of leaky abstractions,
>>    
>>
>
>So what?
>
>  
>
The problem is that when an abstraction is implented in a way that isn't
complete, the interface suffers and unexpected behavior results. If you
don't see this as a problem, that's fine -- however, those who value a
decent user interface might disagree. I can only speak for myself, and I
think it's an inelegant solution.

If it *looks* like the VFS as much as possible, but suddenly behaves
differently under various circumstances, it's not a perfect solution.
Worse, it's misleading.

>>                                                           and the fact
>>that most operating systems lack a useful facility (which is why GNOME
>>and KDE roll their own VFS) sounds like a poor excuse for keeping useful
>>features out of the kernel.
>>    
>>
>
>That some feature is useful, or could possibly be useful, is /no/ reason to
>implement it in the kernel, or anywhere else for that matter. The kernel,
>together with assorted libraries and programming languages, offers
>programmers useful abstractions (like computing with hyperbolic functions
>or futzing around with GUIs). Defining exactly where you implement your
>abstraction is the job of a software architect (or some such). Just
>shouting "Place it in the kernel!" (or, for that matter, "Implement
>everything in userland!") is counterproductive. The first leads to bloat,
>the second to the microkernel mess. Find out /where/ it is easiest, most
>flexible, ... to place, and put it there. Chance is, it won't be the
>kernel.
>
>  
>
See my explanation that I'm not advocating placing bad things into the
kernel, only arguing against high-level VFS implementations that present
a view that cannot be used by core UNIX tools. Wait for it...

>>I'm *not* arguing for putting anything specific into the kernel. I *am*
>>arguing that an inconsistent presentation in which some apps see VFS
>>objects and others don't makes for a less-than-ideal UI.
>>    
>>
>
>Finding out which is the simplest, most natural way to do something is
>/very/ hard work. Problem is, if done right it later seems obvious. That
>there is a mess in some area means just that the "right" way to do it has
>not yet been found. Placing some half-baked solution in the kernel won't
>help at all, quite the contrary.
>  
>
...and you totally missed the point anyways. The point isn't that you
should be shoving garbage into the kernel; the point is that high-level
GUI-based VFS kludges shouldn't be seen as a complete solution.

