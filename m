Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTDXOqn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTDXOqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:46:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7944 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261305AbTDXOqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:46:42 -0400
Date: Thu, 24 Apr 2003 07:59:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <1051174641.1385.4.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0304240745531.20549-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Apr 2003, Arjan van de Ven wrote:
> 
> The "hot" issue is partially this part of the GPL:
> 
> For an executable work, complete source code means all the source code
> for all modules it contains, plus any associated interface definition
> files, plus the scripts used to control compilation and installation of
> the executable.
> 
> where it seems to say that if you need a script to be able to usefully
> install a self compiled kernel, that script is part of "the sourcecode".

Yes, that's the part that can be read pretty much any way depending on 
your mood swings. 

In particular, just how far does "installation" go? Clearly it doesn't 
require that you give people ROM masks and soldering irons. Well, clearly 
to _me_ anyway.

So you while you _logically_ may be able to take it to the absurd end
("you need to build me a fab, and make it under the GPL, so that I can
'install' the kernel on the chips"), I'm personally very much against that 
kind of absurdity.

For example, I don't use the Makefile targets to physically install my 
kernels - I end up doing that by hand, with a few "cp -f ..." things. Does 
that mean that I'm in violation of the GPL when I give the end result out 
to somebody? I'd say "clearly not". 

Don't get me wrong - I don't particularly like magic hardware that only 
boots signed kernels for some nefarious reasons. But I bet that pretty 
much _every_ embedded Linux project will have special tools to do the 
"final install", and I can't for the life of me take the logic that far. 

That's _doubly_ true as many of the installs are quite benign, and I see a
lot of good reasons to sign kernel binaries with your own private key to
verify that nobody else has exchanged it with a kernel that is full of
trojans. One environment where you might want to do something like that is
open access machines at a university, for example. You bolt the machines 
down, and you make sure that they don't have any trojans - and _clearly_ 
that has to be allowed by the license.

But such a "make the machines be something the _users_ can trust" is 100%
indistinguishable from a technical standpoint from something where you
"make the machine something that Disney Corp can trust". There is _zero_
technical difference. It's only a matter of intent - and even the intent
will be a matter of interpretation.

This is why I refuse to disallow even the "bad" kinds of uses - because 
not allowing them would automatically also mean that "good" uses aren't 
allowed.

Another way of saying it: I refuse to have some license amendment that
starts talking about "intent" and "user vs corporations" crap and "moral 
rights" etc. I think the GPL is too politicised already, I'd rather have 
it _less_ "crazy talk" than more.

				Linus

